# Kubernetes Challenge

## Challenge

Get this application running in [Minikube](https://github.com/kubernetes/minikube), a local Kubernetes Cluster.

Note: This challenge requires **no** external resources other than GitHub to clone and fork.
You can use Minikube's docker engine from your host machine to make the image available in the cluster.

## Solution/Assumptions

Running local Minikube cluster with an ingress controller (`minikube addons enable ingress`).

Using Minikube's Docker daemon so builds are available within the Minikube cluster (`eval $(minikube docker-env)` - NB. will only apply to current session).

Additionally, if using helm, it is assumed that helm is configured locally and on the Minikube cluster (`helm init`).

## Build

In the root directory run `make build`.

## Deploy

Prerequisites: image has been built and is available to the cluster; see `build` step above.

### Using vanilla K8S Specs

In the root directory run `make deploy/kube`.

### Using Helm

In the root directory run `make deploy/helm`.

## Cleanup

### Using vanilla K8S Specs

In the root directory run `make clean/kube`.

### Using Helm

In the root directory run `make clean/helm`.

## Test

In the root directory run `make test`.

This will assert the following:
  1) Minikube service for kubernetes-challenge is running
  2) The application/service URL returns the expected response
  3) The ingress is configured and that a request to Minikube IP returns the expected response
