# Samba - Partage de fichiers

## Créer le serveur de partage de fichiers

1. Installer le paquet `samba` :

```shell
sudo apt install samba
```

2. Créer le répertoire de partage :

```shell
sudo mkdir /home/share
sudo chmod 777 /home/share
```

3. Ajouter un utilisateur (ou modifier son mot de passe) :

```shell
sudo smbpasswd -a <username>
```

4. Supprimer un utilisateur :

```shell
sudo smbpasswd -x <username>
```

5. Créer une sauvegarde de la configuration de Samba :

```shell
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
```

6. Editer le fichier de configuration de Samba :

```shell
sudo nano /etc/samba/smb.conf
```

7. Modifier les espaces de déclaration de partage :

```shell
[global]
  workgroup = WORKGROUP
  interfaces = wlan0
  bind interfaces only = yes
  log file = /var/log/samba/log.%m
  max log size = 1000
  logging = file
  server role = standalone server
  obey pam restrictions = yes
  unix password sync = yes
  security = user
  encrypt passwords = true
  map to guest = bad user
  guest account = nobody
  create mask = 0644
  directory mask = 0755

[homes]
  comment = Home Directories
  browseable = no
  read only = no
  valid users = %S

[public]
  comment = Public Share
  path = /home/share
  read only = yes
  guest only = yes
  guest ok = yes

[private]
  comment = Private Share
  path = /home/share
  browsable = no
  read only = no
```

8. Redémarrer le service:

```shell
sudo service smbd restart
```

9. Autoriser Samba sur le pare-feu:

```shell
sudo ufw allow samba
```

## Connexion au serveur de fichiers

### Windows :

* Ouvrir 

* Ajouter un emplacement réseau à l'adresse suivante :

```shell
\\<hostname|ip>\<share>
```

Pour la configuration précédente, le dossier de partage peut être :
- `public`
- `private`
- `<utilisateur>`

Il faut ensuite entrer les identifiants créés avec Samba pour l'utilisateur concerné.

### Linux :

* Installer le paquet `smbclient`

* Se connecter au serveur de fichiers à l'aide de la commande suivante :

```shell
smbclient '\\<hostname|ip>\<share>' [pass]
```
