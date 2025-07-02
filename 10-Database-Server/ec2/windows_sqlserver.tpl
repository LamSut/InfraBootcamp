<powershell>

# Set registry to enable SQL Server authentication (Mixed Mode)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQLServer" -Name LoginMode -Value 2

# Restart all SQL services
Get-Service | Where-Object { $_.Name -like "MSSQL*" } | ForEach-Object {
    Restart-Service $_.Name -Force
}

# Set SA password and enable login
& sqlcmd -S localhost -Q "ALTER LOGIN sa WITH PASSWORD = 'Limroot@12345678'; ALTER LOGIN sa ENABLE;"

# Create db
$sqlCreateDb = @"
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'limdb')
BEGIN
    CREATE DATABASE limdb;
END;
"@
$sqlCreateDb | sqlcmd -S localhost -U sa -P 'Limroot@12345678'

Start-Sleep -Seconds 5

# Create user & table 
$sqlInit = @"
USE limdb;
IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'limtruong')
BEGIN
    CREATE LOGIN limtruong WITH PASSWORD = 'Limuser@12345678';
    CREATE USER limtruong FOR LOGIN limtruong;
    ALTER ROLE db_owner ADD MEMBER limtruong;
END;
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='test' AND xtype='U')
BEGIN
    CREATE TABLE test (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(100),
        email NVARCHAR(100),
        created_at DATETIME DEFAULT GETDATE()
    );
END;
"@
$sqlInit | sqlcmd -S localhost -U sa -P 'Limroot@12345678'

# Insert random data
for ($i = 1; $i -le 50; $i++) {
    $name = -join ((65..90) + (97..122) | Get-Random -Count 10 | ForEach-Object {[char]$_})
    $email = (-join ((97..122) | Get-Random -Count 7 | ForEach-Object {[char]$_})) + "@lamsutdeptraivcl.com"
    $insert = "INSERT INTO limdb.dbo.test (name, email) VALUES (N'$name', N'$email');"
    $insert | sqlcmd -S localhost -U limtruong -P 'Limuser@12345678'
}

# Script backup db
$backupScript = @"
sqlcmd -S localhost -U sa -P 'Limroot@12345678' -Q "BACKUP DATABASE limdb TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\limdb.bak' WITH INIT"
"@
Set-Content -Path "C:\backup.ps1" -Value $backupScript

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"C:\backup.ps1`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) `
  -RepetitionInterval (New-TimeSpan -Minutes 1) `
  -RepetitionDuration ([TimeSpan]::FromDays(365))
Register-ScheduledTask -TaskName "SQLBackupTask" -Action $action -Trigger $trigger -RunLevel Highest -Force

</powershell>
