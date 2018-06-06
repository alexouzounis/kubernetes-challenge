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
	kubectl create \
	-f k8schl-dep.yaml \
	-f k8schl-svc.yaml \
	-f k8schl-ing.yaml \
	-f k8schl-conf.yaml
teardown:
	kubectl delete \
	-f k8schl-dep.yaml \
	-f k8schl-svc.yaml \
	-f k8schl-ing.yaml \
	-f k8schl-conf.yaml

