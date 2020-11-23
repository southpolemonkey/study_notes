#!/bin/bash

# list listening tcp ports
netstat -t
# print the routing table
netstat -nr

# show configuration of en0 interface
ifconfig en0