provider "kubernetes" {
  config_path = "~/.kube/config" # Ou o caminho do seu kubeconfig
}

resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "podinfo"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/madsilver/argocd-silver.git"
        targetRevision = "helm"
        path           = "podinfo"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
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
