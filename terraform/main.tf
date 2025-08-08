provider "aws" {
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    project = var.project
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
    az = var.az
}

module "ec2" {
    source = "./modules/ec2"
    project = var.project
    ami_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}