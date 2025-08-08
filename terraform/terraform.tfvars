project = "web-project"
region = "us-east-1"
ami_id = "ami-020cba7c55df1f615"
instance_type = "t2.micro"
key_name = "demo-key" # (mandatory) update key path in ansible/inventory/terraform_inventory.sh 
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
az = "us-east-1a"