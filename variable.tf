variable "region" {}
variable "ami" {}
variable "instance_type" {}
variable "key_name" {
    default = "kunle-vpc-deployer-key"
}
variable "instance-name-nginx" {}
#variable "instance-name-ansible" {}
variable "instance-name-java" {}
variable "vpc_name" {}