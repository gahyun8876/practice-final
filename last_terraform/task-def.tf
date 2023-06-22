#eask task definition
resource "aws_ecs_task_definition" "funding-task-def" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([{
   name        = "funding-task-def"
   "image": "${aws_ecr_repository.last_ecr_repo.repository_url}:latest",   essential   = true
   portMappings = [{
     protocol      = "tcp"
     containerPort = 3000
     hostPort      = 3000
    }]
   }])
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "dynamodb" {
  name        = "task-policy-dynamodb"
  description = "Policy that allows access to DynamoDB"
 
 policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
               "dynamodb:CreateTable",
               "dynamodb:UpdateTimeToLive",
               "dynamodb:PutItem",
               "dynamodb:DescribeTable",
               "dynamodb:ListTables",
               "dynamodb:DeleteItem",
               "dynamodb:GetItem",
               "dynamodb:Scan",
               "dynamodb:Query",
               "dynamodb:UpdateItem",
               "dynamodb:UpdateTable"
           ],
           "Resource": "*"
       }
   ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.dynamodb.arn
}
# # create the funding task_def
# resource "aws_ecs_task_definition" "funding_task-def" {
#   family                   = "funding-task-def" # Naming our first task
#   container_definitions    = <<DEFINITION
#   [
#     {
#       "name": "funding-task-def",
#       "image": "${aws_ecr_repository.last_ecr_repo.repository_url}:latest",
#       "essential": true,
#       "portMappings": [
#         {
#           "containerPort": 3000,
#           "hostPort": 3000
#         }
#       ],
#       "memory": 512,
#       "cpu": 256
#     }
#   ]
#   DEFINITION
#   requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
#   network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
#   memory                   = 512         # Specifying the memory our container requires
#   cpu                      = 256         # Specifying the CPU our container requires
#   execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
# }

# # ecs role
# resource "aws_iam_role" "ecsTaskExecutionRole" {
#   name               = "ecsTaskExecutionRole"
#   assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
# }

# # ecs policy
# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
#   role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }
