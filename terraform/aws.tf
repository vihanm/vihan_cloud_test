# Retrieve AWS credentials from env variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
provider "aws" {
  access_key = "xxxxx"
  secret_key = "xxxxxxx"
  region = "${var.region}"
}
