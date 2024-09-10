#!/bin/sh
# Generate a random admin password
ADMIN_PASSWORD=$(openssl rand -base64 12)
# Add the Grafana Helm chart repository
helm repo add grafana https://grafana.github.io/helm-charts

# Update your local Helm chart repository cache
helm repo update

# Create the 'monitoring' namespace if it does not exist
kubectl create namespace grafana 

# Install Grafana with a release name 'grafana' into the 'monitoring' namespace
helm install grafana grafana/grafana \
  --namespace grafana \
  --values grafana.yaml \
  --set persistence.enabled=true \
  --set persistence.storageClassName=gp2 \
  --set adminPassword="$ADMIN_PASSWORD" \
  --set service.type=LoadBalancer

# Output the admin password
echo "Grafana admin password: $ADMIN_PASSWORD"

kubectl get all -n grafana