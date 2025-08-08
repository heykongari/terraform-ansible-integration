resource "tls_private_key" "key-pair" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "demo-key" {
    key_name = var.key_name
    public_key = tls_private_key.key-pair.public_key_openssh
}

resource "local_file" "private-key" {
    content = tls_private_key.key-pair.private_key_pem
    filename = "${path.root}/${var.key_name}.pem"
    file_permission = "0400"
    lifecycle {
      prevent_destroy = false
    }
}

resource "aws_security_group" "demo-sg" {
    name = "${var.project}-demo-sg"
    description = "Allow SSH and HTTP"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = { Name = "${var.project}-sg" }
}

resource "aws_instance" "server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = aws_key_pair.demo-key.key_name
    associate_public_ip_address = true
    tags = { Name = "${var.project}-server" }
}