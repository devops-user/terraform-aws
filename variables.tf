variable "aws_access_key" {
  default = "You access key"
}

variable "aws_secret_key" {
  default = "You secret key"
}

variable "region" {
  default = "us-east-2"
}

variable "zone_id" {
  type = "string"
  default = "ZUYOKXBWM9MWO"
}

variable "domains" {
  type = "list"
  default = ["domain"]
}

variable "key_name" {
  default = "aws_key"
}

variable "key_path" {
  default = "/root/.ssh/id_rsa.pub"
}
