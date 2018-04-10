NAME := kubernetes-challenge
TAG := $(if $(tag),$(tag),latest)
THIS := $(realpath $(lastword $(MAKEFILE_LIST)))
HERE := $(shell dirname "$(THIS)")
USERNAME := $(if $(name),$(name),Peter)

.PHONY: init
init:
	minikube ip --logtostderr >/dev/null 2>&1 || minikube start
	minikube addons list | grep -q "ingress: enabled" || minikube addons enable ingress
	eval $(minikube docker-env)

.PHONY: build
build:
	docker build --tag $(NAME):$(TAG) $(HERE)

.PHONY: deploy/kubectl
deploy/kube:
	$(foreach config, configmap deployment service ingress, kubectl create -f "$(HERE)/charts/vanilla/$(config).yaml" || exit 1;)

.PHONY: clean/kubectl
clean/kube:
	$(foreach config, configmap deployment service ingress, kubectl delete -f "$(HERE)/charts/vanilla/$(config).yaml" || exit 1;)

.PHONY: deploy/helm
deploy/helm:
	helm install "$(HERE)/charts/kubernetes-challenge" \
		--name $(NAME) \
		--set username=$(USERNAME)

.PHONY: clean/helm
clean/helm:
	helm del --purge $(NAME)

.PHONY: test
test: test/init test/service test/ingress

.PHONY: test/init
test/init:
	$(eval SERVICE_URL := $(shell minikube service $(NAME) --url --logtostderr 2>/dev/null))
	@test -n "$(SERVICE_URL)" || (echo "$(NAME) service not ready" && false)

.PHONY: test/service
test/service: test/init
	curl -sw "\n" $(SERVICE_URL)
	@test "$(shell curl -sw "\n" $(SERVICE_URL))" = "Hello $(USERNAME)!" || (echo "Service replied with incorrect response" && false)

.PHONY: test/ingress
test/ingress: test/init
	curl -sw "\n" http://$(shell minikube ip)
	@test "$(shell curl -sw "\n" http://$(shell minikube ip))" = "Hello $(USERNAME)!" || (echo "Ingress replied with incorrect response" && false)
