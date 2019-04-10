job "echo" {
  datacenters = ["dc1", "dc2"]

  type = "service"

  group "web" {
    count = 2

    task "server" {
      driver = "docker"

      config {
        image = "jmalloc/echo-server"

        port_map = {
          http = 8080
        }
      }

      service {
        tags = ["http", "echo"]

        port = "http"

        check {
          type = "tcp"
          port = "http"
          interval = "1s"
          timeout = "2s"
        }
      }

      resources {
        network {
          port "http" {}
        }
      }
    }
  }
}
