$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = '$URL' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64    = '$CHECKSUM'

Install-ChocolateyZipPackage -PackageName $name -UnzipLocation $toolsDir -Url64bit $url64 -Checksum64 $checksum64
