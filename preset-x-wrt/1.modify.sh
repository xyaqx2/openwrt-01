#!/usr/bin/env bash

# modify login IP
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# copy uci-defaults script(s)
mkdir -p files/etc/uci-defaults
cp $(dirname $0)/uci-scripts/* files/etc/uci-defaults/

# modify default package(s)
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

# modify luci-app-xray category
modify_lax_category() {
    local mk=$1
    sed -i 's/SECTION:=Custom/CATEGORY:=LuCI/g' $mk
    sed -i 's/CATEGORY:=Extra packages/SUBMENU:=3. Applications/g' $mk
}
modify_lax_category 'package/feeds/supply/luci-app-xray-core/Makefile'
modify_lax_category 'package/feeds/supply/luci-app-xray-status/Makefile'

# replace geodata source
. $(dirname $0)/../extra-files/update-geodata.sh

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Haiibo/g" package/lean/default-settings/files/zzz-default-settings
