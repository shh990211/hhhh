variable "ec2_tags" {
  default     = {}
}


variable "vpc_id" {
  default     = {}
}

variable "sg_rule" {
  default     = {}
}

variable "all_ip" {
  default     = {}
}

variable "ec2_instance" {
  default     = {}
}

variable "ec2_type" {
  default     = {}
}

variable "ami" {
  default     = {}
}

variable "key_name" {
  default     = {}
}

variable "subnet_id" {
  default     = {}
}

variable "volume_type" {
  default     = "gp3"
}

variable "volume_size" {
  default     =  {} 
}

variable "ingresslist" {
  default     = {}
}
variable "iam" {
  default     = "EC2instance"
}
