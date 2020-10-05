# servian

## what kind of project/data do I want to work with?

foxtel - television data, what program is the most popular? 

iag - car insurance claim report, also interesting to have an overview of how much people spend on insurance annually?

woolworth - retail data, poeple shopping habits

carsales - the most value-retained model/brand?

land registry - ?

news corp - ?

## which clients do I want to work with? why?

cochlear - the world leading ear implant manufacturer

[transurban](https://www.transurban.com/roads-and-projects/sydney) - the highway operator, get toll road usage pattern, flow analysis


## Countdown time plan

### Wk37

What exercise should I do before leaving
- AWS data engineer exercise
- Airflow experience

### Wk38
- Airflow
    - HttpHook, PostgresHook, PythonOperator
    - Celery executor, Docker executor
    - Docker compose
- AWS
    - S3, Glue, Lambda function, Step function
    - Monitor lambda trigged histories
    - terraform_remote_state
    - Auto clean up tool

### Wk39
- AWS
    - Kinesis, Firehose, (Kinesis Analytics)
    - Redis 
    - Cloud Formation
    - Route53 (DNS server)
- Flight tracker - Kafka streaming API

### Wk40
- AWS
    - EC2, AMI
- Migration all data to NAS
    - open_source/
    - side_project/
    - dot files

================
### Wk41
- Return Foxtel laptop
- Clean up laptop
- Last week in Servian
- Take some rest
- Prepare mindset for new job
    - dbt intro slides
    - Segment intro
    - Stitch, Fivetran

================
### Wk42

New job @Brighte


## Gcp terraform exercise

### admin module
- Set up a new project. (Only works for organisation resources)
- Create service account and download access key
- Create a billing logging export 
- Create a bq logging to sink

### data module
- Create cron job to write files to GCS bucket
- Create a pubsub topic to land weather data
- Create a postgresql db a operation database
- Create a Segment server as customer data platform
- Create dataflow jobs to ingestion data from the above data sources to big query 
- Create a bucket to store terraform artefacts
- Create a container registry to store app image

### monitoring module
- Create logging metrics of daily income data in GCS bucket
- Create alert when no data recevied
- Create notification channel



