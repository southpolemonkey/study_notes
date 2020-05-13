# kubernetes

## concepts 

workload identify pool
ksa
annotate

## Docker

steps
- create docker image
docker build -t quickstart-image .
docker tag quickstart-image gcr.io/[PROJECT-ID]/quickstart-image:tag1
docker push gcr.io/[PROJECT-ID]/quickstart-image:tag1
docker pull gcr.io/[PROJECT-ID]/quickstart-image:tag1
gcloud container images delete gcr.io/[PROJECT-ID]/quickstart-image:tag1 --force-delete-tags
- kubernete yaml file


[From](https://docs.docker.com/engine/reference/builder/#from)

```docker
# docker file command

FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]

```

## gcloud container registry
> gcloud auth configure-docker



