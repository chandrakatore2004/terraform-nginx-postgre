variable "vpc_id" {
  description = "The VPC ID where the IGW and route table will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to associate with the route table"
  type        = list(string)
}
