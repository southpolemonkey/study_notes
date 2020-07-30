# Recap

What is pod? What's the difference between pod and deployment?

```bash
# create pod
kubectl run <pod_name>

# rest resources
kubectl create deployment --image <image_name>
```

You shoul be familiar with creating these basic resources:

- create deployment with replicas
- create a persistent volume, persisitent volume claim
- expose a servce 
- create ingress
- set environment variables for image
- update resourcs(add label, change env etc)

```bash
# add env to nginx-app
kubectl set env deployment/nginx-app  DOMAIN=cluster

# switch context
kubectl config use-context my-cluster-name

```

## exam questions 

- confused with the correct api version.
     - pod: v1
     - deployment: apps/v1
- confused about the difference between yaml file for deployment and pod
     - use `explain`
- update a pod rolling update strategy (at container level? or pod level? path under spec is not clear), update images, roll back
     - strategy is defined at deployment level, same level as container in path 
     - set image <deployment_name> <image_name>
     - rollout undo <deployment_name>
- create config map or secert and consume from a path in container
- ambassordor pattern, exposed port the service connect to can change
- declare cpu/memory usage for pod/container (confused with what are defined at which level)
     - resources are requested per container (same level as image under container path)
     - add resources limits 
- sidecar pattern(pipe log to file), sidecar container read from logfile and pipe into new file in json format
  - pod with multiple containers 
- consume service account in pod/deployment? 
- use environment variables in pod or deployment?
  - pod level, more precise, inside container
- container/pod intitialization
  - create pod with initial container
- define cronjob, make sure the job complete at least once
- [liveness http request](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-http-request), with two endpoints mentioned, one is for actual serving, `/healthz` is for detecting responsive or not.
     - liveness probe: container restart if failed
     - readiness probe: 
- pod affinity
- use json path to query status of resources and output to specific path
     - `kubectl apply -f https://k8s.io/examples/controllers/fluentd-daemonset.yaml --dry-run=client -o go-template='{{.spec.updateStrategy.type}}{{"\n"}}'`
- exec into pod/container?
  - `kubectl exec -it init-demo -- /bin/bash`
- affinity
  - node affinity
  - pod affinity
  - operator supports (In, NotIn, Exists, DoesNotExist, Gt, Lt)




```yaml
# declare resources for containers
containers:
  - image: <image_name>
    name: <container_name>
    resources:
      requests:
        cpu: "500m"
        memory: "128Mi"
      limits:
        cpu: "1000m"
        memory: "256Mi"

# use configmap 
envFrom:
  - configMapRef:
      name: <configMap_name>
  - secretRef:
      name: <secret_name>

# use configmap in a volume
container:
  - name: busybox
    volumeMounts:
    - name: <volume_name>
      path: <mount_path>
volumes:
  - name: <volume_name>
    configMap:
      name: <configmap_name>
      items:
      - key: <key1>
        value: <item1>

# define command and arguments for container
container:
- name: busybox
  command: ["/bin/sh"]
  args: ["-c", "while true; do echo hello; sleep 10;done"]

# use service account (at pod level)
# (optional) create service account = role(bunch of permissions) + roleBinding(bind role to serviceAccount)
# serviceAccount ---> token ----> secret
container:
 ...
serviceAccount: <sevice_account_name>

# pod with initial container
container:
- name: ....
initContainers:
- name: ....

```