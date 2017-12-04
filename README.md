# Kubernetes Challenge

## Challenge

Get this application running in [Minikube](https://github.com/kubernetes/minikube), a local Kubernetes Cluster.

Note: This challenge requires **no** external resources other than GitHub to clone and fork. 
You can use Minikube's docker engine from your host machine to make the image available in the cluster.

## How Can I Take The Challenge ?

* Fork the repo
* Write the k8s specs for a deployment, service, ingress and configmap and anything else you believe is required
* Provide a script to run the deployment
* Make sure to update this [README](README.md) with instructions on how to build, deploy and test
* Submit a PR when ready 

## Success Factors

* Application can be deployed by invoking a single command in a vanilla Kubernetes - Minikube cluster
* All pods must be running
* The application must be accessible by curling the URL the application is served at

## Bonus Points

* Use [HELM](https://helm.sh)
* Create a `Makefile` for defining the build, deploy and test workflows
* Get the application to return your name instead of "Hello unknown"

