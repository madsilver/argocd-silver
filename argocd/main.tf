provider "kubernetes" {
  config_path = "~/.kube/config" # Ou o caminho do seu kubeconfig
}

resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "podinfo-${var.environment}"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/madsilver/argocd-silver.git"
        targetRevision = "${var.branch}"
        path           = "podinfo"
        helm = {
          valueFiles = ["envs/${var.environment}/values.yaml"]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.environment
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true", "ApplyOutOfSyncOnly=true"]
      }
    }
  }
}