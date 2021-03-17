pkg_name=concourse
pkg_origin=core
pkg_version="4.2.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="CI that scales with your project"
pkg_upstream_url="https://concourse.ci"
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_linux_amd64"
pkg_filename="${pkg_name}_linux_amd64"
pkg_shasum="02a91365131aaa87039c95d79dd898fb4b6cde3c55e6545a442e09b5fc809d23"

pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/patchelf
)
pkg_bin_dirs=(bin)

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}"
    mv "${pkg_name}_linux_amd64" "${pkg_name}"
    chmod +x "${pkg_name}"
  popd
}

do_build(){
  return 0
}

do_install(){
  cp "$HAB_CACHE_SRC_PATH/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}" || exit 1
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    "${pkg_prefix}/bin/concourse"
}
