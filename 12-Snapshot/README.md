# Snapshot - Sauvegardes

Les sauvegardes peuvent être effectuées à partir de scripts shell.

Voici un exemple de script simple :

```shell
sudo nano /usr/local/bin/backup.sh
```

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
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
```

Pour exécuter le script, celui-ci doit être exécutable :

```shell
chmod u+x backup.sh
```

Le script se lance de la façon suivante :

```shell
sudo ./backup.sh
```

L'exécution du script peut être automatisée avec l'utilitaire `cron` :

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