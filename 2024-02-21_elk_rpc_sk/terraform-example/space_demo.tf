resource "elasticstack_kibana_space" "demo" {
  space_id = "demo"
  name     = "Demo"
  color    = "#FF0000"
  disabled_features = [
    "ingestManager",
    "enterpriseSearch",
    "actions",
    "advancedSettings",
    "apm",
    "canvas",
    "dev_tools",
    "filesManagement",
    "filesSharedImage",
    "fleet",
    "fleetv2",
    "generalCases",
    "guidedOnboardingFeature",
    "infrastructure",
    "maintenanceWindow",
    "maps",
    "ml",
    "monitoring",
    "observabilityCases",
    "osquery",
    "rulesSettings",
    "savedObjectsManagement",
    "savedObjectsTagging",
    "savedQueryManagement",
    "securitySolutionCases",
    "siem",
    "slo",
    "stackAlerts",
    "uptime",
    "visualize",
  ]
  initials = "D"
}
