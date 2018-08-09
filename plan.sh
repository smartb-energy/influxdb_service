pkg_origin=smartb
pkg_name=influx
pkg_description="Composite package for InfluxDB and related services."
pkg_upstream_url="https://www.influxdata.com/time-series-platform/"
pkg_type=composite
pkg_version="0.1.0"
pkg_services=(
  smartb/chronograf
  smartb/influxdb
)
