================================
===== Interface Management =====
================================

# Show all network interfaces and their IP addresses
ip addr show

# Bring up a network interface
ip link set eth0 up

# Show interface statistics (packets, errors, etc.)
ip -s link


===========================================
== Network Management via NetworkManager ==
===========================================

# Show status of all devices
nmcli device status

# Show available Wi-Fi networks using NetworkManager
nmcli device wifi list

# Show detailed info for Wi-Fi interface
nmcli device show wlo1

# Show saved connections
nmcli connection show


================================
====== Ethernet Interface ======
================================

# Show NIC settings (speed, duplex, etc.)
ethtool eth0                   

# Set specific NIC settings         
ethtool -s eth0 speed 1000 duplex full autoneg off


================================
====== Wireless Interface ======
================================

# List all visible Wi-Fi networks
iw dev wlo1 scan

# Show detailed info about the current Wi-Fi connection
iw dev wlo1 link

# Show Wi-Fi device block status
rfkill list

# Unblock Wi-Fi if blocked
rfkill unblock wifi


======================================
== Network Scanning and Diagnostics ==
======================================

# Trace the route packets take to a destination
traceroute google.com
# Real-time traceroute with packet loss and latency stats
mtr -rw google.com

# Test if remote host is reachable
ping -c 4 google.com

# Test if a specific port is open using netcat
nc -zv 192.168.1.1 22


===========================================
== Network Scanning and Security Testing ==
===========================================

# TCP SYN scan on local network
nmap -sS 192.168.1.0/24

# Aggressive scan with OS detection
nmap -A -T4 google.com

# Vulnerability scan using built-in scripts
nmap --script=vuln google.com


================================
== Connection and Socket Info ==
================================

# Show TCP and UDP sockets
ss -tuln

# Show summary of socket stats
ss -s

# Show all established TCP connections with process info
ss -tp state established


=================================
== Packet Capture and Analysis ==
=================================

# Capture HTTP traffic on interface eth0
tcpdump -i wlo1 port 80

# Capture all traffic on eth0 without name resolution
tcpdump -nn -v -i wlo1

# Save captured packets to a file
tcpdump -i wlo1 -w packets.pcap


=============================
====== Routing and ARP ======
=============================

# Show current routing table
ip route show

# Show ARP table (neighbor cache)
ip neigh

# Display ARP cache without resolving names
arp -n


==================================
== Firewall and Traffic Control ==
==================================

# Show all iptables rules with counters
sudo iptables -L -n -v

# Allow incoming SSH traffic
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# List all nftables rules
sudo nft list ruleset


==============================
==== Bandwidth Monitoring ====
==============================

# Show bandwidth usage per connection
iftop -i wlo1

# Show bandwidth usage per process
nethogs wlo1


===============================
========= DNS Tools ===========
===============================

# Get A record quickly
dig ctu.edu.vn +short

# Trace full DNS resolution path
dig +trace ctu.edu.vn

# Show all DNS records for a domain
host -a ctu.edu.vn


===============================
===== Performance Testing =====
===============================

# Start iperf3 server
iperf3 -s

# Run iperf3 client
iperf3 -c 192.168.0.x