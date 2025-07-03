powershell -ExecutionPolicy Bypass -File .\setup\lim1.ps1
powershell -ExecutionPolicy Bypass -File .\setup\lim2.ps1
powershell -ExecutionPolicy Bypass -File .\setup\limdotnet.ps1

Copy-Item "..\lim1.html" "C:\inetpub\lim1\lim1.html" -Force
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value='lim1.html'} -location "Lim1"

Copy-Item "..\lim2.html" "C:\inetpub\lim2\lim2.html" -Force
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value='lim2.html'} -location "Lim2"

