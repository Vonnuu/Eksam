#!/bin/bash
#backup ja temp folderite jaoks
backup="/var/backups"
tempfold="/var/temp"
#andmebaasi andmed
db="db"
user="user"
passwd="Passw0rd"

#loob temp folderi
[ ! -d "$tempfold" ] && echo "Teen temp folderi: $tempfold" && mkdir -p "$tempfold" || echo "Temp folder olemas juba: $tempfold"

#teeb backup folderi
[ ! -d "$backup" ] && echo "Teen backup folderi: $backup" && mkdir -p "$backup" || echo "Backup folder olemas jub: $backup"

#Date time
dt=$(date +"%Y-%m-%d_%H-%M")

#dbi temp folderi yhendamine
dbtemp="$tempfold/varukoopia_${dt}.sql"
mysqldump -u "$user" -p"$passwd" "$db" > "$dbtemp"

gzip "$dbtemp"
mv "${dbtemp}.gz" "$backup/"

#backupide kustutamine(vanemad kui 7 päeva)
find "$backup" -name "*.gz" -type f -mtime +7 -exec rm -f {} \;

#cron läheb iga 2 tunni tagant käima
#0 */2 * * * /bin/bash /tee/skripti/asukoht/cronjob.bash
