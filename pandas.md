# PyData

- Pandas
  - basic types
  - [performance enhancement](#performance-enhancement)
  - [time series data](#time-series-data)
- [NumPy](#numpy)
- [Matplotlib](#matplotlib)

# Pandas

## Basic types

main objects existed in pandas

- Series
- DataFrame
- Index
  - RangeIndex
  - MultiIndex
  - DatetimeIndex
  - TimedeltaIndex
  - PeriodIndex
- GroupBy
- Resampler
- Window
  - Rolling
  - Expanding
  - ExponentialMovingWindow 

## Metadata check

```python
# check memory usage
df.info()

# check memory for each column
ts.memory_usage(deep=True)
```

## Optimisation tips

- Convert low cardinality column to `Categorical`


## Accumulative calculation, Moving average etc

- pd.DataFrame.expanding()
- pd.DataFrame.rolling(min_periods=1)

## Working with missing data

how to check missing value i.e null/nan/empty?

```python
df_check_null = pd.DataFrame({'A':[1,np.nan,3]})
pd.isnull(df_check_null[1,'B'])
```

## difference between copy vs view?

## Method Chain

```python
# method chain
df = (pd.read_excel('a.csv')
        .rename(columns=str.lower)
        .rename(columns=str.replace('','_')
        .pipe(pd.to_datetime, ['A', 'B', 'C'])
        .assign(D=lambda x:x['A'] > x['B'],
                E=lambda x:['C'] + x['D'])
```

## Mock coalesce

```python
coalsesc: 
df['c'] = np.where(df["a"].isnull(), df["b"], df["a"] )
df['c'] = df.a.combine_first(df.b)
```

## work with date, time
how to specify date format when converting str to datetime/date?

### How to generate a sequence of date?
```python
pd.date_range(20200101, period='D', frequency=1)
```

### Understand `transform`

https://pbpython.com/pandas_transform.html

### Subset dataframe by value counts

```python
df_ysd.groupby(['field'])
      .filter(lambda x: x['field'].size >= 6 )
      .sort_values(by=['field1','field2'], ascending=False)
```

1. Select out columns with pattern: `df.filter(like="pattern")`
2. Split column
3. Read_excel() set needed columns
4. Check readed excel file's size
5. Column name renames, all lowercase
6. (df.label_x == df.label_y).value_counts()
From <https://stackoverflow.com/questions/26988041/pandas-dataframe-row-wise-comparison> 
7. Remove Nanhttps://stackoverflow.com/a/45695390/6716236

## Is pandas thread safe?

https://stackoverflow.com/a/55382886/6716236


## Performance Enhancement

- cython
- numba
- [scalable dataframe compiler](https://intelpython.github.io/sdc-doc/latest/overview.html)

## shuffle dataframe

`df.sample(frac=1)`

## date functions

- date_range(start, end, [period], freq)
- bdate_range()
- period_range()
- timedelta_range()

## Init a random dataframe

```python
df = pd.DataFrame(np.random.randn(10, 4))
rng = pd.date_range('1/1/2012', periods=100, freq='S')
```
## Concat, Merge, Reshape

Top-down append: pd.concat([df1, df2, df3])

left-right append:  pd.concat([df1, df2, df3], axis=1)

reshape method:
- stack, unstack
- pivot_table(df, values=<col_for_value>, index=[list_of_dim_names], columns=?)

## count by groups

df.sort_values(by=<col_name>)

df.groupby(<col_name>).size()

the second method also show empty categories


## basic plotting


|method | type| notes
|----|----| ---- |
|**df.plot.hist()** |    histogram| change bind width
|df.plot.bar() |     bar chart|
|df.plot.barh() |    horizontal bar chart|
|df.plot.line() |    line chart| use y=[a,b,c] to draw multiple lines
|df.plot.area() |    area chart| use stacked=True
|df.plot.scatter() | scatter plot| use colourmap
|df.plot.box() |     box plot| use `df.boxplot()` instead
|df.plot.kde() |     kde plot|
|df.plot.hexbin() |  hexagonal bin plot|
|df.plot.pie() |     pie chart</pre>|

## time series data

pandas plotting

## FAQ

if truth statements
```python
if pd.Series([False, True, False]):
  # will give you an error, the correct way to use is via any(), all(), empty() etc
```

NA, Integer NA values, NaN

- Int8Dtype
- Int16Dtype
- Int32Dtype
- Int64Dtype



# Numpy

data related type in numpy:

- datetime64
- timedelta64

[numpy financial package](https://numpy.org/numpy-financial/)

# Matplotlib

Concepts

- Figure: represents a namespace
- Axes
- Axis
- pyplot

[a good introduction](https://matplotlib.org/faq/usage_faq.html)