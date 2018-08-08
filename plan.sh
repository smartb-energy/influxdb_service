pkg_name=influxdb
pkg_origin=smartb
pkg_version="1.7.0"
pkg_maintainer="Blake Irvin <blake.irvin@smartb.eu>" # Prior art credit to John Kerry <john@kerryhouse.net>
pkg_license=("Apache-2.0")
pkg_deps=(core/go)
pkg_build_deps=(core/git)
pkg_bin_dirs=(bin)
pkg_svc_run="influxd run -config $pkg_svc_config_path/influxdb.conf"
pkg_exports=(
  [http-port]=influxdb.http.bind-port
  [ifql-port]=influxdb.ifql.bind-port
  [rpc-port]=influxdb.bind-port
)
pkg_exposes=(http-port ifql-port rpc-port)
pkg_description="Installs, confugures, and runs influxdb."
pkg_upstream_url="https://github.com/influxdata/influxdb"

do_setup_environment() {
  set_runtime_env GOPATH "${HAB_CACHE_SRC_PATH}"
}

do_extract(){
  return 0
}

do_build(){
  go get -u -v github.com/influxdata/influxdb
  cd $GOPATH/src/github.com/influxdata/
  go get -u -v ./...
  go install ./...
}

do_install() {
  for binary_path in $HAB_CACHE_SRC_PATH/bin/*; do
    build_line "Installing $binary_path"
    chmod +x $binary_path
    install -D $binary_path "$pkg_prefix/bin/$(basename $binary_path)"
  done
}
