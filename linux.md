# Linux/Unix

- [vim](#vim)
- [udemy course structure](#udemy)
  - [file and directory permissions](#file-and-directory-permissions)
  - [i/o, std Err](#i/o)
  - [packges, package manager](#packges,-package-manager)
  - [shell](#shell)
- [Nix ecosystem](#nix-ecosystem)
- [Shadowsocks](#shadowsocks)

## commands

```bash
# list current shell
$echo $0

# show available shells
$cat /etc/shells

# change shel
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
sort -h  # sort by size
sort -V  # sort by version number
```

## Question bothered me for a long time
how to find which application(process) are using which port number?
how to find the most memery intensive process?
how does `sed` work

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

### du
du -hs *|sort -h -r  #show summary human readable size, followed by sort descend

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

### 2>&1 meaning

> `>&` is the syntax to redirect a stream to another file descriptor - 0 is stdin, 1 is stdout, and 2 is stderr.


## automatically start

```bash
# suppose run as superuser
update-rc.d script_name defaults 

# need a start script and put in /etc/init.d
```

[reference](https://www.digitalocean.com/community/tutorials/how-to-configure-a-linux-service-to-start-automatically-after-a-crash-or-reboot-part-2-reference)

# udemy

## file and directory permissions

```bash
# linux root folder structure

├── Applications
├── Library
├── System
├── Users
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

16 directories, 0 files
```


- symbolic permissions
- numeric permissions
- file vs directory permissions
- change permissions
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

## viewing files

- cat
- more
- less


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
|2>&1 |combin stderr and stdout
|2>file |redirect stderr to a file
|>/dev/null |redirect output to nowhere


## compare files

- diff
- sdiff
- vimdiff

## search in files

- grep
- file
- cut
- tr
- colum

## tranfer files over network

- sftp
- scp
- ftp

## environment variables

env is mainly uppercase by convention, and is case sensitive

`printenv` 


## process

```bash
ps
kill
<command> & : run job background
jobs : list running jobs
bg : send job to background
fg : send job to foreground

cron
crontab

* /15 * * *  <command> run every 15 minitues
```
## user managerment

```bash
su 
su -c command 
sudo -l
sudo su 
sudo su -
sudo su - username

```
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

dkpg install 


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
  - reboot
  - shutdown
  - telinit
  - poweroff

## system logging

syslog

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
```








