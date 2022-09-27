$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.14.8/gopass-1.14.8-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64    = '4a53b2036ea55befa051bb00839b9fa5'

Install-ChocolateyZipPackage -PackageName $name -UnzipLocation $toolsDir -Url64bit $url64 -Checksum64 $checksum64
