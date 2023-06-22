# create ECR and push images in this repo
resource "aws_ecr_repository" "final_ecr_repo" {
  name = "last-ecr-repo" 
}