# Utiliser l'image Airflow spécifique
FROM apache/airflow:2.7.3

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt /

# Installer les dépendances supplémentaires
RUN pip install --no-cache-dir -r /requirements.txt
