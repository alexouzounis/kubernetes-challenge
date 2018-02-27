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

## Solution 
*  How to build 
*  make build  <- to build image
*  make deploy <- to deploy to Minikube cluster 
#  Assumption 
*  Minikube use registry path localhost:3000  
## Limitation 
*  I am sorry that  I don't have minikube installed.  This solution deployed on my test cluster.
*  I just build image and push to my public registory to test 
*  image path : samsonbabu/k8sc-image:0.1
*  You may use my public registory and update following configMap (data:NAME) to your name to test
*  k8s-challenge-configmap.yaml 
*  also update  k8s-challenge-deployment.yaml  if you choose test public image
*  image: samsonbabu/k8sc-image:0.1
# Test  
*  curl http://<yourdomain>/k8s-challenge OR 
*  kubectl get service k8sc-service -o wide 
*  note down port 80:<port?> 
*  kubectl get pod -o wide 
*  note down NODE
* curl http://<NODE IP>:<port>
