# Kubernetes

# 0. Terminology
- container runtime
- kubelet


# 1. Docker Basics

Steps
- create docker image
- docker build -t quickstart-image .
- docker tag quickstart-image gcr.io/[PROJECT-ID]/quickstart-image:tag1
- docker push gcr.io/[PROJECT-ID]/quickstart-image:tag1
- docker pull gcr.io/[PROJECT-ID]/quickstart-image:tag1
- gcloud container images delete gcr.io/[PROJECT-ID]/quickstart-image:tag1 --force-delete-tags
- kubernete yaml file


```docker
# docker file syntax

FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]

ENTRYPOINT

CMD

```

# 2. Core Concepts

Components
- api server
- etcd
- scheduler
- kubelet
- controller
- container runtime


# 2.1 Workloads

## 2.1.1 Pod

the smallest unit, can have more than one containers running

```bash
# kubtctl cmd

kubectl run <pod_name> --image <image_name>

kubectl create -f example.yaml

kubectl get pods -n <namespace>
kubectl get pod <pod-name> -o yaml > pod-definition.yaml  # get pod definition file
kubectl edit pod <pod-name>
kubectl get replicationcontroller

# use selector to retrieve info from matched pods

kubectl get pods -l environment=production,tier=frontend # equality-based
kubectl get pods -l 'environment in (production),tier in (frontend)' # set-based
```

## 2.1.2 ReplicaSet

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

## 2.1.6 Imperative command

```bash
kubectl run --generator=run-pod/v1 nginx-pod --image=nginx:alpine

# expose servian from a pod
kubectl expose pod redis --port=6379 --name redis-service

# create deployment and scale
kubectl create deployment webapp --image=kodekloud/webapp-color
kubectl scale deployment/webapp --replicas=3

# flag
-o output 
-l label

```


# 2.2 Configuration

patterns:
- define command and arguments for a container
- define environment variable
- expose pod information via env_var
- distribute credential using secrets
- inject information using PodPreset

`command` ---> ENTRYPOINT 

`args` ---> CMD

```yaml
spec:
  container:
    image: nginx
    args: ['run', 'a'] 
```

## 2.2.1 configMaps

```bash
kubectl get configmaps
kubectl create configmap <cm-name> --from-literal=<key>=<name>
```

```yaml
# how to defind configmap in container block

      envFrom:
      - configMapRef:
          name: special-config

```

## 2.2.2 Secrets, SecurityContexts

```bash
kubectl get secrets

# create new secret

kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123
```

secret type
- service account
- secret
- Opaque

```yaml
# use secret in image block

envFrom:
- secretRef:
    name: special-config
```

```bash
# security contexts

kubectl exec ubuntu-sleeper whoami

```

## 2.2.3 Resource Limits

[Assign CPU resources ot Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)

```yaml
# container resources and limits

apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo-2
  namespace: cpu-example
spec:
  containers:
  - name: cpu-demo-ctr-2
    image: vish/stress
    resources:
      limits:
        cpu: "100"
      requests:
        cpu: "100"
    args:
    - -cpus
    - "2"
```

## 2.2.4 Service Account

Usage:
> To communicate with the API server, a Pod uses a ServiceAccount containing an authentication token.


```yaml
# service account

apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot

```

```bash
# create via cli

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
EOF

# retrieve token

kubectl describe secret <dashboard-sa-secret-name>

# example

$ kubectl get secret default-token-dffkj -o yaml

apiVersion: v1
data:
 ca.crt: LS0tLS1CRU...0tLS0tCg==
 namespace: ZGVmYXVsdA==
 token: ZXlKaGJHY2...RGMUlIX2c=
kind: Secret
metadata:
 name: default-token-dffkj
 namespace: default
 ...
type: kubernetes.io/service-account-token
```

```yaml
# binding roles to sa

# sa
apiVersion: v1
kind: ServiceAccount
metadata:
 name: demo-sa

# role
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: Role
metadata:
 name: list-pods
 namespace: default
rules:
 — apiGroups:
   — ''
 resources:
   — pods
 verbs:
   — list

# binding
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
 name: list-pods_demo-sa
 namespace: default
roleRef:
 kind: Role
 name: list-pods
 apiGroup: rbac.authorization.k8s.io
subjects:
 — kind: ServiceAccount
   name: demo-sa
   namespace: default

```

`ca.crt` is the Base64 encoding of the cluster certificate.

`token` is the Base64 encoding of the JWT used to authenticate against the API server.

what is the relationship between GSA and KSA?


# 2.3 multi-container pods

## 2.3.1 taint, toleration

taint and toleration are mostly used together, they are mainly used to manage resources for specfic usage cases.

what is effect in tolerations? e.g. `NoSchedule`, `NoExecute`

```bash
# taint

kubectl taint nodes node01 spray=mortein:NoSchedule
```
## 2.3.2 Affinity

[Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity
)

> node affinity allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on the node.

## 2.3.3 Common patterns 

Patterns:
- sidecar
- adapter
- ambassador

sidecar ([logging services](https://kubernetes.io/docs/concepts/cluster-administration/logging/))

[Using a sidecar container with the logging agent](https://kubernetes.io/docs/concepts/cluster-administration/logging/#using-a-sidecar-container-with-the-logging-agent)

```yaml
# create sidecar container for storing logging

apiVersion: v1
kind: Pod
metadata: app
  name: app
  namesapce: elastic-stack
  labels:
    name: app
spec:
  containers:
  - name: app
    image: kodekcloud/event-simulator
    volumeMounts:
    - mountPath: /log
      name: log-volume
  
  - name: sidecar
    image: kodekloud/filebeat-configured
    volumeMounts:
    - mountPath: /var/log/event-simulator/
      name: log-volume
  
  volumes:
  - name: log-volume
    hostPath:
      path: /var/log/webapp
      type: DirectoryOrCreate

```

# 2.4 observability

## 2.4.1 Pod Lifecycle

[Pod Liftcycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)

Container probes
- livenessProbe
- readinessProbe
- startupProbe

basically it detects if the application is ready for receiving traffic

- pending
- containerCreating
- running
- Error
- completeed

## 2.4.1 Logging

logging architecture

- node level logging
- cluster level logging

You should remember that native kubernetes does not support extensive logging mechanism. The managed service like GKE, EKS makes life easier at some cost.

logging agent options:
- stackdriver monitoring
- elastic search


```bash
kubectl logs -f <pod-name> <container-name>
```

## 2.4.2 Monitoring

In GKE, cloud monitoring makes the monitoring an ease to use.
Apart from that, datadog is a go-to option in the industry.

# 2.5 Pod Design

## 2.5.1 labels, selectors

```bash
# use label to retrieve info
kubectl get pods -l <label name>

# Identify the POD which is 'prod', part of 'finance' BU and is a 'frontend' tier? 
# set based syntax
kubectl get pods -l 'env in (prod), bu in(finance), tier in (frontend)'
# equality based syntax
kubectl get pods -l env=prod, bu=finance, tier=frontend

# select resources based on resource fields
kubectl get pods --field-selector status.phase=Running

```

```yaml
# metadata block has pre-defined key, including name, labels, while within labels, fields can be defined freely.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{ APP_NAME }}-{{ENVIRONMENT}}"
  labels:
    app: "{{ APP_NAME }}-{{ENVIRONMENT}}"
    env: {{ ENVIRONMENT }}
    app.kubernetes.io/name: "{{ APP_NAME }}-{{ENVIRONMENT}}"
    app.kubernetes.io/version: "{{ APP_VERSION }}"
    app.kubernetes.io/component: dataflow
    app.kubernetes.io/managed-by: chappie
# selector's label name should match labels field inside template
spec:
  selector:
      matchLabels:
        app: {{ APP_NAME }}-{{ENVIRONMENT}} 
  template:
    metadata:
      labels:
        app: {{ APP_NAME }}-{{ENVIRONMENT}} # should match selector label
```

## 2.5.2 Rolling updates

strategy type:
- RollingUpdate
  - 25% max unavailable, 25$ max surge
  - Recreate
- RollingBacks


```bash
kubectl edit deployment frontend
kubectl set image <deployment-name> <image-name>
kubectl rollout status <deployment-name>
kubectl rollout history <deployment-name>
kubectl rollout undo <deployment-name>

# interacting with k8s pods/node
kubectl exec --namespace=<ns> curl -- sh -c '<doing something>'
```

## 2.5.3 Job 

job is basically a task to achieve certian goals. You can set `backoffLimit` which tells it to retry up to how many times until the goal is achieved.

what kind of tasks are suitable to run as job:
- non-parallel job
- parallel jobs with a work queue
- parallel jobs with a fixed completion count

jobs: one-off run

batch jobs

restartPolicy: Never/Always

parallelism: 3

## 2.5.4 CronJob

looks like job and cronjob support different fields in spec

```yaml
# cronjob configuration

apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: <container_name>
          restartPolicy: OnFailure

```

[CRON expression generator](https://www.freeformatter.com/cron-expression-generator-quartz.html)

Field name   | Mandatory? | Allowed values  | Allowed special characters
----------   | ---------- | --------------  | --------------------------
Seconds      | Yes        | 0-59            | * / , -
Minutes      | Yes        | 0-59            | * / , -
Hours        | Yes        | 0-23            | * / , -
Day of month | Yes        | 1-31            | * / , - ?
Month        | Yes        | 1-12 or JAN-DEC | * / , -
Day of week  | Yes        | 0-6 or SUN-SAT  | * / , - ?

# 2.6 service & networking

services

ingress

ingress controller

egress

network traffic

# 2.7 State Persistence

persistent volumes

PersistentVolumnClaims

```yaml
# PV

apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv0003
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2

```

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


