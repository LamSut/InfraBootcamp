Import-Module WebAdministration

if (-Not (Test-Path "C:\inetpub\limdotnet")) {
    New-Item -Path "C:\inetpub\limdotnet" -ItemType Directory
}

if (-Not (Test-Path "IIS:\AppPools\LimDotNet")) {
    New-WebAppPool -Name "LimDotNet"
}

if (-Not (Get-Website -Name "LimDotNet" -ErrorAction SilentlyContinue)) {
    New-Website -Name "LimDotNet" -Port 80 -HostHeader "limdotnet.local" -PhysicalPath "C:\inetpub\limdotnet" -ApplicationPool "LimDotNet"
}

# Publish ASP.NET Core application with Visual Studio
