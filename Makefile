NAME := kubernetes-challenge
TAG := $(if $(tag),$(tag),latest)
THIS := $(realpath $(lastword $(MAKEFILE_LIST)))
HERE := $(shell dirname "$(THIS)")

.PHONY: init
init:
	minikube ip --logtostderr >/dev/null 2>&1 || minikube start
	minikube addons list | grep -q "ingress: enabled" || minikube addons enable ingress
	eval $(minikube docker-env)

.PHONY: build
build:
	docker build --tag $(NAME):$(TAG) $(HERE)
