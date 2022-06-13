provider "alicloud" {
    region  = "cn-beijing"
}

data "alicloud_zones" "default" {
 available_disk_category = "cloud_efficiency"
 available_resource_creation = "VSwitch"
}
# 安全组
resource "alicloud_security_group" "group" {
    name = "tf_ecs_test_security_group"
    vpc_id = alicloud_vpc.vpc.id
}
# 安全组规则
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}
# VPC
resource "alicloud_vpc" "vpc" {
    vpc_name = var.name
    cidr_block = "172.16.0.0/16"
}
# 交换机
resource "alicloud_vswitch" "vswitch" {
    vpc_id = alicloud_vpc.vpc.id
    cidr_block = "172.16.0.0/24"
    zone_id = data.alicloud_zones.default.zones[0].id
    vswitch_name = var.name
}
// 密钥对
resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = var.key_name
  public_key    = var.public_key
}
# ECS
resource "alicloud_instance" "web" {
    // 可用区
    availability_zone = var.zone
    // 安全组
    security_groups  = alicloud_security_group.group.*.id
    // 实例类型
    instance_type = "ecs.t5-c1m1.xlarge"
    # 系统盘类型
    system_disk_category  = "cloud_efficiency"
    system_disk_name   = "test_ecs_disk"
    # 镜像id 
    image_id = "centos_7_6_x64_20G_alibase_20211130.vhd"
    # 实例名称 
    instance_name = "ali-test-1"
    # 计费方式，后付费
    instance_charge_type = "PostPaid"
    # 计费策略，按量付费
    spot_strategy ="SpotAsPriceGo"
    # 密码 
    # password = "Lxf121314!"
    key_name = alicloud_ecs_key_pair.default.key_name
    # 交换机id 
    vswitch_id = alicloud_vswitch.vswitch.id
    # 峰值带宽
    internet_max_bandwidth_out = 0
    # 数量
    count = var.instance_number
}


// 使用弹性IP
resource "alicloud_eip_address" "eip" {
}

// 关联弹性IP到实例
resource "alicloud_eip_association" "eip_asso" {
  allocation_id = alicloud_eip_address.eip.id
  count = var.instance_number
  instance_id = alicloud_instance.web[count.index].id
}


# ansible_host
resource "ansible_host" "web" {
  count = var.instance_number
  // 配置机器的 hostname，一般配置为计算资源的 public_ip (或 private_ip)
  // inventory_hostname = alicloud_instance.web[count.index].public_ip
  inventory_hostname = alicloud_eip_address.eip.ip_address
  // 配置机器所属分组
  groups = ["web"]
  // 传给 ansible 的 vars，可在 playbook 文件中引用
  vars = {
    wait_connection_timeout = 120
  }
}
