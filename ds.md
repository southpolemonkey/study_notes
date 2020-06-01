# data science 

## Auto ML

- H2O
- Auto sklearn

https://techgrabyte.com/11-automl-tools-automate-machine-learning/

## 对数据集的基本操作
1. 把所有不是数值类型的column转化成转化成数值， 怎么做?
2. 要做heatmap得保证输入的都是数值类型，要把`nan`转化成类似`-999`有特殊含义的


```python
# profiling number of unique value in each column
for col, values in Fraud.iteritems():
    num_uniques = values.nunique()
    print ('{name}: {num_unique}'.format(name=col, num_unique=num_uniques))
    print (values.unique())
    print ('\n')
```

```python
# 做类似PCA的功能，从关联性很高的subset中挑cardinality最高的数据
grps = [[1],[2,3],[4,5],[6,7],[8,9],[10,11]]
def reduce_group(grps,c='V'):
    use = []
    for g in grps:
        mx = 0; vx = g[0]
        for gg in g:
            n = train[c+str(gg)].nunique()
            if n>mx:
                mx = n
                vx = gg
            #print(str(gg)+'-'+str(n),', ',end='')
        use.append(vx)
        #print()
    print('Use these',use)
reduce_group(grps)
```

## Models

- Random Forest
- XGBoost
- lightGBM

## Good notebooks

[titanic dataset](https://www.kaggle.com/gunesevitan/titanic-advanced-feature-engineering-tutorial/notebook)


## Interesting Websites

http://www.ccom.ucsd.edu/~cdeotte/programs/neuralnetwork.html

[graph database in Enterprise content management](https://neo4j.com/graphgist/enterprise-content-management-with-neo4j)

[veekaybee - data science is different](https://veekaybee.github.io/2019/02/13/data-science-is-different/)

what skillsets a  good ds needs
- Spin up R server and deploy R in production
- Optimize Spark jobs
- Version controlling data and SQL
- work with lots of JSON

# productionize models

[metaflow](https://metaflow.org/)
