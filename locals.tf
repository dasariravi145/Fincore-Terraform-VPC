locals {

      common_tags = {

           Project = var.project
           Environment = var.environment
           Terraform = "true"
      }

     ec2_final_tags= merge(
        local.common_tags,
        {
             Name = "${var.project}-${var.environment}"
        },
        var.vpc_tags
    )
    igateway_final_tags = merge(
          local.common_tags,
          {
              Name = "${var.project}-${var.environment}"
          },
          var.igateway_tags
    )

    az_names= slice(data.aws_availability_zones.available.names,0,2)
    
}