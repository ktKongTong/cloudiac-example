// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = alicloud_instance.instance[count.index].id
}