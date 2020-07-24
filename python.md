# Python

- [Core python](#1.-core-python)
- [Web scrap](#2.-web-scrap)
- [build and distribute packages](#Build-and-distrbute-packages)
- [Document server](#document-server)

# 1. Core Python

file handling mode

- r
- w[+]
- a[+]
- x (create a new, fail if file exists)
- b (opens in binary mode)

## How does `import` work

Regular package vs Namespaces package 

### How to import from module from parent package?

```python
import os,sys

sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir, 'src')
from <parent module> import <module name>
```

## What is `future` module

What is `@classmethod` used for?

`zip`, `map`, `filter`, `lambda` function使用

```python
# Uppercase first letter
import re
def titlecase(s):
    return re.sub(r"[A-Za-z]+('[A-Za-z]+)?",
                  lambda mo: mo.group(0).capitalize(),
                  s)

titlecase("they're bill's friends.")
```

### regex

not something: `!`

```python

# extract pattern from string
m = re.search(pat, text)
if m:
    found = m.group(1)

# alternative
try:
    found = re.search(pat, text).group(1)
except AttributeError:
    # AAA, ZZZ not found in the original string
    found = '' # apply your error handling
```

## Logging

- logger
- handler
- filter
- formatter

## ArgParse

```python
import argparse
parser = argparse.ArgumentParser()
# mandatory arguments
# dest specify a variable holds the argv
parser.add_argument("square", dest='square', type=int, help="display a square of a given number")
# optional arguments
parser.add_argument("-v", "--verbose", action="store_true", help="increase output verbosity")
args = parser.parse_args()

square = args.square
```

## List files in directory

```python
# use glob
# list all files
files = [f for f in glob.glob(path + "**/*.txt", recursive=True)]
# list all folders
folders = [f for f in glob.glob(path + "**/", recursive=True)]

# os.walk
# r=root, d=directories, f = files
# list all txt files
for r, d, f in os.walk(path):
    for file in f:
        if '.txt' in file:
            files.append(os.path.join(r, file))

# list file size
max_file_name = max([len(file) for file in os.listdir()])+5

for file in os.listdir():
    file_size = os.path.getsize(file)/1024
    print(f'{file:<{max_file_name}}: {file_size:.2f} KB')

```

## List memory usuage for local variables

```python
def sizeof_fmt(num, suffix='B'):
    ''' by Fred Cirera,  https://stackoverflow.com/a/1094933/1870254, modified'''
    for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
        if abs(num) < 1024.0:
            return "%3.1f %s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f %s%s" % (num, 'Yi', suffix)

for name, size in sorted(((name, sys.getsizeof(value)) for name, value in locals().items()),
                         key= lambda x: -x[1])[:10]:
    print("{:>30}: {:>8}".format(name, sizeof_fmt(size)))
```

## List file size in folder

## subprocess

## fstring formatting
http://zetcode.com/python/fstring/



### logging module
> Best practice when instantiating loggers in a library is to only create them using the __name__ global variable: the logging module creates a hierarchy of loggers using dot notation, so using __name__ ensures no name collisions.

https://docs.python-guide.org/writing/logging/

three ways to manage logging config file
- ini 
- via dictionaty
- via code


### formate current date and time

```python

from datetime import datetime

# datetime object containing current date and time
now = datetime.now()
 
print("now =", now)

# dd/mm/YY H:M:S
dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
print("date and time =", dt_string)	

```

# 2. Web Scrap

https://www.geeksforgeeks.org/download-instagram-profile-pic-using-python/

### debug 
step over
step in
step out

### argparse

```python
parser = argparse.ArgumentParser()

parser.add_argument()

args = parser.parser_args()
```
what is `positional argument`

action
- store
- store_const
- store_true
- append
- append_const
- count
- version
- help
- extend

## Build and distrbute packages


pypi public dataset
- [mechanism linehaul](https://github.com/pypa/linehaul)
- [Analyzing PyPI package downloads](https://packaging.python.org/guides/analyzing-pypi-package-downloads/)

[pypi download dataset sample queries](https://gist.github.com/alex/4f100a9592b05e9b4d63)


## Document Server

```bash
pip install -U sphinx
```
[docusaurus](https://docusaurus.io/en/)
