# Utilisateurs

## Afficher les utilisateurs

```shell
users
```

## Ajouter un utilisateur

* Méthode n°1 :

```shell
useradd <user>
```

* Méthode n°2 :

```shell
sudo adduser <user>
```

## Supprimer un utilisateur

* Méthode n°1 :

```shell
userdel -r <user>
```

* Méthode n°2 :

```shell
sudo deluser <user>
```

## Modifier un utilisateur

```shell
usermod <options> <params> <user>
```

# Groupes

## Afficher les groupes

```shell
groups
```

## Afficher les groupes auxquel appartient un utilisateur

```shell
groups <user>
```

## Ajouter un groupe

* Méthode n°1 :

```shell
groupadd <group>
```

* Méthode n°2 :

```shell
sudo addgroup <group>
```

## Supprimer un groupe

* Méthode n°1 :

```shell
groupdel <group>
```

* Méthode n°2 :

```shell
sudo delgroup <group>
```

## Modifier un groupe

```shell
groupmod <options> <params> <group>
```

## Gérer les membres d'un groupe

```shell
groupmems -g <group> ...
```

## Attibuer des groupes à un utilisateur

```shell
sudo usermod -aG <group1>,<group2>... <user>
```

## Ajouter un utilisateur à un groupe

```shell
sudo gpasswd -a <user> <group>
```

## Enlever un utilisateur d'un groupe

```shell
sudo gpasswd <user> <group>
```

# Droits

## Changer le propriétaire

```shell
sudo chown <options> <user|group> <file|dir>
```

## Changer les droits d'accès

```shell
sudo chmod <options> <file|dir>
```

## Changer les groupes associés à un fichier

```shell
sudo chgrp <options> <group> <file|dir>
```

## Modifier le mot de passe de l'utilisateur actuel

```shell
passwd
```

## Modifier le mot de passe root

```shell
sudo passwd
```

# Configuration d'un nouvel utilisateur nommé `kevin`

* Ajout d'un utilisateur `kevin` :

```shell
sudo adduser kevin
```

* Attribution des groupes à l'utilisateur `kevin` :

```shell
sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio kevin
```

Le fichier `/etc/sudoers.d/010_pi-nopasswd` contient la directive qui permet de ne pas avoir à entrer de mot de passe à lors de l'utilisation de la commande `sudo` pour l'utilisateur `pi`.

* Edition du fichier `010_kevin-nopasswd` :

```shell
sudo nano /etc/sudoers.d/010_kevin-nopasswd
```

* Ajout de la directive permettant de ne pas avoir à entrer de mot de passe pour la commande `sudo` :

```shell
kevin ALL=(ALL) NOPASSWD: ALL
```
