/* resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "aalimsee-tf-beanstalk-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "aalimsee-tf-beanstalk-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "aalimsee-tf-beanstalk-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "aalimsee-tf-beanstalk-public-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
} */

module "vpc" {
 source  = "terraform-aws-modules/vpc/aws" # <<< https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

 name = "aalimsee-tf-eb-vpc-module" # Change this!!!
 cidr = "10.0.0.0/16"

 azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
 private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
 public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

 enable_nat_gateway   = true
 single_nat_gateway   = true
 enable_dns_hostnames = true

 tags = {
  Name = "aalimsee-tf-eb-vpc-module"
  Terraform = "true" # <<< tag
 }
}

# Create the output block
output "nat_gateway_ids" {
 value = module.vpc.natgw_ids
}
