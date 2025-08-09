variable "aws_region" {
    default = "us-east-1"
}

variable "ami_id" {
    default = "ami-020cba7c55df1f615" # ubuntu 20.04 in us-east-1
}

variable "instance_type" {
    default = "t2.micro"
}