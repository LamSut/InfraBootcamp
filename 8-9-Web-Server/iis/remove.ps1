# For Microsoft Windows 11 Home

Import-Module WebAdministration

"Lim1", "Lim2", "LimDotNet" | ForEach-Object {
    if (Get-Website -Name $_ -ErrorAction SilentlyContinue) {
        Remove-Website -Name $_
    }
    if (Test-Path "IIS:\AppPools\$_") {
        Remove-WebAppPool -Name $_
    }
    $folder = "C:\inetpub\" + $_.ToLower()
    if (Test-Path $folder) {
        Remove-Item -Path $folder -Recurse -Force
    }
}
