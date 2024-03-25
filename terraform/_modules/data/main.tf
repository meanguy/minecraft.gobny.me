resource "aws_ebs_volume" "volume" {
  availability_zone = var.availability_zone
  size             = var.volume_size_gb

  encrypted      = true
  final_snapshot = true
  type           = "gp3"

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-world-volume"
  })

  lifecycle {
    prevent_destroy = true
  }
}
