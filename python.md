# Python

- [1. Core python](#1.-core-python)
  - [IO](#IO)
  - [JSON](#json)
  - [String formatting](#string-formatting)
  - [argparse](#argparse)
  - [Regex](#regex)
  - [Logging](#logging)
  - [OOP](#oop)
  - [Error handling](#error-handling)
  - [Misc](#misc)
  - [itertools, collectiions, functools](#itertools,-collectiions,-functools)
  - [Package, Module](#package,-module)
  - [Multiprocessing](#multiprocessing)
  - [OS, Sys module](#os,-sys-module)
  - [Closure, Scope](#closure,-scope)
- [2. Web scrap](#2.-web-scrap)
- [3. build and distribute packages](#3.-Build-and-distrbute-packages)
- [4. Document server](#4.-document-server)
- [5. Development tool](#5.-development-tool)

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

# https://stackoverflow.com/questions/519633/lazy-method-for-reading-big-file-in-python
```

### Advanced IO

[python doc link](https://docs.python.org/3/library/io.html)

- Text I/O
- Binary I/O
- Raw I/O
- StringIO

### List files in directory

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
---

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

---

## Regex


```python
# not something: `!`
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

---

## Logging

Concepts

- logging
- logging config
  - config
  - .ini
- logging handler
  - StreamHandler
  - FileHandler
- centralised logger in application

> Best practice when instantiating loggers in a library is to only create them using the __name__ global variable: the logging module creates a hierarchy of loggers using dot notation, so using __name__ ensures no name collisions.


```python
# https://docs.python-guide.org/writing/logging/
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

---

## ArgParse

Concepts

- positional argument
- keyword argument
- args & kwargs
- unpack operator(`*`, `**`)

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

# when to use positional args vs kwards
# https://docs.python.org/3/tutorial/controlflow.html#recap
def f(pos1, pos2, /, pos_or_kwd, *, kwd1, kwd2):

```


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


## String formatting

```python
# http://zetcode.com/python/fstring/

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

# datetime formatter
# strptime
dt_string = "12/11/2018 09:15:32"
dt_object = datetime.strptime(dt_string, "%d/%m/%Y %H:%M:%S")
# strftime
now = datetime.now()
date_time = now.strftime("%Y%m%d%H%M%S")
```

---

## OOP

Concepts

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

[@classmethod is a factory method](https://stackoverflow.com/questions/12179271/meaning-of-classmethod-and-staticmethod-for-beginner)

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

### dataclasses

[why dataclass matters](https://stackoverflow.com/a/47955313)

---

## Error handling

Concepts

- Error
- Exception
- Warning

```python
# https://docs.python.org/3/tutorial/errors.html#errors-and-exceptions

# Syntax Errors
# Exception
# try...catch...finally 
# User-defined exception

class Error(Exception):
    """Base class for exceptions in this module."""
    pass

# define more custom exception

# exception hierarchy
# https://docs.python.org/3/library/exceptions.html#exception-hierarchy
```

---
## Misc

### What is `future` module


```python
# Uppercase first letter
import re
def titlecase(s):
    return re.sub(r"[A-Za-z]+('[A-Za-z]+)?",lambda mo: mo.group(0).capitalize(), s)

titlecase("they're bill's friends.")
```

## List memory usuage for local variables

```python
# https://stackoverflow.com/a/1094933/1870254
def sizeof_fmt(num, suffix='B'):
    for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
        if abs(num) < 1024.0:
            return "%3.1f %s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f %s%s" % (num, 'Yi', suffix)

for name, size in sorted(((name, sys.getsizeof(value)) for name, value in locals().items()), key= lambda x: -x[1])[:10]:
    print("{:>30}: {:>8}".format(name, sizeof_fmt(size)))

# get variable's reference count  
sys.getrefcount(var)

# garbage collection
gc.collect()
```


---

## itertools, collectiions, functools

Concepts

- iterator
- generator
- collections
- [coroutines](http://www.dabeaz.com/coroutines/)

```python
# iterators
# - combinations
# - combinations_with_replacement
# - permutations

# exercises
# - calculate moving average of a list
# - calculate moving sum of a list
# - flatten a multi-dimensional list

# generator - a simple log processor pipeline
# https://brett.is/writing/about/generator-pipelines-in-python/
```

## Package, Module

Concepts

- How does python find package/module?
- what is `sys.path`
- [what is package](https://docs.python.org/3/tutorial/modules.html#packages) : a collection of modules
- Intra-package References¶
- Regular package vs Namespace package

```python
# How to import method from parent module?
sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir, 'src')
from <parent module> import <module name>
```

## Multiprocessing

Concepts

- Pool
- ThreadPool

```python
# template of multiprocessing setup

def task(a,b,c): return

args = [(a,b,c)] # wrap function parameters in a list of tuples

with ThreadPool(8) as pool:
    results = pool.starmap(task, args)

```

## OS, Sys module

Concepts:

- OS: operating system related (mosted used os.path)
- Sys: python runtim service

```python
# OS
# Understand os.path.realpath
scripts/python_realpath.py

# Sys

```

## Closure, Scope

```python
# the most typical error related to closure
# example in snippet/python_closure.py
UnboundLocalError: local variable 'x' referenced before assignment
```



# 2. Web Scrap

Concepts

- html requests library
    - Requests
- html parsing library
    - BeautifulSoup

https://www.geeksforgeeks.org/download-instagram-profile-pic-using-python/


# 3. Build and distrbute packages


pypi public dataset
- [mechanism linehaul](https://github.com/pypa/linehaul)
- [Analyzing PyPI package downloads](https://packaging.python.org/guides/analyzing-pypi-package-downloads/)

[pypi download dataset sample queries](https://gist.github.com/alex/4f100a9592b05e9b4d63)

[real-python-publish-package](https://realpython.com/pypi-publish-python-package/#publishing-to-pypi)


# 4. Document Server

Concept

- doc string
- what is function annotation
- generate document from comments 
- solutons
  - sphinx
  - meta
  - [docusaurus](https://docusaurus.io/en/)

```python
# function annotation
# declare argument types and returned type
def f(ham: str, eggs: str = 'eggs') -> str:

```


# 5. Development tool

Concepts

- type check
  - [mypy quickstarts](https://mypy.readthedocs.io/en/stable/getting_started.html)
- formatter
  - black
- linter
  - flake8
- performance benchmark
- [Test and debug](test.md)


## Jupyter

```bash
# register python version in jupyter kernels
python -m ipykernel install --user --name Python_<version>_Notebook --display-name "Python_<version>"

# jupyter search path
jupyter --path

# list all availables kernels
jupyter kernelspec list
```

