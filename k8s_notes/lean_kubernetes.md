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
- confused about the difference between yaml file for deployment and pod
- update a pod rolling update strategy (at container level? or pod level? path under spec is not clear), update images, roll back
- create config map or secert and consume from a path in container
- ambassordor pattern, exposed port the service connect to can change
- declare cpu/memory usage for pod/container (confused with what are defined at which level)
- sidecar pattern(pipe log to file), sidecar container read from logfile and pipe into new file in json format
- consume service account in pod/deployment? 
- use environment variables in pod or deployment? 
- container/pod intitialization
- define cronjob, make sure the job complete at least once
- [liveness http request](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-http-request), with two endpoints mentioned, one is for actual serving, `/healthz` is for detecting responsive or not.
     - liveness probe: container restart if failed
     - readiness probe: 