kubectl get pods -n cert-manager

kubectl port-forward service/frontend-service --address 0.0.0.0 8080:8080 -n default

kubectl port-forward -n observability  service/simplest-query --address 0.0.0.0 16686:16686

sudo docker build reference-app/frontend/ -t tomiwasalau01/frontend-service:latest

sudo docker push tomiwasalau01/trial-service:latest

kubectl rollout restart deployment backend-app
kubectl rollout restart deployment frontend-app
kubectl rollout restart deployment trial-app

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.1/deploy/static/provider/cloud/deploy.yaml

kubectl delete -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/crds/jaegertracing.io_jaegers_crd.yaml
kubectl delete -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/service_account.yaml
kubectl delete -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/role.yaml
kubectl delete -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/role_binding.yaml
kubectl delete -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/operator.yaml


kubectl delete -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/cluster_role.yaml
kubectl delete -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/${jaeger_version}/deploy/cluster_role_binding.yaml