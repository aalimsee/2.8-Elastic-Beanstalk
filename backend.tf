# placeholder to be included when uploading tfstate file to Terraform backend storage
terraform{
    backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "aalimsee-ce9-tf-beanstalk.tfstate" // Replace the value of key to <your suggested name>.tfstate, eg. terraform-ex-ec2-<NAME>.tfstate
    region = "us-east-1"
  }
}