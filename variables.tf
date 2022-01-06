variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami_id" {
 default = "ami-0ed9277fb7eb570c9"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "sj_key_pair" {
  default = "sj_rsa"
}
