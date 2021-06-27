# Firewall

## Installer le package `ufw` :

```shell
sudo apt install ufw
```

## Lister les applications soumises au pare-feu :

```shell
sudo ufw app list
```

## Autoriser/Refuser toutes les applications par défaut :

```shell
sudo ufw default <allow|deny>
```

## Bloquer toutes les connexions :

```shell
sudo ufw default deny incoming
sudo ufw default deny outgoing
```

## Autoriser & refuser une application ou un port :

```shell
sudo ufw <allow|deny> <app>
sudo ufw <allow|deny> <in|out> <port>/<tcp|udp>
```

## Activer & désactiver le pare-feu :

```shell
sudo ufw <enable|disable>
```

## Afficher le status du pare-feu :

```shell
sudo ufw status <verbose|numbered>
```

## Supprimer une règle :

```shell
sudo ufw delete <num>
```

## Activer la journalisation :

```shell
sudo ufw logging on
```

## Visualiser les services disponibles :

```shell
sudo cat /etc/services
```