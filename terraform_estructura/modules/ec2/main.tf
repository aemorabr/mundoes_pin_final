resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file("${path.module}/pin.pem.pub")
}

# Definición del rol de IAM
resource "aws_iam_role" "ec2_admin_role" {
  name = "ec2-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Adjuntar la política administrativa gestionada al rol
resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Crear un perfil de instancia de IAM para la instancia EC2
resource "aws_iam_instance_profile" "ec2_admin_profile" {
  name = "ec2-admin-profile"
  role = aws_iam_role.ec2_admin_role.name
}
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.pin.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_admin_profile.name
  tags = {
    Name = var.instance_name
  }
}
