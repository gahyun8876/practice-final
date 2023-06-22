# create a Route table for VPC
resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.lastvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lastigw.id
  }

  tags = {
    Name = "last-rt"
  }
}