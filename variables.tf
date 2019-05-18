variable "vsphere_user" {
    type = "string"
    default = "DEFAULT_USERNAME"
}
variable "vsphere_password" {
  type = "string"
  default = "DEFAULT_PASSWORD"
}
variable "vsphere_server" {
  type = "string"
  default = "VCENTER_SERVER"
}

variable "privatekey_file" {
  type = "string"
  default = "FILE_PATH"
}

variable "data_center" {
  type = "string"
  default = "LocalDC"
}

variable "data_store" {
  type = "string"
  default = "datastore1"
}

variable "resource_pool" {
  type = "string"
  default = "Internal/Resources"
}

variable "vds_network" {
  type = "string"
  default = "Server Network"
}

variable "template_name" {
  type = "string"
  default = "Template - Ubuntu 16 Server"
}

variable "vm_ipaddress" {
  type = "string"
  default = "10.1.1.88"
}

variable "vm_name" {
  type = "string"
  default = "linuxvm1"
}
