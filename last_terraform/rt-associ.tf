resource "aws_route_table_association" "pub_subnet1_asso" {
  subnet_id      = aws_subnet.pubSub1.id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "pub_subnet2_asso" {
  subnet_id      = aws_subnet.pubSubt2.id
  route_table_id = aws_route_table.rt_pub.id
}

# resource "aws_route_table_association" "priv_subnet1_association" {
#   subnet_id      = aws_subnet.privateSubnet1.id
#   route_table_id = aws_route_table.rt_pub.id
# }

# resource "aws_route_table_association" "priv_subnet2_association" {
#   subnet_id      = aws_subnet.privateSubnet2.id
#   route_table_id = aws_route_table.rt_pub.id
# }
