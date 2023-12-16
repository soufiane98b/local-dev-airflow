# local-dev-airflow


## Install helm chart
Before installing this helm chart please provide the correct values in the values file

```
helm dependency update
helm upgrade --install airflow . -n default
```

k3d cluster create mycluster -v /Users/soufiane/Documents/GitHub/local-dev-airflow/dags:/data/myvolume

helm upgrade --install airflow apache-airflow/airflow --namespace airflow --create-namespace

kubectl apply -f airflow-dags-pv.yaml 

kubectl apply -f airflow-dags-pvc.yaml 

helm upgrade airflow apache-airflow/airflow -n airflow \
  --set dags.persistence.enabled=true \
  --set dags.persistence.existingClaim=airflow-dags \
  --set dags.persistence.storageClassName=local-storage
