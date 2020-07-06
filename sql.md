# SQL

- [Moving Average](#calculate-moving-average)
- [BigQuery functions](#bigquery-functions)
    - [Date, time functions](#date-functions)
    - [Array, JSON functions](#array-json-functions)
    - [Mathematics, Statistical functions](#mathematics-statistical-functions)
    - [Geographical functions](#geography-functions)
    - [UDF](#udf)


## Count distinct in windows function
```sql
...
    dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number asc) +
	dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number desc) - 1 as suffix_cnt
...

```

## Calculate Moving Average

```sql
-- example query
select *
from a, b
where date_diff(a, b, day) < 10

```

## BigQuery functions

### Date, time functions

This section covers:
- date
- datetime
- timestamp

|Function name| Usage| Syntax|
|----|-----|----|
|date | construct a date object | Date(Year, Month, Day)
|extract| extract certain fields from date | 
|date_trunc | normalize date to specified level
|date_add | add intervals to date|
|date_sub | subtract intervals to date
|date_diff | | date_diff(d1, d2, day/week/quarter/month/year)
|format_date| convert date object to string
|parse_date | convert from string to date object


date dimension table 
- date_key
- convert to various format(YYYYMMDD, DD/MM/YYYY etc)
- day, week, quarter, month, construct description
- begining and ending date
- financial year, quarter, week, first day, last day, fy description
- is holiday 

A slightly complex problem:
> if business requires week number reset to 1 on Jan 1 every year, how do you achieve it?

```sql
with date_spine as (
  SELECT * from unnest(generate_date_array(date(2000,1,1), date(2025,1,1),INTERVAL 1 YEAR)) as d
)
select 
  d, 
  format_date("%A", d) as weekday,
  -- Week starts from Monday. If the week containing January 1 has four or more days in the new year, then it is week 1; 
  -- otherwise it is week 53 of the previous year, and the next week is week 1.
  format_date("%V", d) as week_num_iso,
  format_date("%W", d) as week_num_mon, -- week starts from Monday
  format_date("%U", d) as week_num_sun, -- week starts from Sunday
  extract(week from d) as week_num -- week starts from Sunday
from date_spine

```

**Q&A**

What's the difference between `datetime` and `timestamp`?

timestamp is the time at UTC, while datetime is by default at UTC, but can specify timezone.
when you see a datetime object, does it include TZ info?

Different calendar types? How people came up with so many different types of calendar?
- Gregorian calendar
- Lunar calendar

What is unix date? number of days since 1970-01-01

```sql
select unix_date(current_date()), unix_seconds(current_timestamp()), unix_millis(current_timestamp())
```

### Array Json Functions

[Felipe Hoffa parse json object in bigquery](https://stackoverflow.com/a/34890340)

### Mathematics, Statistical functions

### Geographical functions

### UDF

[manage udf in bigquery via dbt macro](https://discourse.getdbt.com/t/using-dbt-to-manage-user-defined-functions/18/10?u=alex_unsw  )
