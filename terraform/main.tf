provider "aws" {
    region = var.aws_region
}

data "aws_vpc" "default" {
    default = true
}

resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "Allow HTTP and SSH"
    vpc_id = data.aws_vpc.default.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = "aws-key"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    associate_public_ip_address = true

    tags = {
      Name = "terraform_ansible_web"
    }
}

resource "null_resource" "ansible_provision" {
    depends_on = [ aws_instance.web ]

    provisioner "local-exec" {
        command = "sleep 30 && cd ../ansible && ansible-playbook -i aws_ec2.yaml playbook.yaml"
    }
}