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

```

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

### tar/untar 
```bash
gunzip
```

### cut, sort
```bash
awk -F "|" '{ print $4 }' Notes.data

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

## Process
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
