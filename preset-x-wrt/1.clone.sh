#!/usr/bin/env bash

# download base code
CODE_DIR=_firmware_code
SWITCH_LATEST_TAG=false
git clone https://github.com/x-wrt/x-wrt.git $CODE_DIR
if $SWITCH_LATEST_TAG; then
    cd $CODE_DIR
    LATEST_TAG_HASH=$(git rev-list --tags --max-count=1)
    if [ -z "$LATEST_TAG_HASH" ]; then
        echo "No tag to switch, keep the latest commit"
    else
        git checkout $LATEST_TAG_HASH
        LATEST_TAG=$(git describe --tags $LATEST_TAG_HASH)
        echo "The code has been switched to the latest stable version $LATEST_TAG"
    fi
    cd ..
fi
mv ./$CODE_DIR/* ./

# download app codes
SUPPLY_DIR=_supply_packages
echo "src-link supply $PWD/$SUPPLY_DIR" >> feeds.conf.default
mkdir $SUPPLY_DIR && cd $SUPPLY_DIR
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
git clone --depth 1 https://github.com/yichya/luci-app-xray.git
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
git clone --depth=1 https://github.com/sirpdboy/luci-app-netwizard
