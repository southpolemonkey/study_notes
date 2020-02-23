## Auto ML

- H2O
- Auto sklearn

https://techgrabyte.com/11-automl-tools-automate-machine-learning/

## 对数据集的基本操作
1. 把所有不是数值类型的column转化成转化成数值， 怎么做?


```python
# profiling number of unique value in each column
for col, values in Fraud.iteritems():
    num_uniques = values.nunique()
    print ('{name}: {num_unique}'.format(name=col, num_unique=num_uniques))
    print (values.unique())
    print ('\n')

```