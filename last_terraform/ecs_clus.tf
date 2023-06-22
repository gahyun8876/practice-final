# create ECS
# create cluster 
resource "aws_ecs_cluster" "last_cluster" {
  name = "last-cluster" 
}