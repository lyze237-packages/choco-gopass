To run the updater: `./update.ps1`

Or old school style, update `gopass.nuspec` and `tools/chocolateyinstall.ps1`

Then run;
* choco pack
* choco uninstall gopass
* choco install gopass -s .
* choco push packageName.nupkg -s https://push.chocolatey.org/

https://emn178.github.io/online-tools/md5_checksum.html