🖥️ SysVitals – Automated Server Health Dashboard

**SysVitals** is a powerful yet lightweight Bash script that gives you real-time insights into your server’s health. It’s designed for Linux system administrators who want clean system status reporting without setting up complex monitoring tools like Zabbix, Prometheus, or Nagios.

---

🔍 Features

📊 Monitors:
- CPU usage
- Memory usage
- Disk space
- Load average
- Top 5 CPU- and memory-consuming processes
- Network interface stats

🖨️ Generates:
- Clean terminal-based summary
- Timestamped HTML reports in `/reports` directory

🧪 Can be scheduled via `cron` for automated snapshots  
⚙️ No dependencies beyond core Linux utilities  
📂 Reports are saved with readable timestamps

---

## 🛠️ Installation

1. **Clone the repo**
```bash
git clone https://github.com/hithebrij/sysvitals.git
cd sysvitals
```

2. **Make the script executable**
```bash
chmod +x sysvitals.sh
```
---

## 🚀 Usage

Run manually:
```bash
./sysvitals.sh
```

Schedule with cron:
```bash
crontab -e
```

Add this to run daily at midnight:
```cron
0 0 * * * /path/to/sysvitals.sh
```
---

## ⚙️ Configuration

- All output is printed to terminal and saved as an HTML file inside ```reports/```
- No external configuration is required
- Optional: You can modify the script to add email alerts or use your own custom CSS
