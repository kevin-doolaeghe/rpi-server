# Docker

## Installation de Docker :

**Lien du tutoriel officiel** : [https://docs.docker.com/engine/install/raspberry-pi-os/](https://docs.docker.com/engine/install/raspberry-pi-os/)

1. Configurer le dépôt `apt` :
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/raspbian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up Docker's Apt repository:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/raspbian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Installer la dernière version :
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Vérification de l'installation :
```
sudo docker --version
```

## Installation de `docker-compose` :

**Lien du tutoriel** : [https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-debian-10](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-debian-10)

1. Télécharger le paquet officiel :
```
sudo curl -L https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

2. Rendre exécutable le paquet `docker-compose` :
```
sudo chmod +x /usr/local/bin/docker-compose
```

3. Vérification de l'installation :
```
docker-compose --version
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
