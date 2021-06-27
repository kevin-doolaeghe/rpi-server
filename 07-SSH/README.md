# SSH - Accès à distance

Le package `ssh` est préinstallé sur la plupart des distributions Linux.  

## Activation du service

### Méthode n°1 :

A l'installation du système, créer un fichier `ssh` à la racine du support de stockage.

### Méthode n°2 :

Le logiciel Raspberry Pi Imager permet de d'activer `ssh` à l'aide du raccourci `Ctrl`+`Shift`+`X`

### Méthode n°3 :

* Ouvrir le menu de configuration du Raspberry Pi :

```shell
sudo raspi-config
```

* Trouver la rubrique intitulée `ssh` sous la section `Interface Options`

* Activer `ssh` puis quitter le menu de configuration

### Méthode n°4 :

Activer `ssh` à l'aide de la commande `systemctl` :

```
sudo systemctl enable ssh
sudo systemctl start ssh
```
