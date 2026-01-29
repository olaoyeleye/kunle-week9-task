resource "aws_subnet" "public-kunle-subnet" {
  vpc_id     = aws_vpc.kunle-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-kunle-subne"
  }
}


resource "aws_subnet" "private-kunle-subnet" {
  vpc_id     = aws_vpc.kunle-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private-kunle-subne"
  }
}