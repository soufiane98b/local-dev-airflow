# local-dev-airflow


## Install k3d, helm, docker

## Create cluster with k3d

k3d cluster create mycluster -v /Users/soufiane/Documents/GitHub/local-dev-airflow/dags:/data/myvolume

## Install official helm chart of airflow 
helm upgrade --install airflow apache-airflow/airflow --namespace airflow --create-namespace

## Create pv in the cluster
kubectl apply -f airflow-dags-pv.yaml 

## Create pvc in the cluster
kubectl apply -f airflow-dags-pvc.yaml 

## Update helm chart to attach add pvc to the required pods for airflow
helm upgrade airflow apache-airflow/airflow -n airflow \
  --set dags.persistence.enabled=true \
  --set dags.persistence.existingClaim=airflow-dags \
  --set dags.persistence.storageClassName=local-storage

Finally all the dags you create in the folder dags will be visible

## Ps: don't forget to port forward the webserver of airflow to access to the web api
