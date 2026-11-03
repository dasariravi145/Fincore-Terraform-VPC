variable "project" {

      type = string
}

variable "environment" {

       type = string
}

variable "cidr_block" {

        type = string
        default = "10.0.0.0/16"
}

variable "vpc_tags" {

       type = map
       default = {}
}

variable "igateway_tags" {

        type = map
        default = {}
}

variable "public_subnets_cidrs" {

       type = map
       default = ["10.0.1.0/24","10.0.2.0/24"]
}