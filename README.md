# Terraform Ansible integration
This project demonstrates how to provision an Ubuntu EC2 instance on AWS using Terraform and then configure it with Ansible to install and start Nginx.  
It uses Ansible's `aws_ec2` dynamic inventory plugin to automatically fetch instance details from AWS instead of maintaining a static inventory file.

## Folder Structure
```
📦terraform-ansible-integration
 ┣ 📂ansible
 ┃ ┣ 📂group_vars
 ┃ ┃ ┗ 📜ubuntu.yaml
 ┃ ┣ 📜aws_ec2.yaml
 ┃ ┗ 📜playbook.yaml
 ┣ 📂terraform
 ┃ ┣ 📜main.tf
 ┃ ┣ 📜outputs.tf
 ┃ ┗ 📜variables.tf
 ┣ 📜LICENSE
 ┗ 📜README.md
 ```

## 📌 Features
- **Terraform**:
  - Ubuntu EC2 instance
  - Associated VPC, subnet, and security group
- **Ansible**:
  - Uses the `aws_ec2` dynamic inventory plugin
  - SSH key configuration for ansible access
  - (Optional) Installs and ensures Nginx service is enabled and running

## 🛠 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) >= 2.10
- AWS CLI configured (aws configure)

## 🚀 Usage
### 1. Clone this repository
```bash
git clone https://github.com/heykongari/terraform-ansible-integration.git
```

### 2. Provision infrastructure with terraform
```bash
cd terraform-ansible-integration/terraform/
terraform init
terraform apply -auto-approve
```
Ansible commands are provisioned under `local-exec` which makes automation simple. No need to manually run other commands.

>[!WARNING]
> Make sure `.pem` file has valid permissions.
```bash
chmod 400 ~/.ssh/your-key.pem
```