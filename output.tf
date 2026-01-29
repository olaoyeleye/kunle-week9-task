output "deployer_private_key_pem" {
  description = "Private key (PEM) for SSH access to instances - keep this secure"
  value       = tls_private_key.deployer.private_key_pem
  sensitive   = true
}

## Output the public IP for easy access
#output "ansible_public_ip" {
#  value       = aws_instance.ansible.public_ip
#  description = "Public IP of Ansible control node"
#}

#output "ansible_ssh_command" {
#  value       = "ssh -i ${var.vpc_name}-deployer-key.pem ec2-user@${aws_instance.ansible.public_ip}"
#  description = "SSH command to connect to Ansible instance"
#}





# Outputs
output "nginx_public_ip" {
  value       = aws_instance.nginx.public_ip
  description = "Public IP of Nginx server"
}

output "java_public_ip" {
  value       = aws_instance.java.public_ip
  description = "Public IP of Java server"
}

output "private_key_pem" {
  value       = tls_private_key.deployer.private_key_pem
  description = "Private SSH key for instance access"
  sensitive   = true
}

output "key_name" {
  value       = aws_key_pair.deployer.key_name
  description = "Name of the SSH key pair"
}