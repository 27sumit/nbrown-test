output "instances" {
  value       = aws_instance.web.*.private_ip
  description = "PrivateIP address details"
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.web_servers.dns_name
}