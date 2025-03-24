
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
