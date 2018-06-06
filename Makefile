setup:
	minikube addons enable ingress
build: setup
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

