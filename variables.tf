variable "bds_auto_scaling_configurations" {
  description = <<EOT
Map of bds_auto_scaling_configurations, attributes below
Required:
    - bds_instance_id
    - is_enabled
    - node_type
Optional:
    - cluster_admin_password
    - display_name
    - secret_id
    - policy (block):
        - policy_type (required)
        - rules (required, block):
            - action (required)
            - metric (required, block):
                - metric_type (required)
                - threshold (required, block):
                    - duration_in_minutes (required)
                    - operator (required)
                    - value (required)
    - policy_details (block):
        - policy_type (required)
        - scale_down_config (optional, block):
            - memory_step_size (optional)
            - metric (optional, block):
                - metric_type (optional)
                - threshold (optional, block):
                    - duration_in_minutes (optional)
                    - operator (optional)
                    - value (optional)
            - min_memory_per_node (optional)
            - min_ocpus_per_node (optional)
            - ocpu_step_size (optional)
        - scale_in_config (optional, block):
            - metric (optional, block):
                - metric_type (optional)
                - threshold (optional, block):
                    - duration_in_minutes (optional)
                    - operator (optional)
                    - value (optional)
            - min_node_count (optional)
            - step_size (optional)
        - scale_out_config (optional, block):
            - max_node_count (optional)
            - metric (optional, block):
                - metric_type (optional)
                - threshold (optional, block):
                    - duration_in_minutes (optional)
                    - operator (optional)
                    - value (optional)
            - step_size (optional)
        - scale_up_config (optional, block):
            - max_memory_per_node (optional)
            - max_ocpus_per_node (optional)
            - memory_step_size (optional)
            - metric (optional, block):
                - metric_type (optional)
                - threshold (optional, block):
                    - duration_in_minutes (optional)
                    - operator (optional)
                    - value (optional)
            - ocpu_step_size (optional)
        - schedule_details (optional, block):
            - schedule_type (optional)
            - time_and_horizontal_scaling_config (optional, block):
                - target_node_count (optional)
                - time_recurrence (optional)
            - time_and_vertical_scaling_config (optional, block):
                - target_memory_per_node (optional)
                - target_ocpus_per_node (optional)
                - target_shape (optional)
                - time_recurrence (optional)
        - timezone (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    bds_instance_id        = string
    is_enabled             = bool
    node_type              = string
    cluster_admin_password = optional(string)
    display_name           = optional(string)
    secret_id              = optional(string)
    policy = optional(object({
      policy_type = string
      rules = list(object({
        action = string
        metric = object({
          metric_type = string
          threshold = object({
            duration_in_minutes = number
            operator            = string
            value               = number
          })
        })
      }))
    }))
    policy_details = optional(object({
      policy_type = string
      scale_down_config = optional(object({
        memory_step_size = optional(number)
        metric = optional(object({
          metric_type = optional(string)
          threshold = optional(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          }))
        }))
        min_memory_per_node = optional(number)
        min_ocpus_per_node  = optional(number)
        ocpu_step_size      = optional(number)
      }))
      scale_in_config = optional(object({
        metric = optional(object({
          metric_type = optional(string)
          threshold = optional(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          }))
        }))
        min_node_count = optional(number)
        step_size      = optional(number)
      }))
      scale_out_config = optional(object({
        max_node_count = optional(number)
        metric = optional(object({
          metric_type = optional(string)
          threshold = optional(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          }))
        }))
        step_size = optional(number)
      }))
      scale_up_config = optional(object({
        max_memory_per_node = optional(number)
        max_ocpus_per_node  = optional(number)
        memory_step_size    = optional(number)
        metric = optional(object({
          metric_type = optional(string)
          threshold = optional(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          }))
        }))
        ocpu_step_size = optional(number)
      }))
      schedule_details = optional(list(object({
        schedule_type = optional(string)
        time_and_horizontal_scaling_config = optional(list(object({
          target_node_count = optional(number)
          time_recurrence   = optional(string)
        })))
        time_and_vertical_scaling_config = optional(list(object({
          target_memory_per_node = optional(number)
          target_ocpus_per_node  = optional(number)
          target_shape           = optional(string)
          time_recurrence        = optional(string)
        })))
      })))
      timezone = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.bds_auto_scaling_configurations : (
        v.policy == null || (length(v.policy.rules) >= 1)
      )
    ])
    error_message = "Each rules list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.bds_auto_scaling_configurations : (
        v.policy_details == null || (contains([for v in ["METRIC_BASED_HORIZONTAL_SCALING_POLICY", "METRIC_BASED_VERTICAL_SCALING_POLICY", "SCHEDULE_BASED_HORIZONTAL_SCALING_POLICY", "SCHEDULE_BASED_VERTICAL_SCALING_POLICY"] : lower(v)], lower(v.policy_details.policy_type)))
      )
    ])
    error_message = "must be one of: \"METRIC_BASED_HORIZONTAL_SCALING_POLICY\", \"METRIC_BASED_VERTICAL_SCALING_POLICY\", \"SCHEDULE_BASED_HORIZONTAL_SCALING_POLICY\", \"SCHEDULE_BASED_VERTICAL_SCALING_POLICY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bds_auto_scaling_configurations : (
        v.policy_details == null || (v.policy_details.schedule_details == null || alltrue([for item in v.policy_details.schedule_details : (item.schedule_type == null || (contains([for v in ["DAY_BASED"] : lower(v)], lower(item.schedule_type))))]))
      )
    ])
    error_message = "must be one of: \"DAY_BASED\""
  }
}

