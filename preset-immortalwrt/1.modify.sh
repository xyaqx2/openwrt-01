#!/usr/bin/env bash

# modify login IP
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# modify Default Theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# replace geodata source
. $(dirname $0)/../extra-files/update-geodata.sh
