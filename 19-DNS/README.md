# DNS

## Paquets à installer:

```shell
sudo apt install bind9
sudo apt install dnsutils
```

## Fichier de configuration:

```shell
/etc/bind/named.conf
```

## Exemple de configuration

* Installation du paquet `bind9`
```
apt install bind9
```

* Modification du fichier `/etc/resolv.conf` :
```
nameserver 127.0.0.1
```

* Modification du fichier `/etc/bind/named.conf.local` :
```
zone "demineur.site" {
	type master;
file "/etc/bind/db.demineur.site";
allow-transfer { 10.0.0.254; };
};
```

* Modification du fichier `/etc/bind/named.conf.options` :
```
options{
  directory "/var/cache/bind";
  forwarders {
     10.0.0.254;
     8.8.8.8;
  };
  listen-on-v6 { any; };
  allow-transfer { "allowed_to_transfer"; };
};
acl "allowed_to_transfer" {
  10.0.0.254/32 ;
};
```

```
cp /etc/bind/db.local /etc/bind/db.demineur.site
```

* Modification du fichier `/etc/bind/db.demineur.site` :
```
;
; BIND data file for demineur.site
;
$TTL    604800
@       IN      SOA     demineur.site. root.demineur.site. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.demineur.site.
@       IN      A       10.0.20.1
@       IN      AAAA    ::1
ns      IN      A       10.0.20.1
www     IN      A       10.0.20.1
```

* Redémarrage du service `bind9` :
```
service bind9 restart
```

### Tester DNS :

* Ajout d'une redirection de ports (dans le cas d'une machine virtuelle) :
```
iptables -A PREROUTING -t nat -i wlo1 -p udp --dport 53 -j DNAT --to-destination 10.0.20.1:53
```

* Modification du fichier `/etc/resolv.conf`
```
nameserver 10.0.0.252
```

* Vérification de la traduction du nom de domaine `demineur.site` :
```
nslookup demineur.site
```
