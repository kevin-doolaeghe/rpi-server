# Snapshot - Sauvegardes

Les sauvegardes peuvent être effectuées à partir de scripts shell.

## Ajout d'un script de sauvegarde

1. Créer et éditer le fichier suivant :

```shell
sudo nano /usr/local/bin/backup.sh
```

2. Ajouter le script ci-dessous au fichier :

```bash
#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/home /var/spool/mail /etc /root /boot /opt"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tar.gz"

# Print start status message.
date
echo "Backing up $backup_files to $dest/$archive_file"
echo

# Backup the files using tar.
tar -czvf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
```

3. Sauvegarder & quitter le fichier

4. Donner les droits d'exécution au script :

```shell
sudo chmod u+x /usr/local/bin/backup.sh
```

5. Lancer le script :

```shell
sudo /usr/local/bin/backup.sh
```

## Automatisation de l'exécution du script

### Utilitaire de planification des tâches `cron`

* Installation de l'utilitaire :

```
sudo apt install cron
```

* Afficher le contenu du fichier `crontab` :

```
crontab -l
```

* Supprimer toutes les actions du fichier `crontab` :

```
crontab -r
```

* Editer les actions du fichier `crontab` :

```
crontab -e
```

* Le fichier de configuration de `cron` est `/etc/crontab`.

### Automatiser l'appel du script de sauvegarde avec `cron`

1. Ajouter une action au fichier `crontab` :

```shell
sudo crontab -e
```

2. Ajouter une entrée au fichier pour planifier l'exécution du script :

```shell
# m h dom mon dow   command
0 0 * * * bash /usr/local/bin/backup.sh
```

3. Sauvegarder et quitter le fichier
