## Pandas 

## Accumulative calculation, Moving average etc
- pd.DataFrame.expanding()
- pd.DataFrame.rolling(min_periods=1)


## Working with missing data
how to check missing value i.e null/nan/empty?
```python
df_check_null = pd.DataFrame({'A':[1,np.nan,3]})
pd.isnull(df_check_null[1,'B'])
```