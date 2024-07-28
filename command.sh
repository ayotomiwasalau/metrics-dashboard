kubectl get pods -n cert-manager

kubectl port-forward service/frontend-service --address 0.0.0.0 8080:8080 -n default

kubectl port-forward -n observability  service/simplest-query --address 0.0.0.0 16686:16686

sudo docker build reference-app/frontend/ -t tomiwasalau01/frontend-service:latest

sudo docker push tomiwasalau01/frontend-service:latest

