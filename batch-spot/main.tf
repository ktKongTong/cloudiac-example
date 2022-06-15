provider "alicloud" {
    region  = "cn-beijing"
}

data "alicloud_vswitches" "default" {
  cidr_block = "192.168.0.0/24"
  vswitch_name = "slb-test"
}
data "alicloud_security_groups" "default" {
  name_regex  = "slb-test"
}

data "alicloud_instance_types" "default" {
  // 可用区
  availability_zone = data.alicloud_vswitches.default.vswitches.0.zone_id
  cpu_core_count = var.cpu_core_count
  memory_size    = var.memory_size
}
# ECS
resource "alicloud_instance" "instance" {
    # 数量
    count = var.instance_number
    // 实例类型
    instance_type = data.alicloud_instance_types.default.ids.0
    // 安全组
    security_groups  = [data.alicloud_security_groups.default.groups.0.id]
    # 交换机id 
    vswitch_id = data.alicloud_vswitches.default.vswitches.0.id
    # 镜像id 
    image_id = var.image_id
    # 实例名称 
    instance_name = "example-with-eips"
    # 计费方式，后付费
    instance_charge_type = "PostPaid"
    # 计费策略，按量付费，竞价抢占
    spot_strategy ="SpotAsPriceGo"
    # 峰值带宽
    internet_max_bandwidth_out = 0
    # 系统盘类型
    system_disk_category  = "cloud_efficiency"
    system_disk_name   = "test_ecs_disk"
}