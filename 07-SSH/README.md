# SSH - Accès à distance

Le package `ssh` (Secure Shell) est préinstallé sur la plupart des distributions Linux nativement.  

## Activation du service

### Méthode n°1 :

A l'installation du système, créer un fichier nommé `ssh` à la racine du support de stockage.

### Méthode n°2 :

Le logiciel Raspberry Pi Imager permet de d'activer le service SSH à l'aide du raccourci `Ctrl`+`Shift`+`X`

### Méthode n°3 :

* Ouvrir le menu de configuration du Raspberry Pi :

```shell
sudo raspi-config
```

* Trouver la rubrique intitulée SSH sous la section `Interface Options`

* Activer l'option puis quitter le menu de configuration

### Méthode n°4 :

Activer SSH à l'aide de la commande `systemctl` :

```
sudo systemctl enable ssh
sudo systemctl start ssh
```
