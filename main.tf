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
       availability_zone = local.az_names[count.index]
       map_public_ip_on_launch = true

       tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
             },
             var.public_subnets_tags
       )
}

resource "aws_subnet" "private" {
 
       count = length(var.private_subnets_cidrs)
       vpc_id = aws_vpc.main.id
       cidr_block = var.private_subnets_cidrs[count.index]
       availability_zone = local.az_names[count.index]

       tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
             },
             var.private_subnets_tags
       )
}


resource "aws_subnet" "database" {
 
       count = length(var.database_subnets_cidrs)
       vpc_id = aws_vpc.main.id
       cidr_block = var.database_subnets_cidrs[count.index]
       availability_zone = local.az_names[count.index]

       tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
             },
             var.database_subnets_tags
       )
}

resource "aws_route_table" "public" {

      vpc_id = aws_vpc.main.id

      tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-public"
             },
             var.public_route_table_tags
       )

}

resource "aws_route_table" "private" {

      vpc_id = aws_vpc.main.id

      tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-private"
             },
             var.private_route_table_tags
       )

}

resource "aws_route_table" "database" {

      vpc_id = aws_vpc.main.id

      tags = merge (

             local.common_tags, 
             {

                  Name = "${var.project}-${var.environment}-database"
             },
             var.database_route_table_tags
       )

}

