#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 添加 OpenClash 源码
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# 2. 修正核心依赖（确保可以使用最新的 OpenClash 和 IPv6 功能）
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

# 3. 设置默认 IP（可选，如果想改默认后台地址，把下面 192.168.1.1 改掉）
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 在 diy-part2.sh 末尾添加
sed -i '/wpad/d' .config
sed -i '/hostapd/d' .config
sed -i '/kmod-ath/d' .config
