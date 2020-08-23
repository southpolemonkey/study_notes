# SQL

- [DB Concepts](#db-concepts)
- [Syntax](#syntax)
- [BigQuery functions](#bigquery-functions)
    - [Date and Timestamp functions](#date-and-timestamp-functions)
    - [Array, JSON functions](#array-json-functions)
    - [Mathematics, Statistical functions](#mathematics-statistical-functions)
    - [Geographical functions](#geography-functions)
    - [UDF](#udf)

## DB Concepts

Difference between unique key and primary key

- one table can have only one primary key, and primary key can not have null value
- can exist multiple unique key, accept null value

clustered key vs non clustered key

- clustered key is a physical stored in disk, part of table
- clustered key sort data
- non-clustered key is logcial index, existed seperately

https://voluntarydba.com/2012/10/02/the-primary-key-vs-the-clustered-index/


execution order of sql statement

- from --> where --> group by --> having --> windows function --> select --> distinct --> union --> order by --> limit

[a-reference-in-mysql](https://www.eversql.com/sql-order-of-operations-sql-query-order-of-execution/)

## Syntax

## Count distinct in windows function
```sql
...
    dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number asc) +
	dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number desc) - 1 as suffix_cnt
...

```

## Calculate Moving Average

```sql
-- construct base table 
select *
from table_name a 
cross join table_name b
where date_diff(a.time_field, b.time_field, day) < "window_size"

```

## BigQuery functions

### Date and Timestamp functions

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

Working with repeated fields

- [remove-repetition-with-flattern](https://cloud.google.com/bigquery/docs/reference/standard-sql/migrating-from-legacy-sql#removing_repetition_with_flatten)
- [Query nested arrays](https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays#querying_nested_arrays)
- [JSON_EXTRACT_ARRAY](https://cloud.google.com/bigquery/docs/reference/standard-sql/json_functions#json_extract_array)
- [life-science-flatten-bigquery-table](https://cloud.google.com/life-sciences/docs/how-tos/flatten-bigquery-table)
- [nested and repeated fields](https://cloud.google.com/bigquery/docs/nested-repeated)
- [declare Array type](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types#array_type)
- [declare Struct type](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types#declaring_a_struct_type)

```sql
-- work with nested fields
WITH races AS (
  SELECT "800M" AS race,
    [STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits),
     STRUCT("Makhloufi" as name, [24.5, 25.4, 26.6, 26.1] as splits),
     STRUCT("Murphy" as name, [23.9, 26.0, 27.0, 26.0] as splits),
     STRUCT("Bosse" as name, [23.6, 26.2, 26.5, 27.1] as splits),
     STRUCT("Rotich" as name, [24.7, 25.6, 26.9, 26.4] as splits),
     STRUCT("Lewandowski" as name, [25.0, 25.7, 26.3, 27.2] as splits),
     STRUCT("Kipketer" as name, [23.2, 26.1, 27.3, 29.4] as splits),
     STRUCT("Berian" as name, [23.7, 26.1, 27.0, 29.3] as splits)]
       AS participants
)
-- completely flatten the table
select race, participants.name as name, name_offset, duration, duration_offset
from races
left join unnest(participants) as participants WITH OFFSET AS name_offset
left join unnest(participants.splits) as duration WITH OFFSET AS duration_offset 

```

### Mathematics, Statistical functions

### Geographical functions

### UDF

[manage udf in bigquery via dbt macro](https://discourse.getdbt.com/t/using-dbt-to-manage-user-defined-functions/18/10?u=alex_unsw  )

### types of union in bigquery

- union
- union distinct
- union all
- intersect
- except

```sql
-- returns the unique records which exist in both table a and b
select a from table_a
intersect distinct
select a from table_b;


```
### copy, move and load data

[How to undelete data from bigquery](https://stackoverflow.com/questions/27537720/how-can-i-undelete-a-bigquery-table)