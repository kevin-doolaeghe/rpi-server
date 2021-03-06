# Firewall

## Installer le package `ufw` :

```shell
sudo apt install ufw
```

## Lister les applications soumises au pare-feu :

```shell
sudo ufw app list
```

## Autoriser/Refuser toutes les applications par défaut :

```shell
sudo ufw default <allow|deny>
```

## Bloquer toutes les connexions :

```shell
sudo ufw default deny incoming
sudo ufw default deny outgoing
```

## Autoriser & refuser une application ou un port :

```shell
sudo ufw <allow|deny> <app>
sudo ufw <allow|deny> <in|out> <port>/<tcp|udp>
```

## Activer & désactiver le pare-feu :

```shell
sudo ufw <enable|disable>
```

## Afficher le status du pare-feu :

```shell
sudo ufw status <verbose|numbered>
```

## Supprimer une règle :

```shell
sudo ufw delete <num>
```

## Activer la journalisation :

```shell
sudo ufw logging on
```

## Visualiser les services disponibles :

```shell
sudo cat /etc/services
```

## Script de configuration de UFW :

1. Créer un fichier `setup_firewall.sh` :

```shell
sudo nano /usr/local/bin/setup_firewall.sh
```

2. Ajouter le contenu suivant au fichier :

```shell
#!/bin/bash

#SSH
ufw allow out 22/tcp
ufw allow in 22/tcp

#HTTP
ufw allow out 80/tcp
ufw allow out 53/udp
ufw allow out 443/tcp

#FTP
ufw allow out 20/tcp
ufw allow out 21/tcp

#SMTP
ufw allow out 25/tcp
#POP3
ufw allow out 110/tcp
#Secured POP3
ufw allow out 995/tcp
#IMAP2
ufw allow out 143/tcp
#IMAP3
ufw allow out 220/tcp

#SMB
ufw allow in 445/tcp
ufw allow out 445/tcp
ufw allow samba

#Apply
ufw disable && ufw enable

#Enable logging
ufw logging on
```

3. Sauvegarder & quitter le fichier

4. Donner les droits d'exécution au script :

```shell
sudo chmod +x /usr/local/bin/setup_firewall.sh
```

5. Lancer le script :

```shell
sudo /usr/local/bin/setup_firewall.sh
```
