#!/bin/bash
# File name: diy-part2.sh

# 1. 修改默认后台 IP 为 192.168.0.1
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 2. 拉取最新的 OpenClash 源码
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# 3. 强制使用 dnsmasq-full 满足 OpenClash 需求
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

# 4. 强制在编译前从配置中剔除所有无线包定义（双重保险，防止 hostapd 报错）
sed -i '/wpad/d' .config
sed -i '/hostapd/d' .config
sed -i '/kmod-ath/d' .config
