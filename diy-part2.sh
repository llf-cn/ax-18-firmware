#!/bin/bash

# 1. 修改默认后台 IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 2. 拉取最新的 OpenClash 源码
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# 3. 强制使用 dnsmasq-full
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

# 4. 修改默认时区为上海
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].timezone='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 5. 从硬件定义层面删除无线依赖 (针对 CMIOT AX18 深度清理)
# 这一步是解决无线菜单残留的关键，防止编译系统自动拉回依赖
sed -i '/wpad/d' target/linux/qualcommax/image/ipq60xx.mk
sed -i '/hostapd/d' target/linux/qualcommax/image/ipq60xx.mk
sed -i '/ath11k/d' target/linux/qualcommax/image/ipq60xx.mk
sed -i '/wifi-meshmgr/d' target/linux/qualcommax/image/ipq60xx.mk

# 6. 抹除无线初始化定义，彻底消灭 radio0 / radio1
rm -f package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

# 7. 移除 rpcd 的无线扩展，防止 LuCI 后台扫描无线设备
sed -i 's/rpcd-mod-iwinfo//g' include/target.mk
