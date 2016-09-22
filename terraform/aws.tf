# Retrieve AWS credentials from env variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
provider "aws" {
  access_key = "AKIAJ7O42HEFRTWZ5LZA"
  secret_key = "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"
  region = "${var.region}"
}
