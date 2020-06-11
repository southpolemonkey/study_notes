# Linux/Unix

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

install plugins


## Process

`lsof -i:8080` check pid occupying the target port
 
`lsof -p pid` list open files for the given process

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

> >& is the syntax to redirect a stream to another file descriptor - 0 is stdin, 1 is stdout, and 2 is stderr.

## shadowsocks

install

## automatically start

```bash
# suppose run as superuser
update-rc.d script_name defaults 

```

## udemy course structure

`$PATH`

## file and directory permissions

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

STDIN: 0
STDOUT: 1
STDERR: 2

```bash
> redirect stdout to file
>> redirect to file, append
< redirect input from a file to a command
& used with redirection to signal that a file discriptor is used
2>&1 combin stderr and stdout
2>file redirect stderr to a file
>/dev/null redirect output to nowhere

```

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


# red hat distros
yum seatch string
yum info
yum install [-y] package
yum remove package

rpm -qa list all installed packages
rpm -e remove package
```

## boot process

- BIOS(basic input/output system)
  - bootables devices(hard drives, usb drives, dvd drives...)
- boot loaders start operating system
  - LILO (Linux Loader
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
ifconfig
traceroute

```


