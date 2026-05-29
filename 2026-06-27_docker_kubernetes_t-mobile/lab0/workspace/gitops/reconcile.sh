flux reconcile source git -n flux-system         gitops
flux reconcile source git -n gitops-ondrejsika  counter

flux reconcile kustomization -n flux-system   flux-system
flux reconcile kustomization -n flux-system   gitops-ondrejsika
flux reconcile kustomization -n flux-system   gitops-dela
flux reconcile kustomization -n flux-system   kargo

flux reconcile helmrelease -n gitops-ondrejsika   counter
flux reconcile helmrelease -n kargo kargo
