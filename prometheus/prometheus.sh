helm install prometheus prometheus-community/prometheus --namespace prometheus --create-namespace --set alertmanager.persistentVolume.storageClass="gp2" --set server.persistentVolume.storageClass="gp2"
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  labels:
    app.kubernetes.io/instance: prometheus
    app.kubernetes.io/name: alertmanager
  name: storage-prometheus-alertmanager-0
  namespace: prometheus
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  volumeMode: Filesystem
  storageClassName: gp2
EOF
