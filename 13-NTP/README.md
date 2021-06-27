# NTP - Synchronisation du temps

## Installer le package `ntp` :

```shell
sudo apt install ntp
```

## Visualiser la date et l'heure :

* Méthode n°1 :

```shell
timedatectl status
```

* Méthode n°2 :

```shell
date
```

## Configurer le package `ntp` :

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

5. Redémarrer le service `ntp` :

```shell
sudo /etc/init.d/ntp restart
```

## Lister les serveurs `ntp` associés:

```shell
ntpq -p
```

## Installer `chrony

```shell
sudo apt install chrony
```

## Démarrer `chrony`

```shell
sudo systemctl start chronyd
```

## Activer le démarrage automatique de `chrony`

```shell
sudo systemctl enable chronyd
```

## Vérifier l'état du service `chrony`

```shell
sudo systemctl status chronyd
```

## Configurer `chrony`

1. Editer le fichier `/etc/chrony/chrony.conf` :

```shell
sudo nano /etc/chrony/chrony.conf
```

2. Modifier la configuration comme indiqué ci-après :

```shell
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst
server 3.fr.pool.ntp.org iburst
```

3. Redémarrer le service `chrony`

```shell
sudo service chrony restart
```

## Vérifier la synchronisation de `chrony`

```shell
sudo chronyc tracking
```

## Afficher les serveurs sources de `chrony`

```shell
sudo chronyc sources
```
