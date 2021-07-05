# Mise à jour

## Mettre à jour Linux :

```shell
sudo apt update
sudo apt upgrade
```

```
sudo apt update && sudo apt full-upgrade -y
```

## Mettre à jour le firmware du Raspberry Pi :

```shell
sudo rpi-update
```

## Mettre à jour le bootloader du Raspberry Pi :

```shell
sudo rpi-eeprom-update -d -a
```

## Modifier la configuration du Raspberry Pi :

```shell
sudo raspi-config
```