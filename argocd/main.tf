provider "kubernetes" {
  config_path = "~/.kube/config" # Ou o caminho do seu kubeconfig
}

resource "kubernetes_manifest" "argocd_application_staging" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "podinfo-stg"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/madsilver/argocd-silver.git"
        targetRevision = "development"
        path           = "podinfo"
        helm = {
          valueFiles = ["envs/staging/values.yaml"]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "staging"
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

resource "kubernetes_manifest" "argocd_application_production" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "podinfo-prd"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/madsilver/argocd-silver.git"
        targetRevision = "main"
        path           = "podinfo"
        helm = {
          valueFiles = ["envs/production/values.yaml"]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "production"
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