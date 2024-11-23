#!/bin/sh

set -e

os=$(grep ^ID= /etc/os-release | cut -d'=' -f2-)
arch=""
case "${os}" in
  ubuntu) arch=_amd64.deb ;;
  debian) arch=_amd64.deb ;;
  *) arch= ;;
esac

if test -z "$arch"; then
  echo "Error: Unsupported OS" $(grep ^NAME= /etc/os-release | cut -d'=' -f2-)
  return 1
fi

version=$(curl -sL https://api.github.com/repos/yonasBSD/cargo2junit/releases/latest | jq -r ".tag_name" | cut -d'v' -f2)
bin=cargo2junit_${version}_${arch}
wget https://github.com/yonasBSD/cargo2junit/releases/download/v${version}/${bin}
sudo dpkg -i cargo2junit_${bin}
rm cargo2junit_${bin}
