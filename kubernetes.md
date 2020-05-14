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
gcloud container registry
> gcloud auth configure-docker


## core concepts

**components**
api server
etcd
scheduler
kubelet
controller
container runtime


### workloads

#### pod

the smallest unit, can have more than one containers running

```bash
# kubtctl cmd

kubectl run <pod_name> --image <image_name>

kubectl create -f example.yaml

kubectl get pods -n <namespace>
kubectl get pod <pod-name> -o yaml > pod-definition.yaml  # get pod definition file
kubectl edit pod <pod-name>
kubectl get replicationcontroller
```

#### replicaSet
```yaml
...
kind: ReplicationController
metadata:
  name:
  label:
    l_name: l_value
spec:
  template:
    <pod definition>
  replicas: 2

# replicationSet
kind: ReplicaSet
selector: 
```
how to scale a replicaSet?
kubectl replace -f .yaml
kubectl scale --replica=6 -f .yaml
kubectl config set-context $(kubectl config current-context) --namespace=dev

#### deployment

```yaml
kind: Deployment

```

#### namespace

#### Service

### configuration

`command` ---> ENTRYPOINT 
`args` ---> CMD

configMaps

SecurityContexts

Secrets

ServiceAccounts
> gsa ---> ksa ---> kubectl annotate

taint? what's the use case?
affinity? tolerations? 

### multi-container pods

sidecar, use cases: logging services
adapter
ambassador


### observability

readiness probes
basically it detects if the application is ready for receiving traffic

- pending
- containerCreating
- running
- Error
- completeed

liveness probes

how k8s handle logging, monitoring and debug

```bash
kubectl logs -f <pod-name> <container-name>
```
stackdriver monitoring

### pod design

labels, selectors, annotation

```yaml
selector:
  matchLables:
    type: <type-name>

```

rolling updates, rollbacks

```bash
kubectl set image <deployment-name> <image-name>
kubectl rollout status <deployment-name>
kubectl rollout history <deployment-name>
kubectl rollout undo <deployment-name>
```

jobs: one-off run, batch jobs
restartPolicy: Never/Always
parallelism: 3

```yaml
CronJob:
schedule: "0 0 3 ? * * *"
```

### service & networking

services

### state persistence


### FAQ

how to create a cluster? 
how to create a pod?
what's the best access pattern 

### reading list

[lucassha-CKAD](https://github.com/lucassha/CKAD-resources)

