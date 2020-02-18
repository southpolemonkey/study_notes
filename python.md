### How does `import` work?

### What is `future` module?

### How to import from module from parent package?
```python
import os,sys

sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir, 'src'))
from <parent module> import <module name>
```

What is `@classmethod` used for?