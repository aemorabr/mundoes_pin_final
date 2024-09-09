output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "key_name" {
  value = aws_key_pair.pin.key_name
}

output "role_arn"{
  value=aws_iam_role.ec2_admin_role.arn
}