# Kubernetes challenge

## Challenge

Get this application running in a Kubernetes Cluster.
You may use [Minikube](https://github.com/kubernetes/minikube) to test it locally

Note: This challenge requires **no** external resources other than GitHub to clone and fork.

## How Can I Take The Challenge ?

* Fork the repo
* Write the k8s specs for a deployment, service, ingress and configmap and anything else you believe is required
* Provide a script to run the deployment
* Feel free to test everything on Minikube
* Make sure to update this [README](README.md) with instructions on how to build, deploy and test
* Submit a PR when ready 

## Success Factors

* Application can be deployed by invoking a single command in a vanilla Kubernetes cluster
* All pods must be running
* The application must be accessible by curling the URL the application is served at

## Bonus Points

* Use [HELM](https://helm.sh)
* Create a `Makefile` for defining the build, deploy and test workflows 

