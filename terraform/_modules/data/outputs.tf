output "availability_zone" {
  value = var.availability_zone
}

output "volume_id" {
  value = aws_ebs_volume.volume.id
}

