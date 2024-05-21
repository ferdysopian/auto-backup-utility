#!/bin/bash

# Set the path of this script
SCRIPT_PATH=$(dirname $(realpath $0))
CONFIG_FILE=$SCRIPT_PATH/backup.conf
DROPBOX_UPLOADER_PATH=$SCRIPT_PATH/dropbox_uploader.sh

# Load configuration
source $CONFIG_FILE

# Define the date format
DATE=$(date +%F)

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup /var/www directory
tar -czf $BACKUP_DIR/www-backup-$DATE.tar.gz $WWW_DIR

# Upload backups to Dropbox
$DROPBOX_UPLOADER_PATH upload $BACKUP_DIR/www-backup-$DATE.tar.gz /backups/

# Function to backup and upload a database
backup_and_upload_db() {
    local db=$1
    mysqldump -u $DB_USER -p$DB_PASSWORD $db > $BACKUP_DIR/${db}-backup-$DATE.sql
    gzip $BACKUP_DIR/${db}-backup-$DATE.sql
    $DROPBOX_UPLOADER_PATH upload $BACKUP_DIR/${db}-backup-$DATE.sql.gz /backups/
    rm $BACKUP_DIR/${db}-backup-$DATE.sql.gz
}

# Check if a specific database name is set
if [ -z "$DB_NAME" ]; then
    # Backup all databases
    DBS=$(mysql -u$DB_USER -p$DB_PASSWORD -e 'SHOW DATABASES;' | grep -Ev '(Database|information_schema|performance_schema|mysql|sys)')
    for DB in $DBS; do
        backup_and_upload_db $DB
    done
else
    # Backup the specified database
    backup_and_upload_db $DB_NAME
fi

# Remove local backup files
rm $BACKUP_DIR/www-backup-$DATE.tar.gz

echo "Backup and upload completed successfully."

# Schedule this script to run weekly using cron:
# Run 'crontab -e' and add the following line:
# 0 2 * * 0 /path/to/backup_script.sh
