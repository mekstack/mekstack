# Kubernetes managed by Rancher Fleet

To deploy mekstack k8s resources install fleet and it will do the job

    helm repo add fleet https://rancher.github.io/fleet-helm-charts/
    helm -n cattle-fleet-system install --create-namespace --wait fleet-crd fleet/fleet-crd
    helm -n cattle-fleet-system install --create-namespace --wait fleet fleet/fleet

    echo "
    apiVersion: fleet.cattle.io/v1alpha1
    kind: GitRepo
    metadata:
      name: mekstack
      namespace: fleet-local
    spec:
      repo: https://github.com/mekstack/mekstack
      paths:
      - k8s
    " | kubectl apply -f -
