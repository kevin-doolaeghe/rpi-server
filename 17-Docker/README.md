# Docker

## Installation de Docker :

```
sudo apt install docker.io
```

## Gestion des images Docker

### Construction d'une image à partir d'un fichier Dockerfile

Les fichiers **Dockerfile** décrivent toutes les commandes afin d'automatiser la construction d'une image Docker.

Par exemple, le fichier **Dockerfile** suivant permet de lancer le script `app.js` de la machine hôte sur le conteneur :

```
FROM node:alpine
COPY . /app
WORKDIR /app
CMD node app.js
```

Construire une image à partir d'un fichier Dockerfile :

```
sudo docker build -t [image] [chemin]
```

### Utiliser une image provenant de Docker Hub

De nombreuses images Docker sont disponibles sur le site [Docker Hub](https://hub.docker.com/search?q=&type=image).

Télécharger une image issue de Docker Hub :

```
sudo docker pull [auteur]/[conteneur]
```

### Afficher la liste des images sur la machine hôte :

```
sudo docker images
```

### Supprimer une image :

```
sudo docker rmi [image]
```

## Gestion des conteneurs

### Créer et démarrer un conteneur :

```
sudo docker run --name [conteneur] -d [image]
```

Il est possible de spécifier des paramètres de démarrage du conteneur :

```
sudo docker run --name [conteneur] \
    -v [dossier]:[cible] \
    -p [port]:[cible] \
    -d [image]
```

### Supprimer un conteneur :

```
sudo docker rm [conteneur]
```

### Démarrer un conteneur :

```
sudo docker start [conteneur]
```

### Arrêter un conteneur :

```
sudo docker stop [conteneur]
```

### Entrer dans un conteneur et intéragir avec lui :

```
sudo docker exec -it [conteneur] [bash|sh]
```

### Copier des fichiers dans un conteneur :

```
sudo docker cp [src] [conteneur]:[dst]
```

### Afficher l'état des conteneurs :

* Afficher l'état des conteneurs démarrés :

```
sudo docker ps
```

* Afficher l'état de tous les conteneurs :

```
sudo docker ps -a
```
