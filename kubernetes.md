# Kubernetes

# 1. Docker Basics

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

# 2. Core Concepts

**components**
- api server
- etcd
- scheduler
- kubelet
- controller
- container runtime


# 2.1 workloads

## 2.1.1 pod

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

## 2.1.2 replicaSet

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

```bash
# how to scale a replicaSet?

kubectl replace -f .yaml
kubectl scale --replicas=6 -f .yaml
kubectl config set-context $(kubectl config current-context) --namespace=dev
```

## 2.1.3 Deployment

```yaml
kind: Deployment
```

## 2.1.4 namespace

```yaml
kind: namespaces
```
## 2.1.5 Service

```yaml
kind: service
```

## 2.2 configuration

`command` ---> ENTRYPOINT 

`args` ---> CMD

## configMaps

SecurityContexts

## Secrets

## ServiceAccounts
> gsa ---> ksa ---> kubectl annotate

taint? what's the use case?
affinity? tolerations? 

## 2.3 multi-container pods

sidecar, use cases: logging services

adapter

ambassador


## 2.4 observability

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

## 2.5 pod design

labels, selectors, annotation

```yaml
selector:
  matchLables:
    type: <type-name>

```

rolling updates

rollbacks

```bash
kubectl set image <deployment-name> <image-name>
kubectl rollout status <deployment-name>
kubectl rollout history <deployment-name>
kubectl rollout undo <deployment-name>
```

jobs: one-off run

batch jobs

restartPolicy: Never/Always

parallelism: 3

```yaml
CronJob:
schedule: "0 0 3 ? * * *"
```

## 2.6 service & networking

services

ingress

ingress controller

egress

network traffic

## 2.7 state persistence

persistent volumns

mounts

how k8s store generated data?

volumnStore: mountPath

`PersisentVolume`

`PersistentVolumnClaim`

Optional topics
- static provisioning
- dynamic provisioning
- Stateful sets

# FAQ

how to create a cluster? 

how to create a pod?

what's the best access pattern 

how to use template?

yaml syntax practing

how to switch context?

`DEVOPS15` voucher code for exam registry

what does `READY` column stand for in `get pods` output?

```yaml
# create pod

apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep
spec:
  containers:
  - name: busybox
    image: busybox

# change image name in pod
```

# Reading List

[lucassha-CKAD](https://github.com/lucassha/CKAD-resources)

# Common Errors

ReplicaSet
>The ReplicaSet "replicaset-2" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"tier":"nginx"}: `selector` does not match template `labels`


Errors occuring during the provising of pods
- ImagePullBackOff
- CrashLoopBackOff


