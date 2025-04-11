resource "elasticstack_kibana_space" "cez" {
  space_id = "cez"
  name     = "CEZ"
  disabled_features = [
    "generalCasesV2",
    "observabilityCasesV2",
    "securitySolutionCasesV2",
    "actions",
    "advancedSettings",
    "apm",
    "canvas",
    "dev_tools",
    "filesManagement",
    "filesSharedImage",
    "fleet",
    "fleetv2",
    "guidedOnboardingFeature",
    "indexPatterns",
    "infrastructure",
    "logs",
    "maintenanceWindow",
    "maps",
    "ml",
    "monitoring",
    "osquery",
    "rulesSettings",
    "savedObjectsManagement",
    "savedObjectsTagging",
    "savedQueryManagement",
    "siem",
    "slo",
    "stackAlerts",
    "uptime",
    "visualize",
    "enterpriseSearch",
    "ingestManager",
  ]
  initials = "C"
}
