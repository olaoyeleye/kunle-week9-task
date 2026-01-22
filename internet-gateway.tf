resource "aws_internet_gateway" "kunle-igw" {
  vpc_id = aws_vpc.kunle-vpc.id

  tags = {
    Name = "kunle-igw"
  }
}