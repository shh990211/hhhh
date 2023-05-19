variable "tag1" {
    default = "gehc-709"
}

variable "tag2" {
    default = "test"
}

variable "service_type" {
    default = ["aaaaa","bbbbb","ccccc"]
}

variable "cidr" {
    default = "192.168.192.0/24"
}

variable "cidr_block" {
    default = ["192.168.192.0/25","192.168.192.128/25"]
}

variable "route_block" {
    default = "0.0.0.0/0"
}

 variable "ingresslist" {
    default = {}
 }

 variable "sg_rule" {
    default = ["192.168.192.0/24"]
 }
  variable "ec2_instance" {
    default = "1"
  }

  variable "all_ip" {
    default = ["0.0.0.0/0"]
  }