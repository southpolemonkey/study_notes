# Test

- [Pytest](#pytest)

```text
It's always good to know the core concepts of any programming language. But for QA you need to be very productive using python to automate tests faster. This means the you should master the following.

Built-in functions - The more you know the less it will take for you to code
unittest module - Get to know in and out of this to write automation test suites
Regular expressions - Given that testing is all about assertions, expertise with regular expressions will go a long way to write tests quickly
Classes and Objects - Test code should be of high standards like the feature ones. So when you write tests, use OOP most of the times
HTTP libraries - useful for testing REST APIs
Data types - lists, tuples, dictionaries, if you know the collections module, then that would be a huge plus where you can get complicated text processing stuff done with very few lines of code
```

## Pytest

```python
import pytest

# Parametrize 
def is_even(input):
    if input % 2 == 0:
        return True
    return False

@pytest.mark.parametrize("input,expected", [
    (2, True),
    (3, False),
    (11, False),
])
def test_is_even(input, expected):
    assert is_even(input) == expected

# Assert raises an error
def do_something(input):
    if input == 0:
        raise ValueError('A very specific bad thing happened.')
    return True

def test_do_something():
    with pytest.raises(ValueError):
        do_something(0)

# Basic example of fixtures
@pytest.fixture
def user():
    return {
        'name': 'John Snow',
        'email': 'john@snow.wes'
    }

def test_do_something(user):
    assert user['name'] == 'John Snow'

# Basic example of marking test cases
@pytest.mark.a
def function()
    ...

```

```bash
pytest -m  <mark_name> #run tests with mark
pytest --pyargs

```

### How to run `pytest` when tests out of package folder?
```bash
setup.py
src
└───utils
│       algo.py
│       srel.py
tests
    algo_test.py
    srel_test.py

$ set PYTHONPATH=src
$ pytest
```

[pytest cheatsheet](https://leportella.com/cheatlist/2019/01/24/pytest-cheatsheet.html)

[pytest examples](http://zetcode.com/python/pytest/)

