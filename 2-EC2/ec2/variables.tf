# Keys
variable "private_key_name" {
  type    = string
  default = "limtruong-pair"
}

# Networking
variable "security_group" {
  type = map(string)
  default = {
    "sg_linux"   = "sg_linux",
    "sg_windows" = "sg_windows"
  }
}

variable "public_subnet" {}

# variable "private_subnet" {}

# Free AMIs
variable "ami_free_amazon" {
  type    = string
  default = "ami-08b5b3a93ed654d19"
}

variable "ami_free_ubuntu" {
  type    = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "ami_free_windows" {
  type    = string
  default = "ami-02b60b5095d1e5227"
}

# Free Instance Types
variable "instance_type_free" {
  type    = string
  default = "t3.micro"
}
