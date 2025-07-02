Import-Module WebAdministration

if (-Not (Test-Path "C:\inetpub\lim1")) {
    New-Item -Path "C:\inetpub\lim1" -ItemType Directory
}

if (-Not (Test-Path "IIS:\AppPools\Lim1")) {
    New-WebAppPool -Name "Lim1"
}

if (-Not (Get-Website -Name "Lim1" -ErrorAction SilentlyContinue)) {
    New-Website -Name "Lim1" -Port 80 -HostHeader "lim1.local" -PhysicalPath "C:\inetpub\lim1" -ApplicationPool "Lim1"
}

Copy-Item ".\lim1.html" "C:\inetpub\lim1\lim1.html" -Force

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value='lim1.html'} -location "Lim1"
