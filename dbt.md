# dbt notes

## Reading Issues

["incremental" deploy](https://github.com/fishtown-analytics/dbt/issues/48)

## Good practice

```sql
 
-- Good 
     
 SELECT
   id                    AS account_id,
   name                  AS account_name,
     
   -- Foreign Keys
   ownerid               AS owner_id,
   pid                   AS parent_account_id,
   zid                   AS zuora_id,
     
   -- Logical Info
   opportunity_owner__c  AS opportunity_owner,  
   account_owner__c      AS opportunity_owner_manager,
   owner_team_o__c       AS opportunity_owner_team,
     
   -- metadata
   isdeleted             AS is_deleted,
   lastactivitydate      AS last_activity_date
 FROM table

```

## FAQ

how dbt run queries in parallel? [issue-62](https://github.com/fishtown-analytics/dbt/issues/62)

how dbt generate dependency graph? `NetworkX`

what library does dbt use?
- agate: csv library

how dbt construct schema and table name?

[dbt incremental fails if table does not already exist](https://github.com/fishtown-analytics/dbt/issues/130)


### materialization option

- view
- table
- incremental
- ephemeral


### snapshots

strategy

[dbt package: snowflake cost](https://gitlab.com/gitlab-data/snowflake_spend)


### Gitlab workflows
 
[How Gitlab data analyst work](https://about.gitlab.com/handbook/business-ops/data-team/#how-we-work)
[glue work](https://www.locallyoptimistic.com/post/glue-work/)
[Gitlab Unfiltered - handle issue triage](https://www.youtube.com/playlist?list=PL05JrBw4t0KrRVTZY33WEHv8SjlA_-keI)
[data eng onboarding - vscode](https://www.youtube.com/watch?v=t5eoNLUl3x0&list=PL05JrBw4t0KrRVTZY33WEHv8SjlA_-keI&index=22&t=0s)

add new data resource and fields
- document table/fields required
- document questions new source can answer

[data infrastructur](https://about.gitlab.com/handbook/business-ops/data-team/data-infrastructure/)
- airflow
- data image

[gitlab dbt guide](https://about.gitlab.com/handbook/business-ops/data-team/dbt-guide/)

[dbt model changes template](https://gitlab.com/gitlab-data/analytics/-/blob/master/.gitlab/merge_request_templates/dbt%20Model%20Changes.md)

### Other ELT tools

[Meltano](https://meltano.com/)
[Singer](https://meltano.com/)


### Readling List
[Why you need a data analyst](https://blog.getdbt.com/the-startup-founder-s-guide-to-analytics/)
[snowplow web data model](https://github.com/snowplow/snowplow-web-data-model)
[iglu-snowplow schema registry](https://github.com/snowplow/iglu)


## packages

### dbtutils

`get_relations_by_prefix`

```sql

-- Example using the union_relations macro
{% set event_relations = dbt_utils.get_relations_by_prefix('events', 'event_') %}
{{ dbt_utils.union_relations(relations = event_relations) }}

```

`star`
```sql
select
{{ dbt_utils.star(from=ref('my_model'), except=["exclude_field_1", "exclude_field_2"]) }}
from {{ref('my_model')}}
```

`pivot` and `unpivot`
