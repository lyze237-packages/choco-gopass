$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.15.0/gopass-1.15.0-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64    = 'c6f393bb51bf9a85a66a88d0b9b6ddd8'

Install-ChocolateyZipPackage -PackageName $name -UnzipLocation $toolsDir -Url64bit $url64 -Checksum64 $checksum64
