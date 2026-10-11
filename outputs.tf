output "bds_auto_scaling_configurations_id" {
  description = "Map of id values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no id are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.id if v.id != null && length(v.id) > 0 }
}
output "bds_auto_scaling_configurations_bds_instance_id" {
  description = "Map of bds_instance_id values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no bds_instance_id are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.bds_instance_id if v.bds_instance_id != null && length(v.bds_instance_id) > 0 }
}
output "bds_auto_scaling_configurations_cluster_admin_password" {
  description = "Map of cluster_admin_password values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no cluster_admin_password are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.cluster_admin_password if v.cluster_admin_password != null && length(v.cluster_admin_password) > 0 }
  sensitive   = true
}
output "bds_auto_scaling_configurations_display_name" {
  description = "Map of display_name values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no display_name are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.display_name if v.display_name != null && length(v.display_name) > 0 }
}
output "bds_auto_scaling_configurations_is_enabled" {
  description = "Map of is_enabled values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no is_enabled are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.is_enabled if v.is_enabled != null }
}
output "bds_auto_scaling_configurations_node_type" {
  description = "Map of node_type values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no node_type are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.node_type if v.node_type != null && length(v.node_type) > 0 }
}
output "bds_auto_scaling_configurations_policy" {
  description = "Map of policy values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no policy are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => one(v.policy) if v.policy != null && length(v.policy) > 0 }
}
output "bds_auto_scaling_configurations_policy_details" {
  description = "Map of policy_details values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no policy_details are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => one(v.policy_details) if v.policy_details != null && length(v.policy_details) > 0 }
}
output "bds_auto_scaling_configurations_secret_id" {
  description = "Map of secret_id values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no secret_id are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.secret_id if v.secret_id != null && length(v.secret_id) > 0 }
}
output "bds_auto_scaling_configurations_state" {
  description = "Map of state values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no state are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.state if v.state != null && length(v.state) > 0 }
}
output "bds_auto_scaling_configurations_time_created" {
  description = "Map of time_created values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no time_created are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.time_created if v.time_created != null && length(v.time_created) > 0 }
}
output "bds_auto_scaling_configurations_time_updated" {
  description = "Map of time_updated values across all bds_auto_scaling_configurations, keyed the same as var.bds_auto_scaling_configurations except keys with no time_updated are omitted"
  value       = { for k, v in oci_bds_auto_scaling_configuration.bds_auto_scaling_configurations : k => v.time_updated if v.time_updated != null && length(v.time_updated) > 0 }
}

