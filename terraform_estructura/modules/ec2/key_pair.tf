resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file("${path.module}/pin.pem.pub") # Ensure this is the correct path to your public key
}