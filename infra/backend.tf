terraform {
  backend "s3" {
    bucket       = "gatus-tf-state-REDACTED"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}