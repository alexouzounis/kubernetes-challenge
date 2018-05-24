SHELL := /bin/bash
REPOSITORY = kubernetes-challenge/$(shell node -p -e "require('./app/package.json').name" app/app.js)
TAG = $(shell node -p -e "require('./app/package.json').version" app/app.js)
NAMESPACE = default
CHART = hello-unknown
SET_ARGS = --set "app.name=$(NAME)" --set image.repository=$(REPOSITORY) --set image.tag=$(TAG)
NAME = Andrew Rynhard

all: deploy

.PHONY: build test deploy clean

start:

build:
	@eval $$(minikube docker-env --shell bash) ;\
	docker build -t $(REPOSITORY):latest . ;\
	docker tag $(REPOSITORY):latest $(REPOSITORY):$(TAG)

test:
	helm lint $(SET_ARGS) chart/$(CHART)

deploy: build test
	helm upgrade --debug --wait --kube-context minikube --install $(SET_ARGS) --namespace $(NAMESPACE) $(CHART) chart/$(CHART)

clean:
	helm delete --purge $(CHART)
