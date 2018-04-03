config:
	@eval $(minikube docker-env)
	@helm init --upgrade

build:
	@docker build  -t solarwinds-k8s-challange:dev .

install-helm:
	@helm install --replace ./charts/solarwinds-k8s-challange \
		--name $(RELEASE_NAME) \
		--set user.name=$(USER_NAME) \
		--set image.repository=solarwinds-k8s-challange \
		--set image.tag=dev 

deploy: build install-helm

connect:
	$(eval $@_POD_NAME := $(shell kubectl get pods --namespace default -l "app=solarwinds-k8s-challange,release=$(RELEASE_NAME)" -o jsonpath="{.items[0].metadata.name}"))
	kubectl port-forward $($@_POD_NAME) 3000:3000

clean:
	@helm delete $(RELEASE_NAME) 


