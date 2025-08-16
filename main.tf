resource "aws_instance" "public" {
  ami                         = "ami-0de716d6197524dd9" # find the AMI ID of Amazon Linux 2023  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0a30b23b85fbc0db5"  #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  instance_type               = "t2.micro"               # ✅ Required argument
  associate_public_ip_address = true
  key_name                    = "shilpa-key-pair" #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 
  tags = {
    Name = "shilpa-ec2"    #Prefix your own name, e.g. jazeel-ec2
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "shilpa-terraform-security-group" #Security group name, e.g. jazeel-terraform-security-group
  description = "Allow SSH inbound"
  vpc_id      = "vpc-037a1fde3abdbc8fc"  #VPC ID (Same VPC as your EC2 subnet above), E.g. vpc-xxxxxxx
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}