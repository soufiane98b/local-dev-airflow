# local-dev-airflow


## Install k3d, helm, docker

## Add desired dependencies in requirements

## Build your image

docker build -t mon-airflow-personnalise:latest .

## Create cluster with k3d

k3d cluster create mycluster -v /Users/soufiane/Documents/GitHub/local-dev-airflow/dags:/data/myvolume --registry-create mycluster-registry

## Tag Image for Local Registry and push 

add in /etc/hosts 127.0.0.1 mycluster-registry

check the port mapped with docker ps -f name=mycluster-registry , here for me for example it is 59846

docker tag mon-airflow-personnalise:latest mycluster-registry:51697/mon-airflow-personnalise:latest

docker push mycluster-registry:51697/mon-airflow-personnalise:latest

## For testing image
kubectl run --image mycluster-registry:51697/mon-airflow-personnalise:latest testimage --command -- tail -f /dev/null

## Install official helm chart of airflow 

helm upgrade --install airflow apache-airflow/airflow --namespace airflow --create-namespace

## Create pv in the cluster
kubectl apply -f airflow-dags-pv.yaml 

## Create pvc in the cluster
kubectl apply -f airflow-dags-pvc.yaml

Finally all the dags you create in the folder dags will be visible

## To add open lineage with marquez to airflow
IMPORTANT : in myvalues.yaml update defaultAirflowRepository with the right port !

helm upgrade airflow apache-airflow/airflow -f myvalues.yaml -n airflow


## Ps: don't forget to port forward the webserver of airflow to access to the web api


## Commands good to know : 
helm get values  airflow  -n airflow
helm get all  airflow  -n airflow > values.yaml
helm rollback airflow 2 -n airflow
