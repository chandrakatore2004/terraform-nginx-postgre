variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}