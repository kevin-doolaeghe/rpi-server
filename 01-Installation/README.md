# Installation

## Méthode n°1: Balena Etcher

1. Télécharger le logiciel Balena Etcher et l'image ISO de Raspberry Pi OS
2. Installer puis démarrer Etcher
3. Sélectionner le lecteur d'installation et l'image ISO précédemment télechargée puis lancer l'installation
4. Connecter le lecteur au Raspberry Pi
5. Démarrer le Raspberry Pi

## Méthode n°2: Raspberry Pi Imager

1. Télécharger le logiciel Raspberry Pi Imager
2. Installer et lancer le logiciel
3. Choisir le lecteur d'installation et l'image de Raspberry Pi OS adéquate puis lancer l'installation
4. Il est possible d'utiliser le raccourci `Ctrl`+`Shift`+`X` pour activer différentes options
4. Connecter le lecteur au Raspberry Pi
5. Démarrer le Raspberry Pi

# Démarrer automatiquement sur un périphérique USB

- Mettre à jour le bootloader du Raspberry Pi
- Changer le boot order
- Installer Raspberry Pi OS sur un SSD (ou HDD)
- Démarrer le Raspberry Pi

**:warning: Cette opération n'est pas nécessaire si le bootloader est déjà à jour :warning:**

## Méthode :

1. Installer Raspberry Pi OS Lite sur une carte micro-SD et un SSD (ou HDD) à l'aide du logiciel Raspberry Pi Imager

2. Utiliser le raccourci `Ctrl`+`Shift`+`X` sur le logiciel Raspberry Pi Imager pour configurer :
    * La connexion au réseau Wi-Fi,
    * La disposition du clavier

3. Démarrer le Raspberry Pi à l'aide de la carte micro-SD et se connecter à l'aide des identifiants par défaut :

```
user: pi
pass: raspberry
```

4. Mettre à jour le système :

```
sudo apt update && sudo apt full-upgrade -y
```

5. Mettre à jour le firmware :

```
sudo rpi-update
```

6. Redémarrer le système :

```
sudo reboot
```

7. Mettre à jour le bootloader :

```shell
sudo rpi-eeprom-update -d -a
```

8. Configurer l'ordre de démarrage :

```
sudo raspi-config
```

* Choisir la section `Advanced Options`

* Sélectionner la section `Boot ROM Version`

* Choisir la version `latest`

* Répondre `No` à la question `Reset boot ROM to defaults?`

* Sélection la section `Boot Order`

* Sélectionner le choix `USB Boot` pour l'ordre de démarrage

* Valider les modifications en sélectionnant `Finish`

* Répondre `No` à la question `Would you like to reboot now?`

9. Eteindre le système :

```
sudo halt
```

10. Déconnecter la carte micro-SD puis connecter le SSD (ou HDD)

11. Démarrer le Raspberry Pi pour correctement démarrer sur le SSD (ou HDD)
