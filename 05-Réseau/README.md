# Réseau

## Package à installer pour utiliser la commande `ifconfig`

```shell
sudo apt install net-tools
```

## Afficher la configuration IP

### Méthode n°1 :

```shell
ip -a
```
Note : Utiliser le tuyau `| more` pour afficher les interfaces page par page.

### Méthode n°2 :

```shell
ifconfig
```

## Gérer le service réseau

### Méthode n°1 :

```shell
sudo /etc/init.d/networking.service <start|restart|stop|status|...>
```

### Méthode n°2 :

```shell
sudo systemctl <start|restart|stop|status|...> networking
```

### Méthode n°3 :

```shell
sudo service networking <start|restart|stop|status|...>
```

## Configuration IP

### Méthode n°1 :

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

### Méthode n°2 : (via le service `networking`, anciennes versions)

1. Editer le fichier de configuration suivant :

```shell
sudo nano /etc/network/interfaces
```

2. Ajouter la configuration adéquate

```
auto eth0
iface eth0 inet static
	address 192.168.1.10/24
	gateway 192.168.1.254
```

3. Sauvergarder et quitter le fichier

4. Redémarrer le service réseau :

```shell
sudo service networking restart
```

### Méthode n°3 : (via `netplan`, à partir de Ubuntu 17.10+)

1. Editer le fichier de configuration `YAML` suivant :

```shell
sudo nano /etc/netplan/*.yaml
```

2. Ajouter la configuration adéquate

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

3. Générer la configuration :

```shell
netplan generate
```

4. Appliquer la configuration réseau :

```shell
netplan apply
```

### Méthode n°4 : (via la commande `ip`)

```shell
ip addr <add|del> <address> dev <inteface>
```

### Méthode n°5 : (via le service `NetworkManager`)

1. Activer le service `NetworkManager` :
```shell
sudo systemctl enable NetworkManager
```

2. Afficher les adaptateurs réseau :
```shell
nmcli connection show
```

3. Configurer l'adaptateur dont le nom est `Wired connection 1` :
```shell
sudo nmcli con modify "Wired connection 1" ipv4.addresses 10.0.0.252/24
sudo nmcli con modify "Wired connection 1" ipv4.gateway 10.0.0.254
sudo nmcli con modify "Wired connection 1" ipv4.dns "10.0.0.254 8.8.8.8"
sudo nmcli con modify "Wired connection 1" ipv4.method manual
```

4. Appliquer la configuration :
```shell
sudo nmcli connection up "Wired connection 1"
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

5. Activer manuellement la configuration de `wpa_supplicant` :
```
sudo killall wpa_supplicant
sudo wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0
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
