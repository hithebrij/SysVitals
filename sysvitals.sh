#!/bin/bash

# Set up variables
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
OS=$(uname -o)
KERNEL=$(uname -r)
DATE=$(date '+%Y-%m-%d %H:%M:%S')
HTML_FILE="reports/server-health-$(date '+%Y%m%d-%H%M').html"

# Collect data
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}')
MEM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
DISK=$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')
LOAD=$(uptime | awk -F'load average:' '{ print $2 }')

TOP_CPU=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)
TOP_MEM=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6)

NET_STATS=$(ip -4 a | grep inet)

# CLI Output
echo -e "\n📊 Server Health Dashboard - $DATE"
echo "------------------------------------------"
echo "Hostname     : $HOSTNAME"
echo "OS/Kernel    : $OS / $KERNEL"
echo "Uptime       : $UPTIME"
echo "CPU Usage    : $CPU"
echo "Memory Usage : $MEM"
echo "Disk Usage   : $DISK"
echo "Load Average : $LOAD"
echo -e "\n📈 Top 5 CPU Consuming Processes:"
echo "$TOP_CPU"
echo -e "\n📈 Top 5 Memory Consuming Processes:"
echo "$TOP_MEM"
echo -e "\n🌐 Network Interfaces:"
echo "$NET_STATS"

# HTML Output
mkdir -p reports
cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Server Health Dashboard</title>
    <style>
        body { font-family: monospace; background: #f5f5f5; padding: 20px; }
        h1 { color: #444; }
        pre { background: #fff; padding: 10px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <h1>📊 Server Health Dashboard</h1>
    <p><strong>Date:</strong> $DATE</p>
    <p><strong>Hostname:</strong> $HOSTNAME</p>
    <p><strong>OS:</strong> $OS</p>
    <p><strong>Kernel:</strong> $KERNEL</p>
    <p><strong>Uptime:</strong> $UPTIME</p>
    <p><strong>CPU Usage:</strong> $CPU</p>
    <p><strong>Memory Usage:</strong> $MEM</p>
    <p><strong>Disk Usage:</strong> $DISK</p>
    <p><strong>Load Average:</strong> $LOAD</p>

    <h2>📈 Top 5 CPU Consuming Processes</h2>
    <pre>$TOP_CPU</pre>

    <h2>📈 Top 5 Memory Consuming Processes</h2>
    <pre>$TOP_MEM</pre>

    <h2>🌐 Network Interfaces</h2>
    <pre>$NET_STATS</pre>
</body>
</html>
EOF

echo -e "\n✅ HTML report saved at: $HTML_FILE"
