pkg_origin=smartb
pkg_name=chronograf
pkg_version="1.6.1"
pkg_maintainer="Blake Irvin <blake.irvin@smartb.eu>"
pkg_deps=(
  core/coreutils
  core/go
  core/make
  core/node
  core/yarn
)
pkg_build_deps=(core/git)
pkg_bin_dirs=(bin)
pkg_svc_run="chronograf run -config $pkg_svc_config_path/chronograf.conf"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_description="Installs, confugures, and runs Chronograf."
pkg_upstream_url="https://github.com/influxdata/chronograf"

do_setup_environment() {
  set_runtime_env GOPATH "${HAB_CACHE_SRC_PATH}"
  set_runtime_env BOLT_PATH "/hab/svc/$pkg_name/data/$pkg_name.db"
}

do_extract(){
  return 0
}

do_prepare() {
  export PATH=$PATH:$HAB_CACHE_SRC_PATH/bin
  hab pkg binlink core/coreutils env --dest /usr/bin
  return $?
}

do_build(){
  go get -u -v github.com/influxdata/chronograf
  cd $GOPATH/src/github.com/influxdata/chronograf
  make
}

do_check() {
  cd $GOPATH/src/github.com/influxdata/chronograf
  make test
}

do_install() {
  go install github.com/influxdata/chronograf/cmd/chronograf
  for binary_path in $HAB_CACHE_SRC_PATH/bin/*; do
    build_line "Installing $binary_path"
    chmod +x $binary_path
    install -D $binary_path "$pkg_prefix/bin/$(basename $binary_path)"
  done
}
