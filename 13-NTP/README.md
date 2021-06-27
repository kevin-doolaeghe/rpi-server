# NTP - Synchronisation du temps

## Visualiser la date et l'heure :

* Méthode n°1 :

```shell
timedatectl status
```

* Méthode n°2 :

```shell
date
```

## Synchroniser la date et l'heure du serveur

### Installer le package `ntp` :

```shell
sudo apt install ntp
```

### Configurer le package `ntp` :

1. Editer le fichier `/etc/ntp.conf` :

```shell
sudo nano /etc/ntp.conf
```

2. Supprimer les pools existants

3. Ajouter les pools suivants :

```shell
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst
server 3.fr.pool.ntp.org iburst
```

4. Configurer le réseau pour le service :

```shell
restict 192.168.1.0 mask 255.255.255.0 nomodify notrap
```

5. Sauvegarde et quitter le fichier de configuration

6. Redémarrer le service `ntp` :

```shell
sudo /etc/init.d/ntp restart
```

### Lister les serveurs `ntp` associés:

```shell
ntpq -p
```

## Créer le serveur de temps pour un réseau local

### Installer `chrony`

```shell
sudo apt install chrony
```

### Démarrer `chrony`

```shell
sudo systemctl start chronyd
```

### Activer le démarrage automatique de `chrony`

```shell
sudo systemctl enable chronyd
```

### Vérifier l'état du service `chrony`

```shell
sudo systemctl status chronyd
```

### Configurer `chrony`

1. Editer le fichier `/etc/chrony/chrony.conf` :

```shell
sudo nano /etc/chrony/chrony.conf
```

2. Supprimer les pools existants

3. Ajouter les serveurs de temps ci-dessous à la place :

```shell
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst
server 3.fr.pool.ntp.org iburst
```

4. Sauvegarder et quitter le fichier de configuration

5. Redémarrer le service `chrony`

```shell
sudo service chrony restart
```

### Vérifier la synchronisation de `chrony`

```shell
sudo chronyc tracking
```

### Afficher les serveurs sources de `chrony`

```shell
sudo chronyc sources
```
