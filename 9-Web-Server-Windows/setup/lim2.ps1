Import-Module WebAdministration

if (-Not (Test-Path "C:\inetpub\lim2")) {
    New-Item -Path "C:\inetpub\lim2" -ItemType Directory
}

if (-Not (Test-Path "IIS:\AppPools\Lim2")) {
    New-WebAppPool -Name "Lim2"
}

if (-Not (Get-Website -Name "Lim2" -ErrorAction SilentlyContinue)) {
    New-Website -Name "Lim2" -Port 80 -HostHeader "lim2.local" -PhysicalPath "C:\inetpub\lim2" -ApplicationPool "Lim2"
}

Copy-Item ".\lim2.html" "C:\inetpub\lim2\lim2.html" -Force

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value='lim2.html'} -location "Lim2"
