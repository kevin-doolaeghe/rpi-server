# LAMP - Serveur Web

1. Apache
2. PHP
3. SQL
4. Tomcat

# 1. Apache

## Installation du package `apache2` :

```shell
sudo apt install apache2
```

## Configuration de `apache2` :

* Configuration globale :
    * La configuration de `apache2` se trouve dans le fichier `/etc/apache2/apache2.conf`
    * La configuration du démon `httpd` se trouve dans le fichier `/etc/apache2/httpd.conf`
    * La configuration des ports d'écoute de `apache2` se trouve dans le fichier `/etc/apache2/ports.conf`
* Configuration des sites :
    * Le répertoire `/etc/apache2/sites-available` contient les fichiers de configuration des sites disponibles
    * Le répertoire `/etc/apache2/sites-enabled` contient les liens symboliques des configurations des sites activés
* Configuration des services :
    * Le répertoire `/etc/apache2/conf-available` contient les fichiers de configuration des services disponibles
    * Le répertoire `/etc/apache2/conf-enabled` contient les liens symboliques des configurations des services activés
* Configuration des modules :
    * Le répertoire `/etc/apache2/mods-available` contient les fichiers de configuration des modules disponibles
    * Le répertoire `/etc/apache2/mods-enabled` contient les liens symboliques des configurations des modules activés

## Générer les liens symboliques de `apache2` :

* Activer un site :

```shell
sudo a2ensite <site>
```

* Désactiver un site :

```shell
sudo a2dissite <site>
```

* Activer un service :

```shell
sudo a2enconf <conf>
```

* Désactiver un service :

```shell
sudo a2disconf <conf>
```

* Activer un module :

```shell
sudo a2enmod <mod>
```

* Désactiver un module :

```shell
sudo a2dismod <mod>
```

## Créer un site :

1. Créer le fichier de configuration du nouveau site à partir d'un template :

```shell
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/001-www.example.com.conf
```

2. Editer le fichier de configuration du nouveau site :

```shell
sudo nano /etc/apache2/sites-available/001-www.example.com.conf
```

3. Modifier le `VirtualHost` existant pour correspondre aux besoins :

```shell
<VirtualHost *:80>
    ServerName www.example.com
    ServerAlias *.example.com
    ServerAdmin webmaster@example.com
    DocumentRoot /var/www/html/www.example.com

    CustomLog ${APACHE_LOG_DIR}/www.example.com-access.log combined
    ErrorLog ${APACHE_LOG_DIR}/www.example.com-error.log

    <Directory /var/www/html/www.example.com>
        Options All
        AllowOverride None
    </Directory>
</VirtualHost>
```

4. Créer le répertoire du site :

```shell
sudo mkdir /var/www/html/www.example.com/
sudo cp /var/www/html/index.html /var/www/html/www.example.com
```

5. Activer le site :

```shell
sudo a2ensite 001-www.example.com
```

6. Redémarrer le service `apache2` :

```shell
systemctl reload apache2
```

Il faut ajouter le nom de domaine du site sur le client

```shell
sudo nano /etc/hosts
192.168.1.10 www.example.com
```

## Sécurité :

1. Editer le fichier `/etc/apache2/conf-available/security.conf` :

```shell
sudo nano /etc/apache2/conf-available/security.conf
```

2. Modifier les clés suivantes :

```shell
ServerTokens Prod
ServerSignature Off
```

3. Redémarrer le service `apache2` :

```shell
sudo systemctl reload apache2
```

## Restriction d'accès :

Cette partie décrit comment restreindre l'accès au repertoire `private` du site créé précédemment.

1. Editer le fichier de configuration du site concerné :

```shell
sudo nano /etc/apache2/sites-enabled/001-www.example.com.conf
```

2. Ajouter la section suivante dans la partie `VirtualHost` :

```shell
<Directory /var/www/html/www.example.com/private>
    AuthType Basic
    AuthName “Accès restreint aux utilisateurs authentifiés”
    AuthBasicProvider file
    AuthUserFile “/etc/apache2/passwords”
    Require ip 192.168.1.200
    Require valid-user
</Directory>
```

## Activer HTTPS :

Cette partie décrit comment utiliser le protocole HTTPS pour le site créé précédemment.

1. Générer une clé et des certificats SSL avec `OpenSSL` :

```shell
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
```

2. Activer le module `ssl` :

```shell
sudo a2enmod ssl
```

3. Remplacer le fichier de configuration précédent par celui de l'exemple fourni :

```shell
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/001-www.example.com.conf
```

4. Editer le fichier de configuration du nouveau site :

```shell
sudo nano /etc/apache2/sites-available/001-www.example.com.conf
```

5. Modifier à nouveau le fichier de configuration pour convenur aux besoins

```shell
<IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerName www.example.com
        ServerAlias *.example.com
        ServerAdmin webmaster@example.com
        DocumentRoot /var/www/html/www.example.com

        <Directory /var/www/html/www.example.com>
            Options All
            AllowOverride None
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        SSLEngine on

        SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
        SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>

        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>
    </VirtualHost>
</IfModule>
```

6. Activer le site :

```shell
sudo a2ensite 001-www.example.com
```

7. Redémarrer le service `apache2` :

```shell
systemctl reload apache2
```

## Rediriger la configuration HTTP vers la configuration HTTPS

1. Activer le module de réécriture :

```shell
sudo a2enmod rewrite
```

2. Modifier le `VirtualHost` avec le module de réécriture :

```shell
<VirtualHost *:80>
    ServerName www.example.com
    ServerAlias *.example.com
    ServerAdmin webmaster@example.com

    <IfModule mod_rewrite.c>
        RewriteEngine On
        RewriteCond %{HTTPS} !=on
        RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,QSA,R=permanent]
    </IfModule>
</Virtualhost>
```

## Ajouter un mot de passe :

```shell
sudo htpasswd -c /etc/apache2/passwords <user>
```

# 2. PHP

## Installer `php` :

```shell
sudo apt-get install php libapache2-mod-php
```

## Vérifier l'installation de `php` :

1. Renommer le fichier `index.html` en `index.php`

```shell
sudo mv /var/www/html/index.html /var/www/html/index.php
```

2. Modifier le fichier renommé :

```shell
sudo nano /var/www/html/index.php
```

3. Ajouter le contenu suivant au fichier :

```shell
<?php
    phpinfo();
?>
```

## Configuration :

Le répertoire de configuration de `php` est le suivant :

```shell
/etc/php/
```

# 3. SQL

## Installer `mysql` ou `mariadb` :

```shell
sudo apt-get install mysql-server
sudo apt-get install mariadb-server
```

## Configuration de `mysql` :

```shell
sudo mysql_secure_installation
```

## Connexion au serveur `mysql` :

```shell
mysql -h localhost -u root -p
```

## Fichier de configuration de `mysql` :

```shell
/etc/mysql/mysql.conf.d/mysqld.cnf
```

## Installer `phpmyadmin` :

```shell
sudo apt install phpmyadmin
```

# 4. Tomcat

## Installer `tomcat` :

```shell
sudo apt install tomcat9
```

## Configurer `tomcat` :

La configuration de Tomcat se situe dans le répertoire de `/etc/tomcat9/`.

1. Arrêter le service `tomcat` :

```shell
sudo systemctl stop tomcat9
```

2. Editer le fichier de cofiguration des utilisateurs de Tomcat :

```shell
sudo nano /etc/tomcat9/tomcat-users.xml
```

3. Ajouter la ligne suivante dans la section `tomcat-users` :

```shell
<tomcat-users ...>
    <user username=”admin” password=”password” roles=”manager-gui,admin-gui” />
</tomcat-users>
```

### Installer le module d'administration de Tomcat :

```shell
sudo apt-get install tomcat9-admin
```

### Restreindre l'accès à des adresses IP

1. Editer le fichier suivant :

```shell
sudo nano /etc/tomcat8/Catalina/manager.xml
```

2. Modifier le fichier de la façon suivante :

```shell
<Context path="/manager"
   docBase="/usr/share/tomcat9-admin/manager"
   antiResourceLocking="false" privileged="true">
   <Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="192.168.1.101" />
</Context>
```

3. Redémarrer le service `tomcat` :

```shell
sudo systemctl start tomcat9
```
