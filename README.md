# Kubernetes Challenge

## Challenge

Get this application running in [Minikube](https://github.com/kubernetes/minikube), a local Kubernetes Cluster.

Note: This challenge requires **no** external resources other than GitHub to clone and fork.
You can use Minikube's docker engine from your host machine to make the image available in the cluster.

## How Can I Take The Challenge

* Fork the repo
* Write the k8s specs for a deployment, service, ingress and configmap and anything else you believe is required
* Provide a script to run the deployment
* Make sure to update this [README](README.md) with instructions on how to build, deploy and test
* Submit a PR when ready

## Success Factors

* Application can be deployed by invoking a single command in a vanilla Kubernetes - Minikube cluster
* All pods must be running
* The application must be accessible by curling the URL the application is served at

## Solution

Solution uses Helm Chart and is my first experience with Draft. I also did not
want a hard dependency on Draft. Consequently, the makefile is bimodal. If the
user has [asdf](https://github.com/asdf-vm/asdf) installed, make deps will
install Draft. Without asdf, Helm is assumed and used directly.

`make all` and let me know how it goes.

`make accept` from a different shell will make a simple assertion using curl.

`make clean` will remove the app from minikube

Includes:

* Updated app with Signal Event handling and k8s ready liveness and readiness
endpoints.

* Multi stage docker build with embedded smoke test.

* A dev Helm chart, complete with a configmap to set the hello name

* The service uses ClusterIP rather than ingress or NodePort to ensure
appropriate access to the application in development. Proxy is used for
reachability.

* Minikube's Docker engine is used to build the image to eliminate the push step
and decrease the cycle time, especially when using draft's watch feature.

* Attemps to use [asdf](https://github.com/asdf-vm/asdf) to ensure matching 
draft, helm, and kubectl binaries but it is not required.

* makefile for standard lifecycle steps

Caveats:

* Draft does not support overriding values in values.yml as Helm does. Rather
than template the file with sed replacement, Draft workflow uses the coded name
'tom' - to change this, both the values.yaml and the Makefile must be edited
(or update the configmap and restart the pod).

* Helm path sets the hello name of the app to the user invoking the make rules.

* The chart path, namespace, and proxy ports are hard coded in the Makefile.
