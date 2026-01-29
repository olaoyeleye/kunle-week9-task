terraform {
  backend "s3" {
    bucket  = "kunle-week-9-task-s3"
    key     = "week9/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
