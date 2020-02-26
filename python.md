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
