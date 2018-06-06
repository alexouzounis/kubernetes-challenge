# Kubernetes Challenge

## Challenge

Get this application running in
[Minikube](https://github.com/kubernetes/minikube), a local Kubernetes Cluster.

Note: This challenge requires **no** external resources other than
GitHub to clone and fork.
You can use Minikube's docker engine from your host machine to make
the image available in the cluster.

## How Can I Take The Challenge ?

* Fork the repo
* Write the k8s specs for a deployment, service, ingress and configmap and
anything else you believe is required
* Provide a script to run the deployment
* Make sure to update this [README](README.md) with instructions on
how to build, deploy and test
* Submit a PR when ready

## Success Factors

* Application can be deployed by invoking a single command in a
vanilla Kubernetes - Minikube cluster
* All pods must be running
* The application must be accessible by curling the URL
the application is served at

## Bonus Points

* Use [HELM](https://helm.sh)
* Create a `Makefile` for defining the build, deploy and test workflows
* Get the application to return your name instead of "Hello unknown"


# Solution


## Environment Setup

This solution assumes that Minikube has already been started and
configured `kubectl` to use it as the current context. This can be done
by running `minikube start`. It also requires that the Tiller agent is
running and in a ready state on your Minikube cluster, which can be done
by running  the command`helm init` at the terminal with Helm installed.


## Build

To build the application you can run a `make build` in the project root which
will carry out the following steps:

* Enable the ingress addon on the running Minikube instance
* Build the application container and make it available to Minikube's
docker daemon (locally)

`make deploy` (explained below) will also carry out those steps as well as
deploy the application over Minikube.


## Build/Deployment

To deploy the application simply run `make deploy` in the project root, which
will run all the steps defined in the "Build" step above in addition to a
`helm install` that will launch the Kubernetes defined Deployment, Service,
ConfigMap and Ingress required to fully deploy the application on Minikube
and make it available to the host.

The helm notes displayed at the end of the output will guide you on how
to access the service endpoint, which will be reachable at the running
Minikube VM's IP on port 80 (Minikube's IP can also be found by running
`minikube ip` at the terminal).


## Teardown

To tear the application down run `make teardown`, which will
delete the helm release both on your Minikube instance as well as locally
via a `helm delete --purge` command.


## Test

To run tests via npm, you'll just need to run `make test`.
