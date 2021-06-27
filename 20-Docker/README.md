# Docker

## Installer `docker` :

```shell
sudo apt install docker.io
```

## Gestion des images Docker

### 1. Créer une image à l'aide de d'un fichier `Dockerfile`

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

### 2. Utiliser une image provenant de Docker Hub

De nombreuses images Docker sont disponibles sur le site [Docker Hub](https://hub.docker.com/search?q=&type=image).

### 3. Afficher la liste des images sur la machine hôte :

```shell
sudo docker images
```

### 4. Supprimer une image :

```shell
sudo docker rmi [image]
```

## Gestion des containers

### 1. Afficher l'état des containers :

* Afficher les containers démarrés :

```shell
sudo docker ps
```

* Afficher tous les containers :

```shell
sudo docker ps -a
```

### 2. Télécharger un container existant :

```shell
sudo docker pull [auteur]/[container]
```

### 3. Créer et démarrer un container :

```shell
sudo docker run --name [container] -d [image]
```

```shell
sudo docker run --name [container] \
    -v [dossier]:[cible] \
    -p [port]:[cible] \
    -d [image]
```

### 4. Supprimer un container :

```shell
sudo docker rm [container]
```

### 5. Démarrer un container :

```shell
sudo docker start [container]
```

### 6. Arrêter un container :

```shell
sudo docker stop [container]
```

### 7. Entrer dans un container et intéragir avec lui :

```shell
sudo docker exec -it [container] [bash|sh]
```

### 8. Copier des fichiers dans un container :

```shell
sudo docker cp [src] [container]:[dst]
```
