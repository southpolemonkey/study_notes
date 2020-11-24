# Raspberry Pi

flask image to pi

- [etcher](https://www.balena.io/etcher/)
- Images
  - [ubuntu server](https://ubuntu.com/download/raspberry-pi)

```bash
# set up raspbian repo
/etc/apt/sources.list
deb http://archive.raspbian.org/raspbian wheezy main contrib non-free
deb-src http://archive.raspbian.org/raspbian wheezy main contrib non-free
wget https://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
```

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