$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.8.5/gopass-1.8.5-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64    = 'AD662686BC0FB3F514F73E0A79E343EE'

Install-ChocolateyZipPackage -PackageName $name -UnzipLocation $toolsDir -Url64bit $url64 -Checksum64 $checksum64
