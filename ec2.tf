

# 🔑 Key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# 🖧 Default VPC
resource "aws_default_vpc" "default" {}

# 🛡 Security Group
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add a TF genrated Security group"
  vpc_id      = aws_default_vpc.default.id   #interpolation

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate-sg"
  }
}

# 🖥 EC2 instance
resource "aws_instance" "my_instance" {
 ami                    = "ami-0f5fcdfbd140e4ab7"
 #ami = var.ec2_ami_id

 #count = 2 @Metakey-word/MetaArgument 
for_each = tomap({
  #Ankit-Junoon-automate-micro="t3.micro"
  Ankit-Junoon-automate-small="t3.small" 
                 #@MetaArgument with Key and Value pair
})

depends_on = [aws_security_group.my_security_group,aws_key_pair.my_key]
  #instance_type          = "t3.micro"
  instance_type = each.value
  #instance_type = var.ec2_instance-type

  key_name               = aws_key_pair.my_key.key_name
  security_groups =  [aws_security_group.my_security_group.name]
    
    user_data = file("install_nginx.sh")   # <- Use your script here

  root_block_device {
    #volume_size = 8
    #volume_size = var.ec2_root_storage_size
    volume_size = var.env== "prd" ? 10 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  
tags = {
  #Name =var.instance_name
  Name = each.key
  Environment = var.env
}
}