resource "oci_bds_auto_scaling_configuration" "bds_auto_scaling_configurations" {
  for_each = var.bds_auto_scaling_configurations

  bds_instance_id        = each.value.bds_instance_id
  is_enabled             = each.value.is_enabled
  node_type              = each.value.node_type
  cluster_admin_password = each.value.cluster_admin_password
  display_name           = each.value.display_name
  secret_id              = each.value.secret_id

  dynamic "policy" {
    for_each = each.value.policy != null ? [each.value.policy] : []
    content {
      policy_type = policy.value.policy_type
      dynamic "rules" {
        for_each = policy.value.rules
        content {
          action = rules.value.action
          metric {
            metric_type = rules.value.metric.metric_type
            threshold {
              duration_in_minutes = rules.value.metric.threshold.duration_in_minutes
              operator            = rules.value.metric.threshold.operator
              value               = rules.value.metric.threshold.value
            }
          }
        }
      }
    }
  }

  dynamic "policy_details" {
    for_each = each.value.policy_details != null ? [each.value.policy_details] : []
    content {
      policy_type = policy_details.value.policy_type
      dynamic "scale_down_config" {
        for_each = policy_details.value.scale_down_config != null ? [policy_details.value.scale_down_config] : []
        content {
          memory_step_size = scale_down_config.value.memory_step_size
          dynamic "metric" {
            for_each = scale_down_config.value.metric != null ? [scale_down_config.value.metric] : []
            content {
              metric_type = metric.value.metric_type
              dynamic "threshold" {
                for_each = metric.value.threshold != null ? [metric.value.threshold] : []
                content {
                  duration_in_minutes = threshold.value.duration_in_minutes
                  operator            = threshold.value.operator
                  value               = threshold.value.value
                }
              }
            }
          }
          min_memory_per_node = scale_down_config.value.min_memory_per_node
          min_ocpus_per_node  = scale_down_config.value.min_ocpus_per_node
          ocpu_step_size      = scale_down_config.value.ocpu_step_size
        }
      }
      dynamic "scale_in_config" {
        for_each = policy_details.value.scale_in_config != null ? [policy_details.value.scale_in_config] : []
        content {
          dynamic "metric" {
            for_each = scale_in_config.value.metric != null ? [scale_in_config.value.metric] : []
            content {
              metric_type = metric.value.metric_type
              dynamic "threshold" {
                for_each = metric.value.threshold != null ? [metric.value.threshold] : []
                content {
                  duration_in_minutes = threshold.value.duration_in_minutes
                  operator            = threshold.value.operator
                  value               = threshold.value.value
                }
              }
            }
          }
          min_node_count = scale_in_config.value.min_node_count
          step_size      = scale_in_config.value.step_size
        }
      }
      dynamic "scale_out_config" {
        for_each = policy_details.value.scale_out_config != null ? [policy_details.value.scale_out_config] : []
        content {
          max_node_count = scale_out_config.value.max_node_count
          dynamic "metric" {
            for_each = scale_out_config.value.metric != null ? [scale_out_config.value.metric] : []
            content {
              metric_type = metric.value.metric_type
              dynamic "threshold" {
                for_each = metric.value.threshold != null ? [metric.value.threshold] : []
                content {
                  duration_in_minutes = threshold.value.duration_in_minutes
                  operator            = threshold.value.operator
                  value               = threshold.value.value
                }
              }
            }
          }
          step_size = scale_out_config.value.step_size
        }
      }
      dynamic "scale_up_config" {
        for_each = policy_details.value.scale_up_config != null ? [policy_details.value.scale_up_config] : []
        content {
          max_memory_per_node = scale_up_config.value.max_memory_per_node
          max_ocpus_per_node  = scale_up_config.value.max_ocpus_per_node
          memory_step_size    = scale_up_config.value.memory_step_size
          dynamic "metric" {
            for_each = scale_up_config.value.metric != null ? [scale_up_config.value.metric] : []
            content {
              metric_type = metric.value.metric_type
              dynamic "threshold" {
                for_each = metric.value.threshold != null ? [metric.value.threshold] : []
                content {
                  duration_in_minutes = threshold.value.duration_in_minutes
                  operator            = threshold.value.operator
                  value               = threshold.value.value
                }
              }
            }
          }
          ocpu_step_size = scale_up_config.value.ocpu_step_size
        }
      }
      dynamic "schedule_details" {
        for_each = policy_details.value.schedule_details != null ? policy_details.value.schedule_details : []
        content {
          schedule_type = schedule_details.value.schedule_type
          dynamic "time_and_horizontal_scaling_config" {
            for_each = schedule_details.value.time_and_horizontal_scaling_config != null ? schedule_details.value.time_and_horizontal_scaling_config : []
            content {
              target_node_count = time_and_horizontal_scaling_config.value.target_node_count
              time_recurrence   = time_and_horizontal_scaling_config.value.time_recurrence
            }
          }
          dynamic "time_and_vertical_scaling_config" {
            for_each = schedule_details.value.time_and_vertical_scaling_config != null ? schedule_details.value.time_and_vertical_scaling_config : []
            content {
              target_memory_per_node = time_and_vertical_scaling_config.value.target_memory_per_node
              target_ocpus_per_node  = time_and_vertical_scaling_config.value.target_ocpus_per_node
              target_shape           = time_and_vertical_scaling_config.value.target_shape
              time_recurrence        = time_and_vertical_scaling_config.value.time_recurrence
            }
          }
        }
      }
      timezone = policy_details.value.timezone
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

