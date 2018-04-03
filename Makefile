SHELL := /bin/bash
RELEASE_NAME := swk8s-$(shell git rev-parse --short --verify HEAD)

ifeq "$(shell which draft)" ""
include Makefile-helm.mk
# Helm allows overriding values.yaml values via CLI, but Draft does not
USER_NAME := $(shell whoami)
else
include Makefile-draft.mk
USER_NAME := tom
endif

init: deps config 

all: init test deploy connect

deps:
ifeq "$(shell which asdf)" ""
	@echo "asdf is not installed. Please manually verify the envrionment has:"
	@echo $(shell cat .tool-versions)
	@echo "draft is optional, but fun"
else 
	@asdf install
endif

ifeq "$(shell which minikube)" ""
	@echo "minikube is not install.
	@exit 1
endif

ifeq "$(shell minikube ip)" ""
	@minikube start
endif

test:
	@cd app &&	npm i && npm test
	@helm lint charts/solarwinds-k8s-challange/

accept:
	$(eval $@_RESULTS := $(shell curl -s http://localhost:3000))
	$(eval $@_CASE := $(shell echo "Hello $${$(USER_NAME)~}!"))
ifeq "$($@_RESULTS)" "$($@_CASE)"
	@echo "accept passed"
else
	@echo "accept failed"	
	@exit 1;
endif


.PHONY: deps test accept all init