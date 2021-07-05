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

3. Ajouter un fichier `add_content.ldif` :

```
sudo nano add_content.ldif
```

4. Ajouter le contenu suivant au fichier :

```
dn: ou=People,dc=example,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Groups,dc=example,dc=com
objectClass: organizationalUnit
ou: Groups

dn: cn=administrators,ou=Groups,dc=example,dc=com
objectClass: posixGroup
cn: administrators
gidNumber: 5000

dn: uid=kevin,ou=People,dc=example,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: kevin
sn: Doolaeghe
givenName: Kevin
cn: Kevin Doolaeghe
displayName: Kevin Doolaeghe
uidNumber: 10000
gidNumber: 5000
userPassword: kevinldap
gecos: Kevin Doolaeghe
loginShell: /bin/bash
homeDirectory: /home/kevin
```

5. Ajouter le contenu au serveur LDAP :

```
ldapadd -x -D cn=admin,dc=example,dc=com -W -f add_content.ldif
```

Vérifier que l'utilisateur a bien été créé dans la base de données LDAP :

```
ldapsearch -x -LLL -b dc=example,dc=com 'uid=kevin' cn gidNumber
```

## Gestion des entrées LDAP

1. Installer le paquet `ldapscripts` :

```
sudo apt install ldapscripts
```

2. Editer le fichier `/etc/ldapscripts/ldapscripts.conf` :

```
sudo nano /etc/ldapscripts/ldapscripts.conf
```

3. Remplacer le contenu du fichier par le suivant :

```
SERVER=localhost
BINDDN='cn=admin,dc=example,dc=com'
BINDPWDFILE="/etc/ldapscripts/ldapscripts.passwd"
SUFFIX='dc=example,dc=com'
GSUFFIX='ou=Groups'
USUFFIX='ou=People'
MSUFFIX='ou=Computers'
GIDSTART=10000
UIDSTART=10000
MIDSTART=10000
```

4. Créer le fichier `ldapscripts.passwd` pour permettre l'accès de `root` au répertoire :

```
sudo sh -c "echo -n 'secret' > /etc/ldapscripts/ldapscripts.passwd"
sudo chmod 400 /etc/ldapscripts/ldapscripts.passwd
```

5. Ajouter un utilisateur :

```
sudo ldapadduser <utilisateur> <groupe>
```

6. Modifier le mot de passe de l'utilisateur :

```
sudo ldapsetpasswd <utilisateur>
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

12. Installer `libnss-ldap` :

```
sudo apt install libnss-ldap
```

13. Configurer le profile LDAP pour NSS :

```
sudo auth-client-config -t nss -p lac_ldap
```

14. Redémarrer le service Samba :

```
sudo systemctl restart smbd.service nmbd.service
```

Vérifier la configuration Samba :

```
getent group
```

```
...
Account Operators:*:548:
Print Operators:*:550:
Backup Operators:*:551:
Replicators:*:552:
```

## Gestion des utilisateurs LDAP pour Samba

* Ajout d'un utilisateur LDAP existant pour Samba :

```
sudo smbpasswd -a identifiant
```

* Supprimer un utilisateur LDAP pour Samba :

```
sudo smbldap-userdel identifiant
```

* Ajouter un groupe :

```
sudo smbldap-groupadd -a nom_de_groupe
```

* Attribuer un groupe à un utilisateur existant :

```
sudo smbldap-groupmod -m identifiant nom_de_groupe
```

* Supprimer un utilisateur d'un groupe :

```
sudo smbldap-groupmod -x identifiant nom_de_groupe
```

* Ajouter un compte machine :

```
sudo smbldap-useradd -t 0 -w nom_machine
```

## Ajout d'un nouvel utilisateur LDAP pour Samba

* Ajouter l'utilisateur `kevin` :

```
sudo smbldap-useradd -a -P -m kevin
```

* Changer le mot de passe :

```
getent passwd kevin
```
