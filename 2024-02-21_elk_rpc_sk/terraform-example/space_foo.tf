resource "elasticstack_kibana_space" "foo" {
  space_id = "foo"
  name     = "Foo"
  color    = "#00FF00"
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
  initials = "F"
}
