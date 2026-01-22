output "deployer_private_key_pem" {
  description = "Private key (PEM) for SSH access to instances - keep this secure"
  value       = tls_private_key.deployer.private_key_pem
  sensitive   = true
}

# Output the public IP for easy access
output "ansible_public_ip" {
  value       = aws_instance.ansible.public_ip
  description = "Public IP of Ansible control node"
}

output "ansible_ssh_command" {
  value       = "ssh -i ${var.vpc_name}-deployer-key.pem ec2-user@${aws_instance.ansible.public_ip}"
  description = "SSH command to connect to Ansible instance"
}