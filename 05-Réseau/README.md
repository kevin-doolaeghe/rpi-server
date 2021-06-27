# Réseau

## Package à installer pour utiliser la commande `ifconfig`

```shell
sudo apt install net-tools
```

## Afficher la configuration IP

* Méthode n°1 :

```shell
ip -a
```

* Méthode n°2 :

```shell
ifconfig
```

## Gérer le service réseau

* Méthode n°1 :

```shell
sudo /etc/init.d/networking.service <start|restart|stop|status|...>
```

* Méthode n°2 :

```shell
sudo systemctl <start|restart|stop|status|...> networking
```

* Méthode n°3 :

```shell
sudo service networking <start|restart|stop|status|...>
```

## Configuration IP

* Méthode n°1 :

1. Editer le fichier de configuration suivant :

```shell
sudo nano /etc/dhcpcd.conf
```

2. Ajouter une configuration comme indiqué dans l'exemple ci-dessous :

```shell
interface wlan0
static ip_address=192.168.1.10/24
static routers=192.168.1.254
static domain_name_servers=192.168.1.254
```

3. Sauvergarder et quitter le fichier

4. Redémarrer le service réseau :

```shell
sudo service networking restart
```

* Méthode n°2 : (Vielles versions)

1. Editer le fichier de configuration suivant :

```shell
sudo nano /etc/network/interfaces
```

2. Ajouter la configuration adéquate

3. Sauvergarder et quitter le fichier

4. Redémarrer le service réseau :

```shell
sudo service networking restart
```

* Méthode n°3 : (Sous Ubuntu 17.10+)

1. Editer le fichier de configuration `YAML` suivant :

```shell
sudo nano /etc/netplan/*.yaml
```

```shell
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: false
            dhcp6: false
            addresses: [192.168.1.200/24]
            gateway4: 192.168.1.254
            nameservers:
                addresses: [192.168.1.254, 8.8.8.8]
```

2. Générer la configuration :

```shell
netplan generate
```

3. Appliquer la configuration réseau :

```shell
netplan apply
```

* Méthode n°4 : (Via la commande IP)

```shell
ip addr <add|del> <address> dev <inteface>
```

## Configuration du Wi-Fi

1. Editer le fichier suivant :

```shell
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

2. Ajouter les paramètres Wi-Fi du réseau puis sauvergarder et quitter le fichier :

```shell
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR

network={
	ssid="ssid"
	psk="pass"
}
```

3. Redémarrer le service réseau :

```shell
sudo service networking restart
```

4. Activer le Wi-Fi si celui-ci était bloqué :

```
rfkill list all
sudo rfkill unblock all
```

## Configuration DNS

1. Editer le fichier suivant :

```shell
sudo nano /etc/resolv.conf
```

2. Ajouter les paramètres qui conviennent puis sauvergarder et quitter le fichier

3. Redémarrer le service réseau :

```shell
sudo service networking restart
```

Autre fichier de configuration du DNS :

```shell
sudo nano /etc/nsswitch.conf
```

## Commande `ip`

### Activer & désactiver les interfaces réseau :

* Méthode n°1 :

```shell
ip link set <interface> <up|down>
```

* Méthode n°2 :

```shell
<ifup|ifdown> <interface>
```

### Ajouter une interface virtuelle :

```shell
sudo ip link add <name> type dummy
```

### Routes :

```shell
ip route ...
```

### ARP :

```shell
ip neigh ...
```

### Ping :

```shell
ping <dest>
```

### Tracert :

```shell
traceroute <dest>
```
