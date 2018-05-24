# Hello `unknown`

## Getting Started

To get started you will first need to have access to a Kubernetes cluster.
For local development we recommend [minikube](https://github.com/kubernetes/minikube) on [hyperkit](https://github.com/moby/hyperkit).

### Install Minikube and the HyperKit Driver

```bash
curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
&& chmod +x /usr/local/bin/minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& chmod +x docker-machine-driver-hyperkit \
&& sudo mv docker-machine-driver-hyperkit /usr/local/bin/ \
&& sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit \
&& sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
```

### Start Minikube

```bash
minikube start --vm-driver=hyperkit --kubernetes-version=v1.10.3
```

### Install Helm

We will use [Helm](https://github.com/kubernetes/helm) to manage the Kubernetes resources.
Install `helm` by running the following:

```bash
curl -L https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-darwin-amd64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1 darwin-amd64/helm \
&& chmod +x /usr/local/bin/helm
kubectl --context minikube create serviceaccount tiller --namespace kube-system
kubectl --context minikube create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --kube-context minikube
```

## Developing the Application

To build, test, and deploy, run:

```bash
make
```

There are also build, test, and deploy targets you can use:

```bash
make build
make test
make deploy
```

### Accessing the Application

#### Port Forwarding

The application can be accessed by running the following:

```bash
kubectl port-forward deployment/hello-unknown 3000:3000
```

and then navigating to `127.0.0.1:3000` in your browser.

#### Ingress

Another option is to use [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
To use ingress, first install the Nginx ingress controller:

```bash
minikube addons enable ingress
```

Now, simulate the application's DNS by appending to `/etc/hosts`

```bash
echo "$(minikube ip) hello-unknown.local" | sudo tee -a /private/etc/hosts
```

> NOTE: `/private/etc/hosts` assumes you are working on OS X. Use `/etc/hosts` if you are on Linux.
> Additionally, you must ensure that the IP address is updated if you delete the cluster and rebuild it.

Now, navigate to [hello-unknown.local](http://hello-unknown.local) in your browser.

## References

- https://github.com/kubernetes/minikube/blob/master/docs/drivers.md
- https://github.com/kubernetes/helm/blob/master/docs/rbac.md
