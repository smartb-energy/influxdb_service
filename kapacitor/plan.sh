pkg_origin=smartb
pkg_name=kapacitor
pkg_version="1.5.1"
pkg_description="Installs, configures, and runs Kapacitor."
pkg_maintainer="Blake Irvin <blake.irvin@smartb.eu>"
pkg_deps=(
  core/coreutils
  core/go
  core/node
)
pkg_build_deps=(
  core/gcc
  core/git
  core/make
  core/yarn
)
pkg_bin_dirs=(bin)
pkg_svc_run="kapacitord -config $pkg_svc_config_path/kapacitor.conf"
pkg_upstream_url="https://github.com/influxdata/kapacitor"

do_setup_environment() {
  set_runtime_env GOPATH "${HAB_CACHE_SRC_PATH}"
}

do_extract(){
  return 0
}

do_build(){
  go get -u -v github.com/influxdata/kapacitor/cmd/kapacitor
  go get -u -v github.com/influxdata/kapacitor/cmd/kapacitord
  cd $GOPATH/src/github.com/influxdata/kapacitor
  go build ./cmd/kapacitor
  go build ./cmd/kapacitord
}

do_install() {
  cp $GOPATH/src/github.com/influxdata/kapacitor/kapacitor  "$pkg_prefix/bin/kapacitor"
  cp $GOPATH/src/github.com/influxdata/kapacitor/kapacitord "$pkg_prefix/bin/kapacitord"
}
