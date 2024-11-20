resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
}

output "vpc_id" {
  value = aws_vpc.this.id
}
