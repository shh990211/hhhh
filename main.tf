locals {
  vpc_tag                       = "${var.tag1}-${var.tag2}-vpc"
  ami                           = "ami-067c3d59aa0bcc740"
  key_name                      = "zabbix"
  ec2_type                      = "t3a.micro"
  ec2_data                      = {
    aaaaa                       = {
        ec2_tags                = "${var.tag1}-${var.service_type[0]}-ec2"
        ebsvolume_size          = "100"
        ingress                 = ["80","22"]
    }
    bbbbb                       = {
        ec2_tags                = "${var.tag1}-${var.service_type[1]}-ec2"
        ebsvolume_size          = "100"
        ingress                 = ["80","443"]
    }
    ccccc                       = {
        ec2_tags                = "${var.tag1}-${var.service_type[2]}-ec2"
        ebsvolume_size          = "200"
        ingress                 = ["443","22"]
    }
  }
}

module "vpc" {
    source                      = "./vpc"
    vpc_tag                     = local.vpc_tag
    cidr                        = var.cidr
    cidr_block                  = var.cidr_block
    route_block                 = var.route_block
}

module "ec2" {
    for_each                    = local.ec2_data
    source                      = "./ec2"
    ami                         = local.ami
    ec2_tags                    = each.value["ec2_tags"]
    vpc_id                      = module.vpc.vpc_id
    sg_rule                     = var.sg_rule
    all_ip                      = var.all_ip
    ec2_instance                = var.ec2_instance
    ec2_type                    = local.ec2_type
    subnet_id                   = module.vpc.subnet_id
    volume_size                 = each.value["ebsvolume_size"]
    ingresslist                 = each.value["ingress"]
    key_name                    = local.key_name
}
