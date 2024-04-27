
output "server_alb_security_group_id" {
  value = aws_security_group.server_alb_sg.id
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_security_group.id
}