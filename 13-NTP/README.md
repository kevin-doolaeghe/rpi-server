# NTP - Synchronisation du temps

## Visualiser la date et l'heure :

* Méthode n°1 :

```
timedatectl status
```

* Méthode n°2 :

```
date
```

## Synchroniser la date et l'heure du serveur

### Installer le package `ntp` :

```
sudo apt install ntp
```

### Configurer le package `ntp` :

1. Editer le fichier `/etc/ntp.conf` :

```
sudo nano /etc/ntp.conf
```

2. Supprimer les pools existants

3. Ajouter les pools suivants :

```
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst
server 3.fr.pool.ntp.org iburst
```

4. Configurer le réseau pour le service :

```
restict 192.168.1.0 mask 255.255.255.0 nomodify notrap
```

5. Sauvegarde et quitter le fichier de configuration

6. Redémarrer le service `ntp` :

```
sudo /etc/init.d/ntp restart
```

### Lister les serveurs NTP associés:

```
ntpq -p
```

## Créer le serveur de temps pour un réseau local

### Installer `chrony`

```
sudo apt install chrony
```

### Démarrer `chrony`

```
sudo systemctl start chronyd
```

### Activer le démarrage automatique de `chrony`

```
sudo systemctl enable chronyd
```

### Vérifier l'état du service `chrony`

```
sudo systemctl status chronyd
```

### Configurer `chrony`

1. Editer le fichier `/etc/chrony/chrony.conf` :

```
sudo nano /etc/chrony/chrony.conf
```

2. Supprimer les pools existants

3. Ajouter les serveurs de temps ci-dessous à la place :

```
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst
server 3.fr.pool.ntp.org iburst
```

4. Sauvegarder et quitter le fichier de configuration

5. Redémarrer le service `chrony`

```
sudo service chrony restart
```

### Vérifier la synchronisation de `chrony`

```
sudo chronyc tracking
```

### Afficher les serveurs sources de `chrony`

```
sudo chronyc sources
```
