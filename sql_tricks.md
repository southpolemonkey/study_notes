## Count distinct in windows function
```sql
...
    dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number asc) +
	dense_rank() over (partition by policy_number_no_suffix, product_type order by policy_number desc) - 1 as suffix_cnt
...
```