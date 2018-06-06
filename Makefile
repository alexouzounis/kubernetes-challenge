setup:
	# Enable the Ingress addon to allow
	# application to be exposed on host.
	minikube addons enable ingress
build: setup
	# Reuse Minikube's docker daemon.
	# Reference:
	# https://kubernetes-v1-4.github.io/docs/getting-started-guides/minikube/
	@eval $$(minikube docker-env); \
	docker build -t k8schl-app .
deploy: build
	helm install --name k8schl ./k8schl --set minikubeEp=$$(minikube ip)
teardown:
	helm del --purge k8schl

