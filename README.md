# Home-Network-Security-Checklist

![Internship](https://img.shields.io/badge/Internship-InternCircle_Cybersecurity-blue)
![Platform](https://img.shields.io/badge/Environment-Kali_Linux-557C94?logo=kalilinux&logoColor=white)
![Standards](https://img.shields.io/badge/Standards-CISA_%7C_NIST_SP_800--153-success)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

**Author:** Palla Venkata Mahesh  
**Date of Birth:** 16-11-2006  
**Track:** Cybersecurity Online Internship — Project 04[cite: 1]  
**Scope:** Authorized Home Wi-Fi & Local Area Network (LAN) Security Assessment[cite: 1, 2]  

---

## 1. Project Overview

This repository contains the complete technical documentation, Kali Linux automation scripts, audit logs, and structured Before-and-After checklists for **Project 04: Home Network Security Checklist**[cite: 1, 6]. The objective of this project is to assess an authorized home wireless network, identify connected endpoints and rogue/unnamed devices, remediate insecure router defaults (weak encryption, default credentials, exposed management ports, UPnP/WPS), segment IoT devices onto an isolated Guest Wi-Fi network, and verify endpoint patching and backup resilience[cite: 1, 2].

All practical assessments follow strict **Rules of Engagement**: testing is strictly confined to an owned/family-authorized home network with reversible configuration backups taken prior to remediation[cite: 1, 2].

---

## 2. Repository Architecture

```text
Home-Network-Security-Checklist-Project04/
├── README.md                                  # Project documentation, methodology, and execution guide
├── scripts/
│   └── home_network_audit.sh                  # Automated Kali Linux Bash audit script (before & after modes)[cite: 6, 7]
├── audit_logs/
│   ├── before/                                # Baseline scan logs (arp-scan, nmap, nmcli, DNS, SHA-256 hashes)[cite: 6, 7]
│   └── after/                                 # Post-remediation validation logs & SHA-256 integrity hashes[cite: 6, 7]
├── evidence/
│   └── screenshots/
│       └── REDACTION_CHECKLIST.txt            # Privacy & OPSEC verification checklist prior to submission[cite: 6, 8]
└── report/
    ├── home_network_security_project_04.pdf   # Final professional audit report & executive sign-off[cite: 6]
    ├── Home_Network_Security_Checklist.csv    # 12-control Before & After security checklist[cite: 6]
    └── Device_Inventory_Template.csv          # Local IP, MAC OUI vendor, and VLAN/Guest segmentation log[cite: 6]

```

---

## 3. Core Deliverables & Security Controls Covered

1. **Connected Device Discovery & Inventory:** Full enumeration of local subnet hosts using `arp-scan` and router DHCP tables, mapping local IPs (`192.168.1.x` primary LAN vs. `192.168.2.x` isolated Guest Wi-Fi), redacted MAC prefixes, and hardware OUI vendors.


2. **Wireless Cryptographic Hardening:** Transition from legacy WPA/WPA2 mixed mode to **WPA3-SAE / WPA2-AES (CCMP)** with a non-identifying custom SSID and a 20+ character passphrase.


3. **Router Administrative Surface Reduction:** Replacement of default router admin credentials, enforcement of HTTPS-only local management, and disabling of **Remote WAN Administration**, **WPS**, and **UPnP (UDP/1900)**.


4. **Firmware & Endpoint Hygiene:** Verification of router firmware updates, automatic OS/application patching across workstations and mobile devices, and 3-2-1 encrypted backup validation.


5. **IoT Network Segmentation & DNS Security:** Isolation of smart TVs and IoT smart plugs onto a Client-Isolated Guest Network, paired with encrypted malware-filtering DNS resolvers (Quad9 `9.9.9.9` / Cloudflare `1.1.1.2`) and SPI firewall/IPv6 inbound protection.
6. **Cryptographic Evidence Integrity:** Automated `sha256sum` hashing of all raw CLI audit outputs (`before/` and `after/`) to maintain tamper-evident audit logs.



---

## 4. Prerequisites & Kali Linux Setup

Ensure you are running Kali Linux on a physical wireless interface or a virtual machine configured with a **Bridged Network Adapter** so layer-2 ARP discovery can reach your physical home subnet.

```bash
sudo apt update && sudo apt install -y arp-scan nmap net-tools network-manager

```

---

## 5. Step-by-Step Execution Guide

1. **Clone or extract the project archive and make the audit script executable:**
```bash
cd Home-Network-Security-Checklist-Project04
chmod +x scripts/home_network_audit.sh

```


2. **Capture the "Before" Baseline (Prior to any router changes):**
Export a backup of your router's current configuration from the admin web panel, then run the baseline scan:


```bash
sudo ./scripts/home_network_audit.sh before

```


*Generated artifacts in `audit_logs/before/`:* `wifi_security_before.txt`, `dns_config_before.txt`, `device_inventory_before.txt`, `router_ports_before.txt`, `router_upnp_before.txt`, and `sha256_evidence_before.txt`.


3. **Execute Router & Device Hardening:**
Access your gateway admin portal (`http://192.168.1.1` or `https://192.168.1.1`) and apply the 12 security controls documented in `report/Home_Network_Security_Checklist.csv`. Save redacted configuration screenshots into `evidence/screenshots/`.


4. **Capture the "After" Validation Logs:**
Reconnect Kali Linux to your hardened primary Wi-Fi network and run the post-remediation scan:


```bash
sudo ./scripts/home_network_audit.sh after

```


5. **Compare Before vs. After Results:**
```bash
diff -u audit_logs/before/router_ports_before.txt audit_logs/after/router_ports_after.txt
diff -u audit_logs/before/device_inventory_before.txt audit_logs/after/device_inventory_after.txt

```



---

## 6. OPSEC & Pre-Submission Verification

Before pushing to GitHub or sharing via Google Drive, verify all items in `evidence/screenshots/REDACTION_CHECKLIST.txt`:

* [x] Only an owned/authorized home network was audited.


* [x] Original router settings were backed up before modification.


* [x] Home SSIDs, Wi-Fi passphrases, admin passwords, public WAN IPs, and full MAC addresses are redacted from all screenshots and public logs.


* [x] Remaining risks (such as legacy IoT devices without vendor firmware support isolated on the Guest network) are documented in the final PDF report.



```

```
