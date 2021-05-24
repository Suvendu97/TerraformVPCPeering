provider "aws" {
    region = "${var.region}"
}

resource "aws_vpc_peering_connection" "DemoVPCPeering" {
  # peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.terraformVPCOwner.id
  vpc_id        = aws_vpc.terraformVPCPeer.id
  auto_accept   = true
  
  tags = {
    Name = "VPC Peering between terraformVPCOwner and terraformVPCPeer"
  }
}

resource "aws_vpc" "terraformVPCOwner" {
  cidr_block       = "${var.vpc_cidr}"
  # instance_tenancy = "${var.tenancy}"
  enable_dns_hostnames = true
  tags = {
    Name = "terraformVPCOwner"
  }
}

resource "aws_vpc" "terraformVPCPeer" {
  cidr_block       = "${var.vpc_cidr1}"
  tags = {
    Name = "terraformVPCPeer"
  }
}


resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = aws_vpc.terraformVPCOwner.id
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "terraformSubnet-${count.index+1}"
  }
}

resource "aws_subnet" "subnets1" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = aws_vpc.terraformVPCPeer.id
  cidr_block = "${element(var.subnet_cidr1,count.index)}"

  tags = {
    Name = "terraformSubnet1-${count.index+1}"
  }
}

# resource "aws_security_group" "secure" {
#     name = "mysecurity"
#     ingress{
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress{
#       from_port = 80
#       to_port = 80
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress{
#         from_port = 0
#         to_port = 0
#         protocol = -1
#         cidr_blocks = ["0.0.0.0/0"]
#     }

# }

# resource "aws_instance" "demoinstance" {
#     ami = "ami-0a9d27a9f4f5c0efc"
#     instance_type = "t2.micro"
#     availability_zone = "ap-south-1a"
#     # subnet_id = "${aws_subnet.terraform-subnet_1.id}"
#     security_groups = [ aws_security_group.secure.name ]
#     subnet_id = "subnet-0067bf4f6cfa7348c"
#     key_name = "TerraformKey"
#     user_data = <<-EOF
#                 #!/bin/bash
#                 yum install httpd -y
#                 service httpd start
#                 chkconfig httpd on
#                 mkdir /var/www/html
#                 echo 'Hey!! This is done using Terraform!' > /var/www/html/index.html
#             EOF

#     tags = {
#       Name = "demoinstance"
#     }
# }

# resource "aws_subnet" "terraformSubnet2" {
#   vpc_id     = aws_vpc.terraformVPC.id
#   cidr_block = "${var.subnet2_cidr}"

#   tags = {
#     Name = "terraformSubnet2"
#   }
# }