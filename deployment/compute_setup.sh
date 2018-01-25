#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.11.54.54:80
iptables -t nat -A POSTROUTING -p tcp -d 10.11.54.54 --dport 80 -j SNAT --to-source 10.11.51.143 
