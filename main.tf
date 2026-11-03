resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

    tags = local.vpc.ec2_final_tags
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = local.igateway_final_tags
}

resource "aws_subnet" "public" {
 
       count = length(var.public_subnets_cidrs)
       vpc_id = aws_vpc.main.id
       cidr_block = var.public_subnets_cidrs[count.index]

}

