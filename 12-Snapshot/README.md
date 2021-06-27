# Snapshot - Sauvegardes

Les sauvegardes peuvent être effectuées à partir de scripts shell.

## Ajout d'un script de sauvegarde

* Créer et éditer le fichier suivant :

```shell
sudo nano /usr/local/bin/backup.sh
```

* Ajouter le script ci-dessous au fichier :

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

* Sauvegarder & quitter le fichier

* Donner les droits d'exécution au script :

```shell
sudo chmod u+x /usr/local/bin/backup.sh
```

* Lancer le script :

```shell
sudo /usr/local/bin/backup.sh
```

## Automatisation de l'exécution du script avec l'utilitaire `cron`

* Modifier le fichier de configuration de `cron` :

```shell
sudo nano /etc/crontab
```

* Ajouter une entrée au fichier pour planifier l'exécution du script :

```shell
# m h dom mon dow   command
0 0 * * * bash /usr/local/bin/backup.sh
```

* Exécuter le script avec `cron` :

```shell
sudo crontab -e
```
