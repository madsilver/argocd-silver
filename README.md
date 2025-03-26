# argocd-silver

```
📦 argocd-silver/
├── 📂 k8s/                  # Diretório com os manifestos Kubernetes
│   ├── deployment.yaml      # Deployment da aplicação
│   ├── service.yaml         # Service para expor a aplicação
│   ├── ingress.yaml         # (Opcional) Ingress para expor externamente
│   ├── configmap.yaml       # (Opcional) Configurações da aplicação
│   ├── secret.yaml          # (Opcional) Segredos da aplicação
│   ├── hpa.yaml             # (Opcional) Autoescalamento Horizontal
│   └── namespace.yaml       # (Opcional) Namespace específico
├── 📂 helm-chart/           # (Opcional) Chart Helm, se estiver usando Helm
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── README.md                # Documentação do repositório
```

## Access

### Load Balancer

```sh
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

### Node Port

```sh
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

```

### Port Forward

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

```sh
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
```

## Argo

```sh
kubectl delete application podinfo -n argocd
```


## Helm

```sh
# create
helm create podinfo
# install
helm install podinfo ./podinfo
# atualizar
helm upgrade podinfo ./podinfo # Se modificar algo no values.yaml
# remover
helm uninstall podinfo

# mudar a env
helm upgrade podinfo ./podinfo --set config.APP_ENV=production

helm upgrade --install podinfo-stg ./podinfo -f values.yaml -f envs/staging/values.yaml --namespace staging

helm upgrade --install podinfo-prd ./podinfo -f values.yaml -f envs/production/values.yaml --namespace production
```

## Terraform

### Deploy

```sh
# Staging
terraform apply -auto-approve -var="environment=staging"

# Production
terraform apply -auto-approve -var="environment=production"
```
