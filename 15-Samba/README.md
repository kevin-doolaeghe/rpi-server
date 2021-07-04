# Samba - Partage de fichiers

## Configurer le serveur de partage de fichiers

1. Installer le paquet `samba` :

```
sudo apt install samba
```

2. Créer le répertoire de partage :

```
sudo mkdir /home/share
sudo chmod 777 /home/share
```

3. Ajouter un utilisateur (ou modifier son mot de passe) :

```
sudo smbpasswd -a <username>
```

4. Supprimer un utilisateur :

```
sudo smbpasswd -x <username>
```

5. Créer une sauvegarde de la configuration de Samba :

```
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
```

6. Editer le fichier de configuration de Samba :

```
sudo nano /etc/samba/smb.conf
```

7. Modifier les espaces de déclaration de partage :

```
[global]
  workgroup = WORKGROUP
  server string = %h server
  interfaces = wlan0
  bind interfaces only = yes
  log file = /var/log/samba/log.%m
  max log size = 1000
  logging = file
  server role = standalone server
  obey pam restrictions = yes
  passwd program = /usr/bin/passwd %u
  passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
  pam password change = yes
  unix password sync = yes
  ntlm auth = true
  security = user
  encrypt passwords = true
  map to guest = bad user
  guest account = nobody
  server signing = mandatory
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
  guest ok = no
  valid users = kevin
```

8. Redémarrer le service:

```
sudo service smbd restart
```

9. Autoriser Samba sur le pare-feu:

```
sudo ufw allow samba
```

## Connexion au serveur de fichiers

### Windows :

* Ouvrir l'explorateur de fichiers Windows
* Ajouter un emplacement réseau à l'adresse suivante :

```
\\<hostname|adresse_ip>\<partage>
```

Pour la configuration précédente, le dossier de partage peut être `public`, `private` ou `<utilisateur>`.

* Entrer les identifiants de l'utilisateur Samba

### Linux :

* Installer le paquet `smbclient`
* Se connecter au serveur de fichiers à l'aide de la commande suivante :

```
smbclient '\\<hostname|adresse_ip>\<partage>' -U <utilisateur>%<mot_de_passe>
```
