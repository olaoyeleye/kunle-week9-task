resource "aws_instance" "nginx" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = "${var.vpc_name}-deployer-key"
  associate_public_ip_address = true
  # security_groups = 
  subnet_id              = aws_subnet.public-kunle-subnet.id
  vpc_security_group_ids = [aws_security_group.public-kunle-sg.id]

  tags ={
    Name = var.instance-name-nginx
  }
}


#resource "aws_instance" "ansible" {
#  ami                         = var.ami
#  instance_type               = var.instance_type
#  key_name                    = "${var.vpc_name}-deployer-key"
#  associate_public_ip_address = true
#  # security_groups = 
#  subnet_id              = aws_subnet.public-kunle-subnet.id
#  vpc_security_group_ids = [aws_security_group.public-kunle-sg.id]
#  tags ={
#    Name = var.instance-name-ansible
#  }
#}

# Install Ansible using remote-exec provisioner
resource "null_resource" "install_ansible" {
  depends_on = [aws_instance.ansible]

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Change to "ubuntu" if using Ubuntu AMI
    private_key = file("${var.vpc_name}-deployer-key.pem")
    host        = aws_instance.ansible.public_ip
  }
provisioner "file" {
  source      = "${var.vpc_name}-deployer-key.pem"
  destination = "/home/ec2-user/${var.vpc_name}-deployer-key.pem"
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${var.vpc_name}-deployer-key.pem")
    host        = aws_instance.ansible.public_ip
  }
}

  provisioner "remote-exec" {
    inline = [ 
      "cloud-init status --wait",
      "echo 'Installing Ansible...'",
      "sudo yum update -y",
      "sudo amazon-linux-extras install ansible2 -y || sudo yum install -y ansible || sudo dnf install -y ansible-core",
      "ansible --version",
      "echo 'Creating directory structure...'",
      "mkdir -p ~/ansible/{playbooks,inventory,roles}" ,
      "chmod 400 ${var.vpc_name}-deployer-key.pem"
    ]
  }
}

 

resource "aws_instance" "java" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = "${var.vpc_name}-deployer-key"
  associate_public_ip_address = true
 
  subnet_id              = aws_subnet.public-kunle-subnet.id
  vpc_security_group_ids = [aws_security_group.public-kunle-sg.id]

  tags ={
    Name = var.instance-name-java
  }
}