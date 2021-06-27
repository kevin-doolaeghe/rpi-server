#SSH
ufw allow out 22/tcp
ufw allow in 22/tcp

#HTTP
ufw allow out 80/tcp
ufw allow out 53/udp
ufw allow out 443/tcp

#FTP
ufw allow out 20/tcp
ufw allow out 21/tcp

#SMTP
ufw allow out 25/tcp
#POP3
ufw allow out 110/tcp
#Secured POP3
ufw allow out 995/tcp
#IMAP2
ufw allow out 143/tcp
#IMAP3
ufw allow out 220/tcp

#SMB
ufw allow in 445/tcp
ufw allow out 445/tcp
ufw allow samba

#Apply
ufw disable && ufw enable

#Enable logging
ufw logging on