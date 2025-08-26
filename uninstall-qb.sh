#!/bin/bash
set -e

INSTALL_PATH="/root/x86_64-qbittorrent-nox"
SERVICE_FILE="/etc/systemd/system/qbittorrent.service"

echo "==> 停止并禁用 qBittorrent 服务..."
systemctl stop qbittorrent || true
systemctl disable qbittorrent || true

echo "==> 删除 systemd 服务文件..."
rm -f "$SERVICE_FILE"
systemctl daemon-reload

echo "==> 删除安装的 qBittorrent 二进制文件..."
rm -f "$INSTALL_PATH"

echo "==> 删除用户配置文件(可选)..."
rm -rf ~/.config/qBittorrent
rm -rf ~/.local/share/data/qBittorrent

echo "==> 恢复 TCP 参数(删除安装脚本追加的内容)..."
sed -i '/net.ipv4.tcp_no_metrics_save/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_ecn/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_frto/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_rfc1337/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_sack/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_fack/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_window_scaling/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_adv_win_scale/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_moderate_rcvbuf/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
sed -i '/net.ipv4.udp_rmem_min/d' /etc/sysctl.conf
sed -i '/net.ipv4.udp_wmem_min/d' /etc/sysctl.conf
sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf

sysctl -p || true
sysctl --system || true

echo "qBittorrent 已彻底卸载完成。"
