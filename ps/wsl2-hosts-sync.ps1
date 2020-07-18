# Requires -RunAsAdministrator
# Only works for WSL v2,  this is completely not needed for WSL v1 where u always can use 127.0.0.1 in hosts file

Clear-Host

if ((Get-InstalledModule "Carbon" -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module -Name 'Carbon' -AllowClobber
}

Import-Module 'Carbon'

$wslIp = (wsl -- ip route get 1 `| sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')

Write-Host "Setting wsl v2 hosts entries to $wslIp"

$domains = @(
    'wsl2.local'
    # add more domains if necessary
)

foreach($domain in $domains) {
    Set-HostsEntry -IPAddress $wslIp -HostName $domain
}

Write-Host "Done!"