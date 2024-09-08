resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file("${path.module}/pin.pub")
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.pin.key_name

  tags = {
    Name = var.instance_name
  }
}
