output "timeboard_title" {
  value       = var.lb_type == "application" ? join(",", datadog_dashboard.elb_application.*.title) : join(",", datadog_dashboard.elb_classic.*.title)
  description = "The title of datadog dashboard for ELB"
}

output "monitor_healthy_host_count_name" {
  value       = var.lb_type == "application" ? module.elb_application_monitor_healthy_host_count.name : module.elb_classic_monitor_healthy_host_count.name
  description = "The name of datadog monitor for ELB Healthy Host Count"
}
