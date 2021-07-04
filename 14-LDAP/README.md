# LDAP

> LDAP (Lightweight Directory Access Protocol) est un protocole utilisé pour l'authentification des services d'annuaire.
> 
> AD (Active Directory) est une implémentation des services d’annuaire qui permet l’authentification et la gestion des groupes et des utilisateurs.
> 
> **LDAP est un moyen de communiquer avec Active Directory.**

## Installation du serveur LDAP

1. Installer les paquets suivants :

```
sudo apt install slapd ldap-utils
```

2. Configurer l'arborescence DIT (Directory Information Tree)

```
sudo dpkg-reconfigure slapd
```

Le processus d'installation met en place un DIT pour `slapd-config` et un autre pour les données personnelles.

L'arborescence DIT de `slapd-config` est la suivante :

```
/etc/ldap/slapd.d/
/etc/ldap/slapd.d/cn=config.ldif
/etc/ldap/slapd.d/cn=config
/etc/ldap/slapd.d/cn=config/cn=schema
/etc/ldap/slapd.d/cn=config/cn=schema/cn={1}cosine.ldif
/etc/ldap/slapd.d/cn=config/cn=schema/cn={0}core.ldif
/etc/ldap/slapd.d/cn=config/cn=schema/cn={2}nis.ldif
/etc/ldap/slapd.d/cn=config/cn=schema/cn={3}inetorgperson.ldif
/etc/ldap/slapd.d/cn=config/cn=module{0}.ldif
/etc/ldap/slapd.d/cn=config/olcDatabase={0}config.ldif
/etc/ldap/slapd.d/cn=config/olcDatabase={-1}frontend.ldif
/etc/ldap/slapd.d/cn=config/olcDatabase={1}mdb.ldif
/etc/ldap/slapd.d/cn=config/olcBackend={0}mdb.ldif
/etc/ldap/slapd.d/cn=config/cn=schema.ldif
```

## Configurer LDAP pour fonctionner avec Samba

1. Installer les paquets nécessaires :

```
sudo apt install samba smbldap-tools
```

2. Importer un schéma LDAP pour Samba : 

```
zcat /usr/share/doc/samba/examples/LDAP/samba.ldif.gz | sudo ldapadd -Q -Y EXTERNAL -H ldapi:///
```

Vérifier la prise en compte du nouveau schéma :

```
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config 'cn=*samba*'
```

3. Créer le fichier de configuration `samba_indices.ldif`

4. Ajouter le contenu suivant au fichier :

```
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcDbIndex
olcDbIndex: objectClass eq
olcDbIndex: uidNumber,gidNumber eq
olcDbIndex: loginShell eq
olcDbIndex: uid,cn eq,sub
olcDbIndex: memberUid eq,sub
olcDbIndex: member,uniqueMember eq
olcDbIndex: sambaSID eq
olcDbIndex: sambaPrimaryGroupSID eq
olcDbIndex: sambaGroupType eq
olcDbIndex: sambaSIDList eq
olcDbIndex: sambaDomainName eq
olcDbIndex: default sub,eq
```

5. Ajouter les nouveaux indices :

```
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f samba_indices.ldif
```

Vérifier la prise en compte des nouveaux indices :

```
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config olcDatabase={1}mdb olcDbIndex
```

7. Configurer LDAP pour Samba :

```
sudo smbldap-config
```

8. Créer un backup de la configuration LDAP

```
sudo slapcat -l backup.ldif
```

9. Ajouter des objets à la base de données LDAP :

```
sudo smbldap-populate -g 10000 -u 10000 -r 10000
```

10. Configuration de Samba (fichier `smb.cobf`) :

```
#  passdb backend = tdbsam
   workgroup = EXAMPLE

# LDAP Settings
   passdb backend = ldapsam:ldap://hostname
   ldap suffix = dc=example,dc=com
   ldap user suffix = ou=People
   ldap group suffix = ou=Groups
   ldap machine suffix = ou=Computers
   ldap idmap suffix = ou=Idmap
   ldap admin dn = cn=admin,dc=example,dc=com
   # or off if TLS/SSL is not configured
   ldap ssl = start tls
   ldap passwd sync = yes
```

11. Changer le mot de passe administrateur :

```
sudo smbpasswd -W
```
