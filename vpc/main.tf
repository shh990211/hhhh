resource "aws_vpc" "vpc" {
    cidr_block              = var.cidr
    enable_dns_hostnames     = true
    enable_dns_support      = true

    tags = {
        Name                = "${var.vpc_tag}"
    }
}

resource "aws_subnet" "subnet" {
    count                   = length(var.cidr_block)
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.cidr_block[count.index]

    tags = {
        Name                = "${var.vpc_tag}-subnet-${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id                  = aws_vpc.vpc.id

    tags = {
        Name                = "${var.vpc_tag}-igw"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id                  = aws_vpc.vpc.id
    # route = {
    #     cidr_block          = var.route_block
    #     gateway_id          = aws_internet_gateway.igw.id
    # }
    tags = {
        Name                = "${var.vpc_tag}-route-table"
    }
}

resource "aws_route" "route" {
    route_table_id          = aws_route_table.route_table.id
    destination_cidr_block  = var.route_block
    gateway_id              = aws_internet_gateway.igw.id
    depends_on              = [aws_route_table.route_table]
 }

resource "aws_route_table_association" "arta" {
    subnet_id               = aws_subnet.subnet[0].id
    route_table_id          = aws_route_table.route_table.id 
}

resource "aws_route_table_association" "artb" {
    subnet_id               = aws_subnet.subnet[1].id
    route_table_id          = aws_route_table.route_table.id 
}

output "vpc_id" {
  value                      = aws_vpc.vpc.id
}

output "subnet_id" {
  value                      = aws_subnet.subnet.*.id
}

