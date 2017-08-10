output "configuration" {
  value =
<<EOF
Bastion Information
-------------------
Bastion IP:   ${module.bastion.public_ip}
The bastion instance is accessible via SSH.
  Key name: ${var.key_name}
  Add the private key to your ssh-agent.
  Login to the bastion with: ssh -A ubuntu@${module.bastion.public_ip}

Application Instance IP: ${module.app.app_ip}
Once you're logged into the bastion server, you can SSH into the app server by:
ssh ${module.app.app_ip}
EOF
}

