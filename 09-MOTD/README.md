# MOTD - Message Of The Day

Le fichier `/etc/motd` contient le message de base à la connexion d'un utilisateur.

1. Supprimer le contenu du fichier `/etc/motd` :

```
cat /dev/null > /etc/motd
```

Le répertoire `/etc/update-motd.d` contient les fichiers MOTD ou leur lien symbolique.  
Ces fichiers sont lus au démarrage d'une session depuis l'introduction du package `update-motd`.

2. Créer le fichier `sysinfo.sh` :

```
sudo nano /usr/local/bin/sysinfo.sh
```

3. Ajouter le script ci-dessous au fichier :

```bash
#!/bin/sh

upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

# weather stations are available here: https://pastebin.com/dbtemx5F

echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %r"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
( : '~'.~.'~' : ) Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Running Processes..: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   IP Addresses.......: `ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/` and `wget -q -O - http://icanhazip.com/ | tail`
   '~ .~~~. ~'    Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|FR|FR017|LILLE" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
       '~'
$(tput sgr0)"
```

4. Donner les droits d'exécution au script :

```
sudo chmod +x /usr/local/bin/sysinfo.sh
```

5. Créer le lien symbolique du script vers le répertoire `/etc/update-motd.d` :

```
sudo ln -s /usr/local/bin/sysinfo.sh /etc/update-motd.d/20-sysinfo
```
