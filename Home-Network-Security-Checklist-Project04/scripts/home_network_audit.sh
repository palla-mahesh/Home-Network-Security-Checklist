#!/usr/bin/env bash
# ==============================================================================
# Project 04: Home Network Security Checklist - Kali Linux Audit Script
# Author: Palla Venkata Mahesh (DOB: 16-11-2006)
# Usage: sudo ./scripts/home_network_audit.sh [before|after]
# ==============================================================================

set -euo pipefail

MODE="${1:-}"
if [[ "$MODE" != "before" && "$MODE" != "after" ]]; then
    echo "Usage: sudo $0 [before|after]"
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "[!] Please run as root (sudo $0 $MODE)"
    exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$BASE_DIR/audit_logs/$MODE"
mkdir -p "$OUT_DIR"

GATEWAY_IP=$(ip route | awk '/default/ {print $3; exit}')
IFACE=$(ip route | awk '/default/ {print $5; exit}')

echo "============================================================"
echo " Home Network Security Audit - Phase: ${MODE^^}"
echo " Timestamp : $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo " Interface : ${IFACE:-Unknown}"
echo " Gateway   : ${GATEWAY_IP:-Unknown}"
echo "============================================================"

# 1. Wi-Fi Encryption & Channel Baseline
echo "[1/5] Checking Wi-Fi encryption & SSID list..."
if command -v nmcli >/dev/null 2>&1; then
    nmcli -f SSID,SECURITY,CHAN,SIGNAL dev wifi list > "$OUT_DIR/wifi_security_${MODE}.txt" 2>&1 || true
else
    iwconfig > "$OUT_DIR/wifi_security_${MODE}.txt" 2>&1 || true
fi

# 2. DNS Resolver Status
echo "[2/5] Recording active DNS servers..."
if command -v resolvectl >/dev/null 2>&1; then
    resolvectl status > "$OUT_DIR/dns_config_${MODE}.txt" 2>&1 || true
else
    cat /etc/resolv.conf > "$OUT_DIR/dns_config_${MODE}.txt"
fi

# 3. Local Subnet Device Discovery (ARP Scan)
echo "[3/5] Running local ARP device discovery..."
if command -v arp-scan >/dev/null 2>&1 && [[ -n "$IFACE" ]]; then
    arp-scan --interface="$IFACE" --localnet > "$OUT_DIR/device_inventory_${MODE}.txt" 2>&1 || true
else
    ip neigh show > "$OUT_DIR/device_inventory_${MODE}.txt"
fi

# 4. Router Management Port & UPnP Exposure Scan
echo "[4/5] Scanning router gateway ($GATEWAY_IP) for exposed admin & UPnP ports..."
if command -v nmap >/dev/null 2>&1 && [[ -n "$GATEWAY_IP" ]]; then
    nmap -sV -p 21,22,23,53,80,443,1900,5000,8080,8443 "$GATEWAY_IP" -oN "$OUT_DIR/router_ports_${MODE}.txt" >/dev/null 2>&1 || true
    nmap -sU -p 1900 --script upnp-info "$GATEWAY_IP" -oN "$OUT_DIR/router_upnp_${MODE}.txt" >/dev/null 2>&1 || true
fi

# 5. Generate SHA-256 Evidence Integrity Hashes
echo "[5/5] Generating SHA-256 integrity hashes..."
sha256sum "$OUT_DIR"/*.txt > "$OUT_DIR/sha256_evidence_${MODE}.txt"

echo "[+] Audit phase '$MODE' completed. Logs saved in: $OUT_DIR"
