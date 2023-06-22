# create pub subs for fargate tasks
resource "aws_subnet" "pubSub1" {
  vpc_id     = aws_vpc.lastvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-01-for-funding-fargate"
  }
}

resource "aws_subnet" "pubSubt2" {
  vpc_id     = aws_vpc.lastvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-02-for-funding-fargate"
  } 
}

# # create private subs for RDS
# resource "aws_subnet" "privateSubnet1" {
#   vpc_id     = aws_vpc.finalvpc.id
#   cidr_block = "10.0.4.0/24"
#   availability_zone = "ap-northeast-2a"

#   tags = {
#     Name = "private-subnet-01-for-funding-RDS"
#   }
# }

# resource "aws_subnet" "privateSubnet2" {
#   vpc_id     = aws_vpc.finalvpc.id
#   cidr_block = "10.0.5.0/24"
#   availability_zone = "ap-northeast-2c"

#   tags = {
#     Name = "private-subnet-02-for-funding-RDS"
#   }
# }


