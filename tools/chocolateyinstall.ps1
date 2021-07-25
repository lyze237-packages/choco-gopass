$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.12.7/gopass-1.12.7-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64    = '26819f17064bad84620f1c821f996a86'

Install-ChocolateyZipPackage -PackageName $name -UnzipLocation $toolsDir -Url64bit $url64 -Checksum64 $checksum64
