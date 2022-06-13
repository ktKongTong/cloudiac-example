variable "name" {
 default = "auto_provisioning_group"
}
variable "instance_number" {
  default = 1
}

variable "region" {
  default = "cn-beijing"
}

variable "zone" {
  default = "cn-beijing-a"

}


variable "instance_type" {
  default = "ecs.t5-lc2m1.nano"
  description = "实例规格"
}
variable "key_name" {
  default = "cloudiac-ecs"
  description = "密钥对名称"
}
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD0XNVETdNvK+dgndxYB2CWp7lxZwvfuR2LRxXtkOvtHiVFq4Eqcf8TfLso9DEQVxw0nywAJ3PF046zrVr9iLJ5d3a5wyjxyR9S/EF3jR9JEfCc1kViQDQAtNhp7wSpfr5KPEKpkjpMTktnB0BYIjbytKd9rSK8vL71KlKDD7jd5BVZoASo5rEZO/FB3a/2rAMYeYC7WJ4I30UCC0BnIAyodV7Dabo2pxs/S5RhIHypUiMfqA85D/nH2qZ1rHJMxXC0oKH3HmwhtMhuinvhiilPaxGwCI014fbthlJYFIuO8jrCTaof+Q6eqqhwLGnt32ERNh6dbpzYbyDgr+U96VXOcOZDYOf6WbrrGndd5sonCE72SSXWum6YKKXWFlc9cHlFP/P9+ZJIrDKG2Xyk2dH5USYF7rUYRgHR2c3qBqpj8x2IKpuLsLlKSVKEddD0M9CEd7EPU2ul4lfobsCWrY91wbr3wJZTlkDWb90VYFerkWjDy7D+lB36gjYB6tPNbS0= 23709@DESKTOP-SVOI94K"
  description = "公钥"
}

variable "vpc_name" {
}

variable "cidr_block" {
}

variable "image_id" {
  default = "centos_7_6_x64_20G_alibase_20211130.vhd"
  description = "镜像id"
}
variable "sg_name" {
  default = "tf_ecs_test_security_group"
  description = "安全组名称"
}
variable "instance_name" {
  default = "ali-test-1"
  description = "计算实例名称"
}