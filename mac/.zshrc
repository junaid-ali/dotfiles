
plugins=(
  git
  kubectl
  aws
  kube-ps1
  terraform
  helm
  docker
)

alias k-events='kubectl get events --sort-by=.metadata.creationTimestamp'

k_pods_nodes() {
  context=${1:-my-ctx}
  pod_name=${2:-my-pod}
  namespace=${3:-my-ns}
  kubectl --context ${context} -n ${namespace} get pods -owide | grep ${pod_name} | awk '{ printf("%-26s %-5s %-16s %-2s %-6s %-12s %-34s\n", $1, $2, $3, $4, $5, $6, $7)}'
}

k_nodes_instances() {
  context=${1:-my-ctx}
  kubectl --context "${context}" get nodes \
          -o json | jq -r \
                       '(["NAME", "ID", "AZ"] | (., map(length*"-"))), (.items[] | [.metadata.name, .spec.providerID, .metadata.labels."topology.kubernetes.io/zone"]) | @tsv' \
                  | sed 's/aws.*\(i\-.*$\)/\1/g' | column -ts $'\t'
}

