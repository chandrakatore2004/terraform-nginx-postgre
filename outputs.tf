output "ec2_public_ip" {
  value = module.ec2_instance.public_ip
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "application_url" {
  value = "http://${module.ec2_instance.public_ip}"
}


output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "bucket_name" {
  value = module.s3_bucket.bucket_name
}



