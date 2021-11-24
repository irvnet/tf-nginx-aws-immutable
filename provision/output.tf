
output "login-string" {
  value = <<EOF
ssh -i keys/demo-1 ubuntu@${join(",",aws_instance.websrv-01.*.public_ip)}
ssh -i keys/demo-1 ubuntu@${join(",",aws_instance.websrv-02.*.public_ip)}
EOF
}

output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${aws_elb.webserver-lb.dns_name}/"
}
