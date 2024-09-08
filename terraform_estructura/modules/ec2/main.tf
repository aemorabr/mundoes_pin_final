resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file("${path.module}/pin.pem.pub")
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.pin.key_name
  associate_public_ip_address = true
  tags = {
    Name = var.instance_name
  }
}
