# Project 04: Home Network Security Checklist (InternCircle Cybersecurity Internship)

**Intern Name:** Palla Venkata Mahesh  
**Date of Birth:** 16-11-2006  
**Environment:** Kali Linux  
**Alignment:** CISA Home Network Security Guidelines & NIST SP 800-153  

## Repository & Project Structure

```text
Home-Network-Security-Checklist-Project04/
├── README.md                                  # Project overview, rules of engagement, and quickstart guide
├── scripts/
│   └── home_network_audit.sh                  # Automated Kali Linux Bash audit script (Before & After modes)
├── audit_logs/
│   ├── before/                                # Baseline scan logs (arp-scan, nmap, nmcli, dns)
│   │   └── .gitkeep
│   └── after/                                 # Post-hardening validation logs & SHA-256 integrity hashes
│       └── .gitkeep
├── evidence/
│   └── screenshots/                           # Redacted router configuration screenshots
│       └── REDACTION_CHECKLIST.txt
└── report/
    ├── Home_Network_Security_Checklist.csv    # Structured Before & After audit checklist template
    └── Device_Inventory_Template.csv          # Local IP, MAC OUI, and Guest Wi-Fi segmentation tracker
```

## Quick Start on Kali Linux

1. **Grant execution permissions to the audit script:**
   ```bash
   chmod +x scripts/home_network_audit.sh
   ```
2. **Run the "Before" baseline scan (prior to changing router settings):**
   ```bash
   sudo ./scripts/home_network_audit.sh before
   ```
3. **Apply router and endpoint hardening changes** (WPA2/WPA3, strong admin password, disable remote WAN management/WPS/UPnP, update firmware, enable Guest Wi-Fi for IoT devices).
4. **Run the "After" validation scan:**
   ```bash
   sudo ./scripts/home_network_audit.sh after
   ```
5. **Attach redacted screenshots** into `evidence/screenshots/` and compile your final PDF report (`home_network_security_project_04.pdf`) into `report/`.
