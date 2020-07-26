# Python

- [1. Core python](#1.-core-python)
  - [IO](#IO)
  - [JSON](#json)
  - [String formatting](#string-formatting)
  - [argparse](#argparse)
  - [Logging](#logging)
  - [OOP](#oop)
- [2. Web scrap](#2.-web-scrap)
- [3. build and distribute packages](#Build-and-distrbute-packages)
- [4. Document server](#document-server)

# 1. Core Python

## IO

file mode

- r
- w[+]
- a[+] (plus sign means creating if not exists)
- x (create a new, fail if file exists)
- b (opens in binary mode)

```python
# create a file object
f = open("filename", "r")
w = open("filename", "w")

# read operation
read_all = f.read()
first_line = f.readline()
all_lines = f.readlines()

# write operation
write_all = w.write(f.read()) # return bytes written
write_one_line = f.writeline()

# operation in binary mode
# these are less used
seek()
tell()
```

### Advanced IO

[python doc link](https://docs.python.org/3/library/io.html)

- Text I/O
- Binary I/O
- Raw I/O

## JSON

```python
# serializing: convert json to string
# deserializing: parse string to json object

dict = {"key":"value"}
json_string = json.dumps(dict)
json_object = json.loads(json_string)

# serialize and deserialise file object
f = open("file_contains_json", "r")
json_object = json.load(f)
json.dump(json_object, a_new_file_object)

```

## How does `import` work

Regular package vs Namespaces package 

### How to import from module from parent package?

```python
import os,sys

sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir, 'src')
from <parent module> import <module name>
```

## What is `future` module

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

Concepts

- logging
- logging config
- logging handler
  - StreamHandler
  - FileHandler

```python
# wrapper for instanitate a logger object
def get_logger(name, file_path):
    ''' Create a new Logger Object '''
    logger = logging.getLogger(name)
    log_format = '%(asctime)s | %(message)s'
    formatter = logging.Formatter(log_format, datefmt='%m/%d %I:%M:%S %p')

    file_handler   = logging.FileHandler(file_path)
    file_handler.setFormatter(formatter)
    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)

    logger.addHandler(file_handler)
    logger.addHandler(stream_handler)

    return logger

def set_logger_level(logger, level):
    ''' Set Logger Logging Level '''
    logger.setLevel(level)
    return logger
```

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

```python
parser = argparse.ArgumentParser()

parser.add_argument()

args = parser.parser_args()
```

### what is `positional argument`

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

## String formatting

```python
http://zetcode.com/python/fstring/

# formatting options
# debug in f string
# math.cos(x) = 0.6967067093471654
print(f'{math.cos(x) = }')

# multiple line
msg = (
    f'Name: {name}\n'
    f'Age: {age}\n'
    f'Occupation: {occupation}'
)

# format date
now = datetime.datetime.now()
print(f'{now:%Y-%m-%d %H:%M}')

# format float
# 12.30
val = 12.3
print(f'{val:.2f}')

# format width
# 0h
a = "h"
print(f'{a:02}')

# justify string
# > aligh to right
# < align to left
a = "h"
print(f'{a:>10}')

# format numeric notation
a = 300
# hexadecimal
print(f"{a:x}")
# octal
print(f"{a:o}")
# scientific
print(f"{a:e}")
```

### logging module
> Best practice when instantiating loggers in a library is to only create them using the __name__ global variable: the logging module creates a hierarchy of loggers using dot notation, so using __name__ ensures no name collisions.

https://docs.python-guide.org/writing/logging/

three ways to manage logging config file
- ini 
- via dictionaty
- via code

## OOP

- what is static method?
- what is class method? what is factory method?
  - how to use classmethod in inheritance?
- what does encapuslation mean in OOP?
- what is abstraction class?
- what is `@property`?
- what is attributes in python?

### classmethod vs staticmethod

classmethod returns an instance of the class, while staticmethod behaves like regular function.

[real python - classmethod vs staticmethod](https://realpython.com/instance-class-and-static-methods-demystified/#delicious-pizza-factories-with-classmethod)

### @property decrorator

decrorator use one language feature `descriptors`.

[what is @property](https://www.programiz.com/python-programming/property#:~:text=In%20Python%2C%20property()%20is,%3DNone%2C%20doc%3DNone)

```python
class C(object):

    def __init__(self):
        self._x = None

    @property
    def x(self):
        print 'getting value of x'
        return self._x

    @x.setter
    def x(self, x):
        print 'setting value of x'
        self._x = x

>>> c = C()
>>> c.x = 1
setting value of x
>>> print c.x, c._x
getting value of x
1 1
```

# 2. Web Scrap

https://www.geeksforgeeks.org/download-instagram-profile-pic-using-python/

### debug 
step over
step in
step out


# 3. Build and distrbute packages


pypi public dataset
- [mechanism linehaul](https://github.com/pypa/linehaul)
- [Analyzing PyPI package downloads](https://packaging.python.org/guides/analyzing-pypi-package-downloads/)

[pypi download dataset sample queries](https://gist.github.com/alex/4f100a9592b05e9b4d63)


# 4. Document Server

```bash
pip install -U sphinx
```
[docusaurus](https://docusaurus.io/en/)
