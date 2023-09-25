# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#monitoring_role_arn

module "rds_monitoring_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.18.0"

  role_description      = "Used for enhanced monitoring of rds"
  policy_document_count = 0
  managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
  principals = {
    Service = ["monitoring.rds.amazonaws.com"]
  }

  context = module.this.context
  name    = "${module.this.name}-rds-monitoring-role"
  enabled = module.this.enabled && var.rds_monitoring_interval != "0"
}
