resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "public" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = "us-east-1${["a", "b", "c"][count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-gw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_route_table_association" "public" {
  for_each      = { for idx, subnet_id in aws_subnet.public : idx => subnet_id }
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public.id
}
