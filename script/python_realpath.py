"""
This explainations comes from this article
https://eli.thegreenplace.net/2011/05/15/understanding-unboundlocalerror-in-python

The content in the article is out of scope of knowledge.
 
x = 10

def external():
    print(x)

external()

>> 10

"""

# def external():
#     x = [1,2,3]
#     def internal():
#         x.append(1)
#         print(x)
#     internal()

# external()

def external():
    x = 10
    def internal():
        nonlocal x
        # global x  (this will fail)
        x += 1
        print(x)
    internal()

external()

# the above case will fail