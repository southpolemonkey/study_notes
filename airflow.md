# Airflow

## Concept

operator types:
- action operator: execute some app (BashOperator, PythonOperator ...)
- transfer operator: move data
- sensor operator: waiting for data to arrive

## config

```bash
# configs defaults to ~/airflow/airflow.cfg



```

**CLI reference**

```bash
# install and setup
pip install apache-airflow
airflow initdb
airflow webserver -p 8080
airflow scheduler

# cmd
airflow list_dags
airflow list_tasks

```

## snippet

```python
# defind a DAG
dag = DAG(
    'tutorial',
    default_args=default_args,
    description='A simple tutorial DAG',
    schedule_interval=timedelta(days=1),
)

# task
t1 = BashOperator(
    task_id='print_date',
    bash_command='date',
    dag=dag,
)

# set up dependencies

t1.set_downstream(t2)
t2.set_upstream(t1)

t1.set_downstream([t2, t3])
t1 >> [t2, t3]
[t2, t3] << t1
```

## core concepts

- DAG
- task
- Hooks
- Pools
- Connections: info needed to access external systems (db etc)
- Queues 
- XComs
- Variables
- Branching
- backfilling


## Reading List

[adobe-airflow-best-practice](https://theblog.adobe.com/adobe-experience-platform-orchestration-service-with-apache-airflow/)
[ML-Twitter-workflow](https://blog.twitter.com/engineering/en_us/topics/insights/2018/ml-workflows.html)
[awesome-airflow](https://github.com/jghoman/awesome-apache-airflow)

## FAQ

factory method

## Opertors

# tools

https://github.com/talperetz/python-cli-template

https://towardsdatascience.com/scale-your-data-pipelines-with-airflow-and-kubernetes-4d34b0af045

## Airflow in distributed mode

Executor:
- sequential executor
- local executor
- celery executor

configuration file:
- parallelism
- max_active_runs_per_dag
- dag_concurrency


airflow flower

## Advanced concepts

- subDAG
- hooks: getting data from external tables
- XComs
- branching
- SLA
