@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)
chcp 65001 >nul
chcp 437 >nul
reg add "HKCU\Console" /v FaceName /t REG_SZ /d "Consolas" /f >nul
reg add "HKCU\Console" /v FontFamily /t REG_DWORD /d 0x36 /f >nul
reg add "HKCU\Console" /v FontSize /t REG_DWORD /d 0x00120000 /f >nul
setlocal enabledelayedexpansion
title Netpot
:main
mode con: cols=76 lines=25
cls
echo.
echo.
echo                    Inspired by [32mMassgrave[0m, made by [32mNoctua[0m
echo            ______________________________________________________
echo.
echo                    Check your network:
echo.
echo                [1] ipconfig    - IP information
echo                [2] netstat     - Active network connections
echo                [3] netsh       - Wi-Fi information
echo                [4] Network Configuration + Information
echo                [5] Network Connections / Sharing
echo                ____________________________________________
echo.
echo                [6] Extras
echo                [7] Help
echo                [0] Exit
echo            ______________________________________________________
echo.
set /p choice=[32m       Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 7, 0]: [0m
if "%choice%"=="1" goto ipconfig_menu
if "%choice%"=="2" goto netstat_menu
if "%choice%"=="3" goto check_wifi
if "%choice%"=="4" goto netconf_menu
if "%choice%"=="5" goto netconn_menu
if "%choice%"=="6" goto extras
if "%choice%"=="7" goto help
if "%choice%"=="0" exit
goto main

:check_wifi
sc query wlansvc | find "RUNNING" >nul
if not %errorlevel%==0 (
    goto no_wifi
)
netsh wlan show drivers | find "Wireless" >nul
if not %errorlevel%==0 (
    goto no_wifi
)
goto netsh_menu

:no_wifi
cls
echo.
echo.
echo            _______________________________________________
echo.
echo                Your PC doesn't support Wi-Fi yet.
echo            _______________________________________________
echo.
pause>nul
goto main

:ipconfig_menu
mode con: cols=76 lines=19
cls
echo.
echo.
echo            __________________________________________________________
echo.
echo                [2] /all          - Show detailed IP configuration
echo                [3] /release      - Release current IP address
echo                [4] /renew        - Renew IP address from DHCP
echo                [5] /flushdns     - Clear DNS cache
echo                [6] /displaydns   - View DNS cache
echo                __________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            __________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    ipconfig /all
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto ipconfig_menu
)
if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    ipconfig /release
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto ipconfig_menu
)
if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    ipconfig /renew
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto ipconfig_menu
)
if "%subchoice%"=="5" (
    mode con: cols=125 lines=25
    cls
    ipconfig /flushdns
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto ipconfig_menu
)
if "%subchoice%"=="6" (
    mode con: cols=125 lines=25
    cls
    ipconfig /displaydns
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto ipconfig_menu
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto ipconfig_menu

:netstat_menu
mode con: cols=76 lines=19
cls
echo.
echo.
echo            ___________________________________________________________
echo.
echo                [2] netstat     - Show active network connections
echo                [3] -ano        - Show connections with process IDs
echo                [4] -b          - Show which apps use which ports
echo                [5] -r          - Show routing table
echo                [6] -e          - Show Ethernet stats
echo                ___________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            ___________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    netstat
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netstat_menu
)
if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    netstat -ano
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netstat_menu
)
if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    netstat -b
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netstat_menu
)
if "%subchoice%"=="5" (
    mode con: cols=125 lines=25
    cls
    netstat -r
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netstat_menu
)
if "%subchoice%"=="6" (
    mode con: cols=125 lines=25
    cls
    netstat -e
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netstat_menu
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto netstat_menu

:netsh_menu
mode con: cols=105 lines=27
cls
echo.
echo.
echo            __________________________________________________________________________________
echo.
echo                [2] netsh wlan show profiles                - List saved Wi-Fi networks
echo                [3] wlan show profile Netpot key=clear      - Show Wi-Fi password
echo                [4] wlan show interfaces                    - Show Wi-Fi connection details
echo                [5] int ip reset                            - Reset TCP/IP stack
echo                [6] winsock reset                           - Reset Winsock catalog
echo                ___________________________________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            __________________________________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    netsh wlan show profiles
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netsh_menu
)
if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    netsh wlan show profile <name> key=clear
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netsh_menu
)
if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    netsh wlan show interfaces
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netsh_menu
)
if "%subchoice%"=="5" (
    mode con: cols=125 lines=25
    cls
    netsh int ip reset
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netsh_menu
)
if "%subchoice%"=="6" (
    mode con: cols=125 lines=25
    cls
    netsh winsock reset
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netsh_menu
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto netsh_menu

:netconf_menu
mode con: cols=115 lines=22
cls
echo.
echo.
echo            _____________________________________________________________________________________________
echo.
echo                [2] arp -a                                          - Show ARP table
echo                [3] getmac                                          - Display MAC addresses
echo                [4] hostname                                        - Show your computer’s hostname
echo                [5] route print                                     - Show routing table entries
echo                [6] nbtstat -n                                      - Show NetBIOS name table
echo                [7] systeminfo                                      - Display full system info
echo                [8] wmic nic get name,macaddress                    - Show network adapters and MACs
echo                [9] wmic nicconfig get ipaddress,description        - Show adapter IP info           
echo                _____________________________________________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            _____________________________________________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    arp -a
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    getmac
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    hostname   
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="5" (
    mode con: cols=125 lines=25
    cls
    route print   
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="6" (
    mode con: cols=125 lines=25
    cls
    nbtstat -n   
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="7" (
    mode con: cols=125 lines=25
    cls
    systeminfo    
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="8" (
    mode con: cols=125 lines=25
    cls
    wmic nic get name,macaddress 
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="9" (
    mode con: cols=125 lines=25
    cls
    wmic nicconfig get ipaddress,description
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconf_menu
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto netconf_menu

:netconn_menu
mode con: cols=86 lines=18
cls
echo.
echo.
echo            _________________________________________________________________
echo.
echo                [2] net use         - Connect to shared network resources
echo                [3] net view        - Show available network computers
echo                [4] net share       - Show shared folders on your system 
echo                _________________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            _________________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    net use
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconn_menu
)
if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    net view 
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconn_menu
)
if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    net share 
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto netconn_menu
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto netconn_menu

:extras
mode con: cols=89 lines=20  
cls
echo.
echo.
echo            ____________________________________________________________________
echo.
echo                    Extras:
echo.
echo                [2] ping (host)             - Test connectivity to a host
echo                [3] tracert (host)          - Trace route to a host
echo                [4] pathping (host)         - Trace and analyze network path
echo                [5] nslookup (domain)       - Get DNS info for a domain     
echo                ____________________________________________________________
echo.
echo                [1] Back
echo                [0] Exit
echo            ____________________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option in the keyboard [1, 2, 3, 4, 5, 0]: [0m
if "%subchoice%"=="2" (
    mode con: cols=125 lines=25
    cls
    echo [Ping]
    set /p host=Enter host: 
    ping %host%
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto extras
)

if "%subchoice%"=="3" (
    mode con: cols=125 lines=25
    cls
    echo [Tracert]
    set /p host=Enter host: 
    tracert %host%
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto extras
)

if "%subchoice%"=="4" (
    mode con: cols=125 lines=25
    cls
    echo [Pathping]
    set /p host=Enter host: 
    pathping %host%
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto extras
)

if "%subchoice%"=="5" (
    mode con: cols=125 lines=25
    cls
    echo [Nslookup]
    set /p domain=Enter host: 
    nslookup %domain%
    echo.
    powershell -NoProfile -Command "Write-Host 'Finished.' -ForegroundColor Green"
    pause >nul
    goto extras
)
if "%subchoice%"=="1" goto main
if "%subchoice%"=="0" exit
goto extras

:help
mode con: cols=95 lines=20
cls
echo.
echo.
echo            _________________________________________________________________
echo.
echo                    Help - Network Tool Overview:
echo.
echo                [1] IP Commands            - ipconfig related options
echo                [2] Network Status         - netstat related options
echo                [3] Wi-Fi Commands         - netsh related Wi-Fi info
echo                [4] Network Configuration  - arp, getmac, hostname, systeminfo
echo                [5] Connections/Sharing    - net use, net view, net share
echo                [6] Extras                 - ping, tracert, pathping, nslookup
echo                _________________________________________________________________
echo.
echo                [0] Back to Main Menu
echo            _________________________________________________________________
echo.
set /p subchoice=[32m           Enter a menu option [1, 2, 3, 4, 5, 6, 0]: [0m
if "%subchoice%"=="1" goto ipconfig_menu
if "%subchoice%"=="2" goto netstat_menu
if "%subchoice%"=="3" goto netsh_menu
if "%subchoice%"=="4" goto netconf_menu
if "%subchoice%"=="5" goto netconn_menu
if "%subchoice%"=="6" goto extras
if "%subchoice%"=="0" goto main
goto help
