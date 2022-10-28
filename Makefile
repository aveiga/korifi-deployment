kubernetes:
	civo kubernetes create korifi --save --nodes 3 --size g4s.kube.medium --remove-applications=Traefik-v2-nodeport --switch --wait

cert-manager:
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml

kpack:
	kubectl apply -f  https://github.com/pivotal/kpack/releases/download/v0.7.2/release-0.7.2.yaml
	# kubectl get pods -n kpack --watch

contour:
	kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
	# kubectl get pods -n projectcontour -o wide --watch

service-binding:
	kubectl apply -f https://github.com/servicebinding/runtime/releases/download/v0.2.0/servicebinding-runtime-v0.2.0.yaml

korifi:
	./korifi.sh

all: cert-manager kpack contour service-binding korifi

complete: kubernetes all