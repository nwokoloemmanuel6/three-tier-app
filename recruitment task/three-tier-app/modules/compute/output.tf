output "app_asg" {
  value = aws_autoscaling_group.three_tier_app
}

output "app_backend_asg" {
  value = aws_autoscaling_group.three_tier_backend
}

output "auto_scale_backend" {
  value = aws_autoscaling_group.three_tier_backend
}

output "auto_scale_frontend" {
  value = aws_autoscaling_group.three_tier_app
}
