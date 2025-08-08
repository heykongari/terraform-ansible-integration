#!/usr/bin/env python3
import json
import subprocess

def get_public_ip():
    result = subprocess.run(
        ["terraform", "-chdir=../terraform", "output", "-raw", "ec2_public_ip"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    if result.returncode != 0:
        return None
    return result.stdout.strip()

def main():
    public_ip = get_public_ip()
    if not public_ip:
        print(json.dumps({}))
        return

    inventory = {
        "web": {
            "hosts": [public_ip],
            "vars": {
                "ansible_user": "ubuntu",
                "ansible_ssh_private_key_file": "~/aws-infra-terraform-ansible/terraform/demo-key.pem"
            }
        },
        "_meta": {
            "hostvars": {}
        }
    }

    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    main()
