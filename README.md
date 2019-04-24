# Nomad cluster test

Docker compose provisioned Hashicorp Nomad cluster.

## Task List/Next steps
- [X] setup Consul server cluster
- [X] setup Consul client on Nomad servers and nodes
- [X] auto cluster nomad using Consul
- [X] register web service automatically on Consul
- [X] do load balancing using Fabio
- [ ] document new version that includes Consul
- [ ] use Consul service mesh features
  - [X] Service registration and discovery
  - [ ] Service configuration
  - [ ] Service segregation
- [ ] Use TLS communication between Consul clients and servers
- [ ] Use TLS communication between Nomad clients and servers
- [ ] create Terraform script to provision all infrastructure
  - [ ] VPC
    - [ ] Internet Gateway
      - [ ] Route table
      - [ ] Route table assoc
    - [ ] Public subnet
      - [ ] NAT gateway
      - [ ] Bastion host
    - [ ] Private subnet
      - [ ] ASG for Consul server
      - [ ] ASG for Nomad server
      - [ ] ASG for Nomad client
      - [ ] LB for Nomad clients
- [ ] Access web application running inside Nomad via LB
- [ ] Run periodic jobs on Nomad
- [ ] Run some synchronous multi service communication
- [ ] Implement circuit braker, fallback and retry (maybe Envoy will help on this)
- [ ] Collect and aggregate service logs
- [ ] Implement distributed tracing
- [ ] Write an article and talk about this subject to share acquired knowledge
- [ ] Do all these activities using Kubernetes, GCP, Azure

## Dependencies

- docker
- docker-compose
- nomad

## Usage

It is necessary to build image first, to do so run:

```shell
docker-compose build
```

Then just type in your CLI:

```shell
docker-compose up
```

Note in server/follower configuration files that nomad cluster expects 3 instances to start but we have only two
nodes provisioned by default, in order to have the minimum quorum for leader election we need to scale our
`nomad-follower`s to 2.

```shell
docker-compose scale nomad-follower=2
```

To control the nomad cluster from your host you'll need to configure it, check https://www.nomadproject.io/docs/commands/index.html#remote-usage for details on how to do it.

After that you'll able to schedule new jobs to the nomad cluster:

```shell
nomad plan jobs/echo.hcl

# get this command from the previous command
nomad job run -check-index <INDEX> jobs/echo.hcl
```

To check if the job/task is running, just get the IP address and port of some allocation:

```shell
nomad job status echo
# ID            = echo
# Name          = echo
# Submit Date   = 2019-04-10T09:17:52-03:00
# Type          = service
# Priority      = 50
# Datacenters   = dc1,dc2
# Status        = running
# Periodic      = false
# Parameterized = false
#
# Summary
# Task Group  Queued  Starting  Running  Failed  Complete  Lost
# web         0       0         2        0       0         0
#
# Allocations
# ID        Node ID   Task Group  Version  Desired  Status    Created     Modified
# 69c07707  841f3da7  web         8        run      running   32m39s ago  17m20s ago
# 2b4fa8aa  48316b39  web         8        run      running   32m39s ago  17m20s ago


# Change to your own alloc id
nomad alloc status 69c07707
# ID                  = 69c07707
# Eval ID             = 549fa229
# Name                = echo.web[0]
# Node ID             = 841f3da7
# Job ID              = echo
# Job Version         = 8
# Client Status       = running
# Client Description  = Tasks are running
# Desired Status      = run
# Desired Description = <none>
# Created             = 34m57s ago
# Modified            = 19m38s ago
#
# Task "server" is "running"
# Task Resources
# CPU        Memory           Disk     Addresses
# 0/100 MHz  1.8 MiB/300 MiB  300 MiB  http: 172.21.0.8:23680 # <- this is the address
# ...

```

Access the address via browser or curl:

```shell
curl 172.21.0.8:23680
```
