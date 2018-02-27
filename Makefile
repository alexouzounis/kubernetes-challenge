
default: build

build:
	docker build  -t k8sc-image .
deploy: 
	docker build  -t k8sc-image .
	docker tag k8sc-image localhost:3000/k8sc-image
	docker push localhost:3000/k8sc-image
	kubectl apply -f k8s-challenge-configmap.yaml
	kubectl apply -f k8s-challenge-deployment.yaml
	kubectl apply -f k8s-challenge-service.yaml
	kubectl apply -f k8s-challenge-ingress.yaml
