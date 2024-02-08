#!/bin/bash

# Function to display devices' IP addresses
function display_ip_addresses() {
echo "IP addresses of devices:"
ip addr show | grep -w inet | awk '{print $2}'
echo ""
}

################################################################################

# Function to display devices' MAC addresses
function display_mac_addresses() {
 echo "MAC addresses of devices (partial):"
ip link show | grep -w ether | awk '{print $2}'
echo ""
}

################################################################################

# Function to display router's internal and external IP addresses
function display_router_addresses() {
echo "Router's internal and external IP addresses (partial):"
ip route | grep default | awk '{print $3}'
echo ""
}

################################################################################

# Function to display device name
function display_device_name() {
 echo "Device name:"
hostname
echo ""
}

################################################################################

# Function to display DNS and DHCP IP addresses
function display_dns_dhcp_addresses() {
 echo "DNS and DHCP IP addresses:"
echo "DNS:"
cat /etc/resolv.conf | grep nameserver | awk '{print $2}'
echo ""
echo "DHCP:"
ip addr show eth0 | awk '/inet / {print $2}' | grep -vE "^127.|^fe80" | awk -F '/' '{print $1}'
echo ""
}

################################################################################

# Function to display Internet Service Provider (ISP)
function display_isp() {
echo "Internet Service Provider (partial):"
curl -s http://ipinfo.io/org
echo ""
}

################################################################################

# Function to display connection type (Ethernet/Wireless)
function display_connection_type() {
echo "Connection type (Ethernet/Wireless):"
iwconfig 2>/dev/null | grep -w ESSID | awk '{print $1, $4}'
ifconfig 2>/dev/null | grep -w ether | awk '{print $1, $2}'
echo ""
}

################################################################################

# Function to check public IP address using Shodan
function display_public_ip_shodan() {
echo "Checking public IP address using Shodan (partial):"
curl -s https://api.shodan.io/tools/myip?key=YOUR_API_KEY
echo ""
}

################################################################################

# Function to check WHOIS information for public IP address
function display_whois_info() {
echo "Checking WHOIS information for public IP address:"
whois "$(curl -s https://ifconfig.me/ip)"
echo ""
}

################################################################################

# Function to sniff network and identify used protocols
function network_sniffing() {
echo "Sniffing network and identifying used protocols:"
sudo tcpdump -G 8 -W 1 -w sniffed_packets.pcap
echo "1. HTTP (Hypertext Transfer Protocol): Used for web browsing."
echo "   Port 80 is typically used for HTTP."
echo "2. HTTPS (Hypertext Transfer Protocol Secure): Secure version of HTTP, used for secure communication over the internet."
echo "   Port 443 is typically used for HTTPS."
echo "3. SSH (Secure Shell): Used for secure remote access and administration."
echo "   Port 22 is typically used for SSH."
echo ""
}

################################################################################

#execute all tasks

display_ip_addresses
display_mac_addresses
display_router_addresses
display_device_name
display_dns_dhcp_addresses
display_isp
display_connection_type
display_public_ip_shodan
display_whois_info
network_sniffing

