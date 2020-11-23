# Raspberry Pi

## firewall setup

```bash
# https://raspberrypg.org/index.html@p=53.html
# how to open remote connection for postgres
# may need running with sudo
$ iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW, ESTABLISHED -j ACCEPT
$ iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
$ iptables -A OUTPUT -o eth0 -p tcp --dport 22 -m state --state NEW, ESTABLISHED -j ACCEPT
$ iptables -A INPUT -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT 

# add the below line in pg_hba.conf
# TYPE DATABASE USER ADDRESS METHOD
host all all <ip_address_remote_instance>/32 md5

# add the below line to postgresql.conf
listen_addresses = '*'

# restart
sudo systemctl restart postgresql
```