### How does `import` work?

### What is `future` module?

### How to import from module from parent package?
```python
import os,sys

sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir, 'src'))
from <parent module> import <module name>
```

What is `@classmethod` used for?


`zip`, `map`, `filter`, `lambda` function使用

### regex
not something: `!`

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

### web scraper

https://www.geeksforgeeks.org/download-instagram-profile-pic-using-python/