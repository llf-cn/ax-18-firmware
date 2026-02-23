#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#!/bin/bash

# 1. 添加 OpenClash 源码
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# 2. 强制修正 IPv6 依赖
# 确保 dnsmasq 被替换为 dnsmasq-full 以支持完整的 IPv6 和 OpenClash 转发
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk
