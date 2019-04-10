data_dir = "/tmp"

server {
  enabled = true
  bootstrap_expect = 3

  server_join {
    retry_join = ["nomad-server:4648"]
  }
}
