import os

"""
illustrate a few nuances working with relative path in python.
The idea is to always save the output file in the same folder as the running script.

Try running this script from other paths
"""

print('getcwd:      ', os.getcwd())
print('__file__:    ', __file__)
print('basename:    ', os.path.basename(__file__))
print('dirname:     ', os.path.dirname(__file__))
print('abspath:     ', os.path.abspath(__file__))
print('abs dirname: ', os.path.dirname(os.path.abspath(__file__)))
print('realpath dirname: ', os.path.dirname(os.path.realpath(__file__)))

outputPath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "output.txt")
print("Output should now reside next to script in ", outputPath)

with open(outputPath, "w") as f:
  f.write("output something")
