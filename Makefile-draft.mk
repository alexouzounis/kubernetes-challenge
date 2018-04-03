config:
	@eval $(minikube docker-env)
	@helm init --upgrade
	@draft init
	@draft config set disable-push-warning 1

up:
	@draft up

build: up

deploy: up

connect:
	@draft connect --override-port "3000:3000"

clean:
	@draft delete

.PHONY: info config up build deploy connect clean