terraform {
  backend "s3" {
    bucket = "tfstate-remote-backend"
    key    = "pet_infra-remote.tfstate"
    region = "us-west-2"
    dynamodb_table = "remote-tfstate-lock"
  }
}