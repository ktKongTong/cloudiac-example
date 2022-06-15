terraform {
    required_providers {
        ansible = {
            source = "nbering/ansible"
            version = "1.0.4"
        }
        alicloud = {
            source = "aliyun/alicloud"
            version = "1.171.0"
        }
    }
}