terraform {
  backend "s3" {
    bucket       = "gatus-tf-state-454374565233"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}