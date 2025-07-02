#!/bin/bash

# # Install SQL Server and tools
# curl -O https://packages.microsoft.com/config/rhel/9/prod.repo
# sudo mv prod.repo /etc/yum.repos.d/mssql-server.repo
# sudo dnf clean all -y
# sudo dnf makecache -y

# sudo dnf install -y mssql-server
# sudo systemctl enable mssql-server
# sudo systemctl start mssql-server

# # Set SA password and edition
# sudo /opt/mssql/bin/mssql-conf setup accept-eula
# sudo /opt/mssql/bin/mssql-conf set-sa-password 'Limroot@12345678'
# sudo /opt/mssql/bin/mssql-conf set telemetry.customerfeedback false
# sudo systemctl restart mssql-server
# sleep 30

# # Install SQL Server command-line tools
# sudo dnf install -y unixODBC-devel
# sudo dnf install -y https://packages.microsoft.com/config/rhel/9/packages-microsoft-prod.rpm
# sudo dnf install -y mssql-tools18

# echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
# source ~/.bashrc

# # Create SQL Server using root
# /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'Limroot@12345678' -Q "
# CREATE DATABASE limdb;
# GO
# USE limdb;
# CREATE LOGIN limtruong WITH PASSWORD = 'Limuser@12345678';
# CREATE USER limtruong FOR LOGIN limtruong;
# ALTER ROLE db_owner ADD MEMBER limtruong;
# "

# # Create table & insert data
# insert="/tmp/insert.sql"
# echo "USE limdb;
# IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='test' AND xtype='U')
# BEGIN
#   CREATE TABLE test (
#     id INT IDENTITY(1,1) PRIMARY KEY,
#     name NVARCHAR(100),
#     email NVARCHAR(100),
#     created_at DATETIME DEFAULT GETDATE()
#   );
# END
# " > $insert

# for i in $(seq 1 50); do
#   name=$(cat /dev/urandom | tr -dc A-Za-z | head -c 10)
#   email="$(cat /dev/urandom | tr -dc a-z | head -c 7)@lamsutdeptraivcl.com"
#   echo "INSERT INTO test (name, email) VALUES (N'$name', N'$email');" >> $insert
# done

# /opt/mssql-tools18/bin/sqlcmd -S localhost -U limtruong -P 'Limuser@12345678' -i $insert

# # Backup script
# echo "#!/bin/bash
# /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'Limroot@12345678' -Q \"BACKUP DATABASE limdb TO DISK = '/home/ec2-user/backup.bak' WITH INIT\"
# " > /home/ec2-user/backup.sh

# sudo chmod +x /home/ec2-user/backup.sh

# # Cron job every minute
# echo "* * * * * /home/ec2-user/backup.sh" | crontab -

# sudo systemctl enable crond
# sudo systemctl start crond
