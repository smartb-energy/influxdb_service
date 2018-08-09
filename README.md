## Description
This repository provides InfluxDB and related services as Habitat packages.

## Prerequisites
You should install and configure the `direnv` utility for best results. See https://direnv.net

## CLI Usage
This service can be loaded or run using the `smartb/influx` package identifier:
```
# with no running Supervisor
hab sup run smartb/influx

# with a running Supervisor
hab svc load smartb/influx
```

## Terraform Usage
The service can be loaded in Terraform like this:
```
provisioner "habitat" {
  builder_auth_token = "${var.HAB_AUTH_TOKEN}"
  service_type       = "systemd"
  version            = "${var.habitat_version}"
  service {
    name      = "smartb/influx"
}
```

For more information on running Habitat service packages, see https://www.habitat.sh/docs/using-habitat/#using-packages
