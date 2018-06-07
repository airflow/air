
variable "region" {
  default = "us-east-1"
}

variable "AmiLinux" {
  type = "map"
  default = {
    us-east-1 = "ami-1853ac65"
    us-west-2 = "ami-d874e0a0"
    eu-west-1 = "ami-bf5540df"
    us-east-2 = "ami-ea87a78f"
  }
  description = "ami id for linux imgage"
}

variable "CentosLinux" {
  type = "map"
  default = {
    us-east-1 = "ami-6871a115"
    us-west-2 = "ami-d874e0a0"
    eu-west-1 = "ami-bf5540df"
    us-east-2 = "ami-ea87a78f"
  }
  description = "ami id for linux imgage"
}

variable "Amiwindows" {
  type = "map"
  default = {
    us-east-1 = "ami-3633b149"
    us-west-2 = "ami-f3dcbc8b"
    eu-west-1 = "ami-d0d0c3b0"
    us-east-2 = "ami-5984b43c"
  }
  description = "ami id for linux imgage"
}

variable "credentialsfile" {
  default = "/Users/ej/.aws/credentials" #replace your home directory
  description = "aws config file location your access and secret_key are stored"
}

variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}

variable "Subnet-Public-AzA-CIDR" {
  default = "172.28.0.0/24"
  description = "the cidr of the subnet"
}

variable "Subnet-Public-AzB-CIDR" {
  default = "172.28.1.0/24"
  description = "the cidr of the subnet"
}

variable "Subnet-Private-AzA-CIDR" {
  default = "172.28.3.0/24"
  description = "the cidr of the subnet"
}

variable "key_name" {
  default = "ej_key_pair"
  description = "the ssh key to use in the EC2 machines"
}
