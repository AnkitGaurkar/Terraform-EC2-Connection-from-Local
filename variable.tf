variable "ec2_instance-type" {
    default = "t3.micro"
    type = string
  
}
# variable "ec2_root_storage_size" {
#     default = 8
#     type = number 
#}
variable "ec2_default_root_storage_size" {
default = 9
type = number
}

variable "ec2_ami_id" {
    default = "ami-0f5fcdfbd140e4ab7"
    type = string
  
}
variable "instance_name" {
    
    default = "Anku"
    type = string
    description = "This is tag for instance name"
  
}
variable "env" {
    default = "dev"
    type =string
}