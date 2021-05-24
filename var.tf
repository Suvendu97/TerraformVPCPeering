variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
    default = "190.160.0.0/16"
    } 

variable "vpc_cidr1" {
    default = "190.168.0.0/16"
    } 

variable "tenancy" {
      default = "default"
    }

variable "subnet_cidr" {
    type = list
  default = ["190.160.1.0/24", "190.160.2.0/24", "190.160.3.0/24"]
}

variable "subnet_cidr1" {
    type = list
  default = ["190.168.1.0/24", "190.168.2.0/24", "190.168.3.0/24"]
}

# variable "subnet2_cidr" {
#   default = "190.160.2.0/24"
# }

# variable "azs" {
#   type =  list
#   default =  ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
# }

data "aws_availability_zones" "azs" {
    
}