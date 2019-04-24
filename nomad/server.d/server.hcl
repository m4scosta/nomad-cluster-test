data_dir = "/tmp"

server {
  enabled = true
  bootstrap_expect = 3
}

autopilot {
  cleanup_dead_servers = true
  last_contact_threshold = "200ms"
  max_trailing_logs = 250
  server_stabilization_time = "10s"
  enable_redundancy_zones = false
  disable_upgrade_migration = false
  enable_custom_upgrades = false
}

