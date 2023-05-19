resource "aws_security_group" "security_group" {
    name                    = "${var.ec2_tags}-security_group"
    vpc_id                  = var.vpc_id
    description             = "test"
    tags = {
        Name                = "${var.ec2_tags}-security_group"
    }
}

resource "aws_security_group_rule" "sgri" {
    count                   = length(var.ingresslist)
    security_group_id       = aws_security_group.security_group.id
    type                    = "ingress"
    from_port               = element(var.ingresslist,count.index)
    to_port                 = element(var.ingresslist,count.index)
    protocol                = "tcp"
    cidr_blocks             = var.sg_rule
    depends_on              = [aws_security_group.security_group]
}

resource "aws_security_group_rule" "sgre" {
    security_group_id       = aws_security_group.security_group.id
    type                    = "egress"
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = var.all_ip
    depends_on              = [aws_security_group.security_group]
}

resource "aws_instance" "instance" {
    count                   = length(var.ec2_instance)
    instance_type           = var.ec2_type
    ami                     = var.ami
    associate_public_ip_address = true
    iam_instance_profile        = var.iam
    credit_specification {
        cpu_credits         = "standard"
    }
    key_name                = var.key_name
    vpc_security_group_ids  = [aws_security_group.security_group.id]
    subnet_id               = var.subnet_id[count.index]
    root_block_device {
        encrypted = true
        volume_type = var.volume_type
        volume_size = var.volume_size
    }

    tags                    = {
        Name                = "${var.ec2_tags}"
    }
}

output "ec2_id" {
  value                      = aws_instance.instance.*.id
}

