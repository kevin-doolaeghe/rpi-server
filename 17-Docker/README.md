# Docker

## Installation :

```shell
sudo apt install docker.io
```

## Gestion des images Docker

### Créer une image à l'aide de d'un fichier `Dockerfile`

Les fichiers `Dockerfile` décrivent toutes les commandes afin d'automatiser la construction d'une image Docker.

Par exemple, le fichier `Dockerfile` suivant permet de lancer le script `app.js` de la machine hôte sur le container :

```shell
FROM node:alpine
COPY . /app
WORKDIR /app
CMD node app.js
```

Construire l'image :

```shell
sudo docker build -t [image] [chemin]
```

### Utiliser une image provenant de Docker Hub

De nombreuses images Docker sont disponibles sur le site [Docker Hub](https://hub.docker.com/search?q=&type=image).

### Afficher la liste des images sur la machine hôte :

```shell
sudo docker images
```

### Supprimer une image :

```shell
sudo docker rmi [image]
```

## Gestion des containers

### Afficher l'état des containers :

* Afficher les containers démarrés :

```shell
sudo docker ps
```

* Afficher tous les containers :

```shell
sudo docker ps -a
```

### Télécharger un container existant :

```shell
sudo docker pull [auteur]/[container]
```

### Créer et démarrer un container :

```shell
sudo docker run --name [container] -d [image]
```

```shell
sudo docker run --name [container] \
    -v [dossier]:[cible] \
    -p [port]:[cible] \
    -d [image]
```

### Supprimer un container :

```shell
sudo docker rm [container]
```

### Démarrer un container :

```shell
sudo docker start [container]
```

### Arrêter un container :

```shell
sudo docker stop [container]
```

### Entrer dans un container et intéragir avec lui :

```shell
sudo docker exec -it [container] [bash|sh]
```

### Copier des fichiers dans un container :

```shell
sudo docker cp [src] [container]:[dst]
```
