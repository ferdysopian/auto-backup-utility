# Auto Backup Utility

An automated utility script for performing weekly backups of a specific directory and MySQL databases. This script supports conditional backup of either all databases or a specified database, and uploads the backups to Dropbox using [Dropbox-Uploader](https://github.com/andreafabrizi/Dropbox-Uploader).

## Features

- Backs up a specific directory.
- Backs up MySQL databases.
  - If `DB_NAME` is set, only the specified database is backed up.
  - If `DB_NAME` is not set, all databases are backed up.
- Uploads backups to Dropbox using Dropbox-Uploader.
- Configurable via a separate configuration file.

## Requirements

- MySQL
- Dropbox-Uploader

## Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/ferdysopian/auto-backup-utility.git
    cd auto-backup-utility
    ```

2. Install Dropbox-Uploader:

    Follow the instructions at [Dropbox-Uploader](https://github.com/andreafabrizi/Dropbox-Uploader) to install and configure Dropbox-Uploader.

3. Create and configure the environment file:

    Create a file named `backup.conf` and add your configuration:

    ```bash
    BACKUP_DIR="/backup"
    TARGET_DIR="/path/to/your/directory"
    DB_NAME="" # Leave empty to backup all databases or set to a specific database name
    DB_USER="your_database_user"
    DB_PASSWORD="your_database_password"
    ```

4. Make the backup script executable:

    ```bash
    chmod +x /path/to/backup_script.sh
    ```

5. Schedule the script to run weekly using cron:

    Edit your cron jobs:

    ```bash
    crontab -e
    ```

    Add the following line to schedule the script to run weekly at 2 AM on Sundays:

    ```bash
    0 2 * * 0 /path/to/backup_script.sh
    ```

## Usage

- Ensure the script and configuration file are correctly set up.
- The script will automatically create backups of the specified directory and the specified or all MySQL databases.
- Backups will be uploaded to Dropbox using Dropbox-Uploader.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



This project utilizes [Dropbox-Uploader](https://github.com/andreafabrizi/Dropbox-Uploader).
