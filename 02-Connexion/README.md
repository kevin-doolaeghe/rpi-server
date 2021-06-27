# Connexion

## Indentifiants par défaut

Pour se connecter au premier démarrage de Raspberry Pi OS, il faut entrer les identifiants suivants :

Utilisateur  : `pi`  
Mot de passe : `raspberry`

## Modifier le mot de passe

Modifier le mot de passe de l'utilisateur actuel :

```shell
passwd
```

Modifier le mot de passe super-utilisateur :

```shell
sudo passwd
```

## Changer le nom de la machine

* Modifier le fichier `/etc/hosts` :

```shell
sudo nano /etc/hosts
```

```shell
127.0.0.1	localhost
::1		    localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters

127.0.1.1	[nom_machine]
```

* Modifier le fichier `/etc/hostname` :

```shell
sudo nano /etc/hostname
```

```shell
[nom_machine]
```
