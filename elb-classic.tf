locals {
  elb_classic_monitor_enabled = var.enabled && var.lb_type == "classic" && length(var.recipients) > 0 ? true : false
}

resource "datadog_dashboard" "elb_classic" {
  count       = var.lb_type == "classic" ? 1 : 0
  title       = "${var.product_domain} - ${var.lb_name} - ${var.environment} - ELB Classic"
  description = "A generated dashboard for ELB Classic"
  layout_type = "ordered"

  template_variable {
    default = var.lb_name
    name    = "lb_name"
    prefix  = "name"
  }

  template_variable {
    default = var.environment
    name    = "environment"
    prefix  = "environment"
  }

  widget {
    timeseries_definition {
      title = "Client TLS Negotiation Error Count"

      request {
        q            = "avg:aws.elb.client_tlsnegotiation_error_count{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "HTTP Backend Responses Count"

      request {
        q            = "avg:aws.elb.httpcode_backend_2xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.httpcode_backend_3xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.httpcode_backend_4xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.httpcode_backend_5xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "HTTP Target Responses Count"

      request {
        q            = "avg:aws.elb.target_response_time.maximum{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.target_response_time.average{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.target_response_time.p95{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.target_response_time.p99{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Request Count"

      request {
        q            = "avg:aws.elb.request_count{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Healthy Host Count"

      request {
        q            = "sum:aws.elb.healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Unhealthy Host Count"

      request {
        q            = "sum:aws.elb.un_healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.un_healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.un_healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.elb.un_healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Latency"

      request {
        q            = "avg:aws.elb.latency.p95{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.latency.p99{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.latency.maximum{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }

      request {
        q            = "avg:aws.elb.latency.minimum{$lb_name, $environment} by {name,availability-zone}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Active Connection Count"

      request {
        q            = "avg:aws.elb.estimated_albactive_connection_count{$lb_name, $environment} by {name}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = " Processed Bytes"

      request {
        q            = "avg:aws.elb.estimated_processed_bytes{$lb_name, $environment} by {name}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Consumed Lcus"

      request {
        q            = "avg:aws.elb.estimated_albconsumed_lcus{$lb_name, $environment} by {name}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "New Connection Count"

      request {
        q            = "avg:aws.elb.estimated_albnew_connection_count{$lb_name, $environment} by {name}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Backend Connection Error Count"

      request {
        q            = "avg:aws.elb.estimated_albnew_connection_count{$lb_name, $environment} by {name}.as_count()"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Surge Queue Length"

      request {
        q            = "avg:aws.elb.surge_queue_length{$lb_name, $environment} by {name,availability-zone}"
        display_type = "line"
      }
    }
  }
}

module "elb_classic_monitor_healthy_host_count" {
  source  = "github.com/traveloka/terraform-datadog-monitor?ref=v0.3.0"
  enabled = local.elb_classic_monitor_enabled

  product_domain = var.product_domain
  service        = var.service
  environment    = var.environment
  tags           = var.tags
  timeboard_id   = join(",", datadog_dashboard.elb_classic.*.id)

  name = var.healthy_host_name != "" ? var.healthy_host_name : "${var.product_domain} - ${var.lb_name} - ${var.environment} - Number of Healthy Hosts is Low"

  query              = "avg(last_1m):sum:aws.elb.healthy_host_count{name:${var.lb_name}, environment:${var.environment}} by {name} <= ${var.healthy_host_count_thresholds["critical"]}"
  thresholds         = var.healthy_host_count_thresholds
  evaluation_delay   = "900"
  message            = var.healthy_host_count_message
  escalation_message = var.healthy_host_count_escalation_message

  recipients         = var.recipients
  alert_recipients   = var.alert_recipients
  warning_recipients = var.warning_recipients

  renotify_interval = var.renotify_interval
  notify_audit      = var.notify_audit
  include_tags      = var.healthy_host_include_tags
}
