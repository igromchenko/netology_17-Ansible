variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "os_image" {
  type    = string
  default = "centos-7"
}

variable "os_user" {
  type    = string
  default = "centos"
}

variable "vm_platform" {
  type = string
  default = "standard-v1"
}

variable "vm_spec" {
  type        = list(object({vm_name=string, cpu=number, ram=number, disk=number}))
  default     = [
    { vm_name = "clickhouse", cpu = 2, ram = 4, disk = 10 },
    { vm_name = "vector", cpu = 2, ram = 4, disk = 10 },
    { vm_name = "lighthouse", cpu = 2, ram = 2, disk = 10 }
  ]
}

variable "test_mode" {
  type = bool
  default = true
}
