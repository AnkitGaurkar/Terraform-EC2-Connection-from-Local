# output "ec2_public_ip" {
#     value = aws_instance.my_instance[*].public_ip    #via access means interpolation
  
# }
# output "ec2_public_dns" {
#     value = aws_instance.my_instance[*].public_dns
  
# }
# output "ec2_private_ip" {
#     value = aws_instance.my_instance[*].private_ip
# }
# output "ec2_private_dns" {
#     value = aws_instance.my_instance[*].private_dns
  
# }

# for-each loop we need to iterating the output

output "ec2_public_ip"{
    value=[
        for instance in aws_instance.my_instance : instance.public_ip
    ]
}
output "ec2_public_dns"{
    value=[
        for instance in aws_instance.my_instance : instance.public_dns
    ]
}
output "ec2_private_ip"{
    value =[
        for instance in aws_instance.my_instance : instance.private_ip
    ]
}
output "ec2_private_dns"{
    value =[
        for instance in aws_instance.my_instance : instance.private_dns
    ]
}