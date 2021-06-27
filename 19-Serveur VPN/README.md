# VPN

## Installation du serveur `openvpn`

```shell
sudo apt install openvpn easy-rsa
```

## Configuration d'une infrastructure à clés publiques (PKI)

```shell
mkdir /etc/openvpn/easy-rsa/
cp -r /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/
```

## Modifier le fichier suivant

```shell
sudo nano /etc/share/easy-rsa/vars
```

## Ajuster les valeurs pour l'environnement d'utilisation du VPN

```shell
export KEY_COUNTRY="US"
export KEY_PROVINCE="NC"
export KEY_CITY="Winston-Salem"
export KEY_ORG="Example Company"
export KEY_EMAIL="steve@example.com"
export KEY_CN=MyVPN
export KEY_NAME=MyVPN
export KEY_OU=MyVPN
```

## Générer le certificat maître Certificate Authority (CA) et une clé:

```shell
cd /etc/openvpn/easy-rsa/source vars
./clean-all
./build-ca
```

## Génération d'un certificat et d'une clé privée pour le serveur

```shell
./build-key-server [server name]
./build-dh
```