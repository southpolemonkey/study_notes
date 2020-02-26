# Pandas 

## Metadata check

```python
# check memory usage
df.info()

# check memory for each column
ts.memory_usage(deep=True)
```

## Optimisation tips

- Convert low cardinality column to `Categorical`

```python
cpython
```

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

```python
# method chain
df = (pd.read_excel('a.csv')
        .rename(columns=str.lower)
        .rename(columns=str.replace('','_')
        .pipe(pd.to_datetime, ['A', 'B', 'C'])
        .assign(D=lambda x:x['A'] > x['B'],
                E=lambda x:['C'] + x['D'])
```

## How to generate a sequence of date?

```python
pd.date_range(20200101, period='D', frequency=1)
```

## Is pandas thread safe

https://stackoverflow.com/a/55382886/6716236