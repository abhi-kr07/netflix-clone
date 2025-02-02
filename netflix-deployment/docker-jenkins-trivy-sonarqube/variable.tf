variable "region" {
  description = "Region"
  type        = string
}

variable "vpc_id" {
  description = "Vpc-id"
  type        = string
}

variable "instance_type" {
  description = "instance-type"
  type        = string
}

variable "key_name" {
  description = "key-pair"
  type        = string
}

variable "ami_id" {
  description = "ami-value"
  type        = string
}

variable "subnet_id" {
  description = "subnet-id"
  type        = string

}
