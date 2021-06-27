# Samba - Partage de fichiers

* Installer `samba` :

```shell
sudo apt-get install samba
```

* Créer le répertoire de partage :

```shell
sudo mkdir /home/share
```

* Ajouter un utilisateur:

```shell
sudo smbpasswd -a <username>
```

* Changer le mot de passe d'un utilisateur:

```shell
sudo smbpasswd -x <username>
```

* Editer le fichier de configuration de `samba` :

```shell
sudo nano /etc/samba/smb.conf
```

* Modifier les espaces de déclaration de partage :

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
  read only = no
  guest only = yes
  guest ok = yes

[private]
  comment = Private Share
  path = /home/share
  browsable = no
  read only = no
```

* Redémarrer le service:

```shell
sudo service smbd restart
```

* Autoriser `samba` sur le pare-feu:

```shell
sudo ufw allow samba
```
