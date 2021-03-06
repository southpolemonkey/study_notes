# Linux/Unix


- [i/o, std Err](#i/o)
- [packges, package manager](#packges,-package-manager)
  - [Nix ecosystem](#nix-ecosystem)
- [process management](#process-management)
  - [boot](#boot)
- [shell](#shell)
  - [vim](#vim)
- [text processing](#text-processing)
  - [grep](#grep)
  - [regex](#regex)
  - [sed](#sed)
  - [Jq](#jq)
- [files system](#files-system)
  - [file and directory permissions](#file-and-directory-permissions)
  - [file search](#file-search)
  - [compress and extract](#compress-and-extract)
  - [disk](#disk)
- [network](#network)
  - [basic network commands](#basic_network_commands) 
  - [vpn proxy](#vpn_proxy)
    - [Shadowsocks](#shadowsocks)
    - [protocols](#protocols)
  - [dns](#dns)
- Useful links




# Overview of linux knowledge

![linux_knowledge_mindmap](pics/linux_system.png)

# Process management

# Shell

# Text processing

# Files system

# Network

# Disk


## commands

```bash
# list current shell
$echo $0

# show available shells
$cat /etc/shells

# change shell
$chsh -s /bin/bash ronga

# full path to shell
$type -a /bin/zsh

# find files with pattern inside recursively under current folder
# The first pattern is useful find ... -exec ...<more operations>...
find . -type f -exec grep -l 'service' {} \;
grep -ir -C 4 --include=PATTERN "kind: job"

# find usage
# find multiple extensions
find . -type f \( -name "*.json" -o -name "*.sh" \);

# delete file by patterm
find . -name "*.sql" -type f -delete

# tr usage, remove white space
tr -s " "
```

[File find utility](https://alvinalexander.com/scala/scala-file-find-utility-command/)

https://alvinalexander.com/unix/edu/examples/find.shtml

### grep

```bash
# regular expressions
# -------------------
grep '^fred' /etc/passwd             # find 'fred', but only at the start of a line
grep '[FG]oo' *                      # find Foo or Goo in all files in the current dir
grep '[0-9][0-9][0-9]' *             # find all lines in all files in the current dir with three numbers in a row

-r recursively
-l list file name
-i case insensitive
-v reverse meaning
-A after matching line
-B before matching line
-C context around matching line

# egrep 
egrep -ri "json|yaml" .

# negate characters in a pattern
[^_] # to exclude underscore

# grep sql and get source tables name
# from schema.table will give you schema.table from the searche files 
egrep -o "^\s+from(\s+[^_]\w+\.\w+)" $file | sed 's/^ *//g'
```

How to extract match group?
`grep -oP 'foobar \K\w+'`

### Compress, tar/untar 

```bash
tar: bundle files
-c create a tar archive
-x extract files
-t display tables of contents
-v verbose
-z use compression
-f use this file

# compress
gzip, gunzip 
gzcat
zcat

tar zcf filename.tgz
tar ztv
# create an extract
tar -czvf name-of-archive.tar.gz /path/to/directory-or-file

# sort
sort -h  # sort by human readable size
sort -V  # sort by version number
```

## Question bothered me for a long time

how to find the most memery intensive process?

[alvin alexander blog](https://alvinalexander.com/linux-unix/)

## vim

```vim
undo: u
redo: ctrl+r, :redo
move to file end: $
```
[vim tutorial](https://vim.fandom.com/wiki/Shifting_blocks_visually)

how to enable KeyRepeat macOs?

```bash
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g ApplePressAndHoldEnabled -bool true
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

### install vim plugins


## Process

`lsof -i:8080` check pid occupying the target port
 
`lsof -p pid` list open files for the given process

check which port is being listened on: `lsof -OnP | grep LISTEN`

`netstat -pna | grep 3000`

```bash
ps auxwww
ps aux | wc -l

# a = show processes for all users
# u = display the process user/owner
# x = also show processes not attached to a terminal

```

## sed

```bash
# replace 
# seperator can be any symbol not only backslash
sed '[line_[pattern]#s#find#replace#[g]' 

# delete
sed ''

# character class keywords
[[:alnum:]]
[[:alpha:]]
[[:blank:]]
[[:digit:]]
[[:lower:]]
[[:upper:]]
[[:space:]]
[[:xdigit:]] # hex digits [0-9 a-f A-F]
[[:punct:]]

# aampersand reference
# surround matched pattern with parentheses
sed -e 's/pattern/(&)/g' file

# back references is matched pattern surrounded by backslashed parentheses
# (555)654-123 --> Area code: (555) Second: 654- Third: 123

sed 's/\(.*)\)\(.*-\)\(.*$\)/Area code: \1 Second: \2 Third: \3/' phonebook2

```

## awk

https://www.ruanyifeng.com/blog/2018/11/awk.html

```bash
# basic usage
awk <condition> <action> <filename>

FS: field separator
RS: row separator
OFS: output field separator
ORS: output row separator

# function
toupper()

awk 'NR>1 && NR<3 {print $1}' <filename> # print line 1 to 3

```

```bash
#!/bin/sh
#
# Use this shell script to rename all occurrences of 'ExtJSLogin' in all files
# that are found by the `find` command shown in Step 1 below.
#
# To use this script:
#
# 1) create `files.txt` like this:
#
#    find . -type f -exec grep -l 'ExtJSLogin' {} \; | grep -v 'change-app-name.sh' > files.txt
#
# 2) change the NEW_APP_NAME in this script to whatever you want to name your
#    application.
#
# 3) run this script to change the application name in all the files
#

OLD_APP_NAME='ExtJSLogin'
NEW_APP_NAME='Focus'
FILELIST=files.txt

for file in `cat $FILELIST`
do
  # need the empty '' on mac osx systems
  sed -i '' "s/$OLD_APP_NAME/$NEW_APP_NAME/g" $file
done
```


## disk usage

```bash
# disk free space
df -H

# folder size
du -hsc * 2> /dev/null
du -sch * | sort -r -h | head -10
du -hs * | sort -h -r

```

### ncdu

### split header and print line by line
> head -n 1 viewing_shap_value_20200125.csv | tr ',' '\n' | while read word; do

### rename pattern
rename file extension

```bash
find . -name "*.t1" -exec bash -c 'mv "$1" "${1%.t1}".t2' - '{}' \;

# change filename case
for f in * ; do mv -- "$f" "$(tr [:lower:] [:upper:] <<< "$f")" ; done
```
### rename multiple files

```bash
for f in *.prog; do mv -- "$f" "${f%.prog}.prg"
```

[how-to-use-the-rename-command-on-linux](https://www.howtogeek.com/423214/how-to-use-the-rename-command-on-linux/)


weird symbols in bash
`<<` here format
`-z` check if string is empty
`-f` find file

[Bash Beginner Guide](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/)

## automatically start

```bash
# suppose run as superuser
update-rc.d script_name defaults 

# need a start script and put in /etc/init.d
```

[reference](https://www.digitalocean.com/community/tutorials/how-to-configure-a-linux-service-to-start-automatically-after-a-crash-or-reboot-part-2-reference)

# udemy

## Linux root directory structure

```bash
# MacOS root folder structure

├── Applications
├── Library
├── System
├── Users
│   ├── Shared
│   ├── user1
│   └── user2
├── Volumes
├── bin (binaries and other executable programs)
├── cores
├── dev
├── etc -> private/etc (system configuration files)
├── home -> /System/Volumes/Data/home (home directories)
├── opt (optional or third party software)
├── private
├── sbin
├── tmp -> private/tmp (temporary space, typicall cleared on reboot)
├── usr
└── var -> private/var


|--- bin	# Essential command binaries
|--- boot	# Static files of the boot loader
|--- dev	# Device files
|--- etc	# Host-specific system configuration
|--- lib	# Essential shared libraries and kernel modules
|--- media	# Mount point for removable media
|--- mnt	# Mount point for mounting a filesystem temporarily
|--- opt	# Add-on application software packages
|--- run	# Data relevant to running processes
|--- sbin	# Essential system binaries
|--- srv	# Data for services provided by this system
|--- tmp	# Temporary files
|--- usr	# Secondary hierarchy
|--- var	# Variable data
|--- home # user specfic home directory


# linux file type

-  # regular file
d  # directory
c  # character device file
b  # block device file
s  # local socket file
p  # named pipe
l  # symbolic lin
```

- symbolic permissions
- numeric permissions
- file vs directory permissions
- change permissions
  - chmod
  - chown
- work with groups
- file creation mask

groups
- u: User
- g: groups
- o: other
- a: all

type:user:group:others

find files
- find
- locate

## Viewing/Editing files

- cat
- more
- less


```bash
k
```


## i/o

- STDIN: 0
- STDOUT: 1
- STDERR: 2


|Symbol | Usage
|---|---|
|> |redirect stdout to file
|>> |redirect to file, append
|< |redirect input from a file to a command
|& |used with redirection to signal that a file discriptor is used
|2>&1 |combine stderr and stdout
|2>file |redirect stderr to a file
|>/dev/null |redirect output to nowhere
|2>&1 > /dev/null | redirect stderr to screen, ignore stdout



## Compare files

- diff
- sdiff
- vimdiff

## Search in files

- grep
- file
- cut
- tr
- colum

## Tranfer files over network

- sftp
- scp
- ftp

## environment variables

env is mainly uppercase by convention, and is case sensitive

`printenv` 


## process

```bash
# ps
ps -a -U <user-name>

kill
<command> & : run job background
jobs : list running jobs
bg : send job to background
fg : send job to foreground

cron
crontab

* /15 * * *  <command> run every 15 minitues
```
## User management

```bash
# commands
id <username> 
groups <username> 
usermod, useradd, userdel

su 
su -c command 
sudo -l
sudo su 
sudo su -
sudo su - username

```

## file permission management

```bash
chown <new_owner> <filename>
chmod MODE <filename>
# MODE: '[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+'.
# +x make executable
# -w remove write access

```

![linux-file-permission](pics/linux-file-permission.png)

## shell history

```bash
~/.bash_history
~/.history
~/.hisfile

```

## packges, package manager

```bash
# macOs
brew list

# deb based distros(debian, ubuntu, mint)
apt-get install package
apt-get remove (remove package, leave config)
apt-get pruge package (remove package and config)
apt-cache show package

# dkpg = debian package manager

# red hat distros(centos)
yum seatch string
yum info
yum install [-y] package
yum remove package

rpm -qa list all installed packages
rpm -e remove package


# others
nixOS

```


## boot process

- BIOS(basic input/output system)
  - bootables devices(hard drives, usb drives, dvd drives...)
- boot loaders start operating system
  - LILO (Linux Loader)
  - GRUB (Grand Unified Bootloader)
- linux kernel
  - vmlinux
  - vmlinuz
  - dmesg
- run levels, targets
  - systemd
  - systemctl
  - sysctl: tune kernal performance
  - reboot
  - shutdown
  - telinit
  - poweroff

## system logging

syslog = Apple System Log utility

/var/log/<application>.log
/var/syslog

## networking

- ip address, broadcast address, mask
- network class (A,B,C)
- DNS
- DHCP

```bash
#commands

ping

ifconfig

traceroute

netstat -rnitlp

tcpdump

telnet

route

# ip: show / manipulate routing, network devices, interfaces and tunnels
ip link show
```

## shell

```bash
# man test
-e exists
-z true if string is empty
-ne not equal
-eq equal

if [ condition ] then ... fi

for a in b do .... done

# Variable interpolation
# single quote is interpreted literally 
'$var' 
"$var" 

# Command substitution
echo $(command)

```

use last item of a command, use `!$`

## check os version

```bash
# check current os version
cat /etc/os-release
lsb_release -a
```

## Nix ecosystem

- NixOS: a distribution of linux operating system
- Nix: a package manager
- Nixpkgs: a git repo for all installable packages
- [Leigh Perry nix repo](https://github.com/leigh-perry/nix-setup)

```bash
# basic command
nix search packagename
nix-env -iA packagename # installing a package
nix-env -q # list installed packages
nix-env -e package # uninstall packages
nix-env -u # upgrade package

```

[good-first-step-learning-resource](https://nixos.wiki/wiki/Resources)

## Shadowsocks

socks is also an vpn protocol and it works as a common client-service model, meaning socks client sends request to a socks server which is usually installed on a remote server e.g. AWS EC2 instance to send user's http request on befalf.

user ----> remote-server(socks server) -----> destination ip

[v2ray-configuration](https://toutyrater.github.io/)

## flightradar24 install

```bash
# first-time installation, follow the step to config email and sharing key
sudo bash -c "$(wget -O - https://repo-feed.flightradar24.com/install_fr24_rpi.sh)"

sudo systemctl start fr24feed
sudo systemctl enable fr24feed
/etc/systemd/system.conf

fr24feed-status

# web interface
http://192.168.1.108:8754/

# TODO
https://serverfault.com/questions/845471/service-start-request-repeated-too-quickly-refusing-to-start-limit

# How to solve restart timeout issue
# set up start time in /etc/service/<service_name>.conf
RestartSec=<reasonable_start_time>
```

## JQ, json parser

[interactive tutorial](https://docs.google.com/document/d/1fCmDWm3WyYmRrWp_CajiWYx2svSODtrdg-853aDhqSE/edit)

https://programminghistorian.org/en/lessons/json-and-jq#filter-before-counting

- filters - get element who values contains some value
- extract - extract certains values from all json objects in an json array

https://gist.github.com/ipbastola/2c955d8bf2e96f9b1077b15f995bdae3

```bash
jq length

```

```bash

aws iam get-user | jq -r ".User.CreateDate"

{ aws sts get-caller-identity & aws iam list-account-aliases; } | jq -s ".|add"

aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ runtime:.[0].Runtime, functions:[.[]|.FunctionName] }
]"

aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ (.[0].Runtime): [.[]|{ name: .FunctionName, timeout: .Timeout, memory: .MemorySize }] }]"

aws rds describe-db-instances | jq -r '.DBInstances[] | { (.DBInstanceIdentifier):(.Endpoint.Address + ":" + (.Endpoint.Port|tostring))}'


```


## Useful links

https://www.tutorialspoint.com/unix/unix-system-logging.htm
