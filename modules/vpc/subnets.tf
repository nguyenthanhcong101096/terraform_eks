resource "aws_subnet" "public_subnets" {
  for_each = {
    for subnet in local.public_nested_config : "${subnet.name}" => subnet
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Environment = var.env
    Name        = "${each.value.name}-${var.app}-${var.env}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = {
    for subnet in local.private_nested_config : "${subnet.name}" => subnet
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Environment = var.env
    Name        = "${each.value.name}-${var.app}-${var.env}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
