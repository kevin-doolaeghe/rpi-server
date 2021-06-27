# Clavier

Par défaut, le clavier est paramétré en configuration QWERTY.  
Il faut modifier le fichier `/etc/default/keyboard` pour passer le clavier en configuration AZERTY.

* Editer le fichier `/etc/default/keyboard` :

```shell
sudo nano /etc/default/keyboard
```

* Remplacer le contenu du fichier par le suivant :

```shell
XKBMODEL="pc105"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
```