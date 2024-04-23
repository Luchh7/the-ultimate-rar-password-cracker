@echo off
setlocal enabledelayedexpansion

echo.
echo.
echo   ad8888888888ba  
echo  dP'         `"8b,  
echo  8  ,aaa,       "Y888a     ,aaaa,     ,aaa,  ,aa,  
echo  8  8' `8           "88baadP""""YbaaadP"""YbdP""Yb  
echo  8  8   8              """        """      ""    8b  
echo  8  8, ,8         ,aaaaaaaaaaaaaaaaaaaaaaaaddddd88P  
echo  8  `"""'       ,d8""  
echo  Yb,         ,ad8"    
echo   "Y8888888888P"   
echo.
echo.

FOR /F %%A in ('"PROMPT $H&FOR %%B in (1) DO REM"') DO SET "BS=%%A"

CALL :TYPE "This tool is entirely developed by Luch, if you find a bug report it on GitHub#"
echo.
PAUSE

:TYPE
SET "d[text]=%~1"
SET "max_count=79" 
SET "count=0"
CALL :TYPELOOP
GOTO :EOF

:TYPELOOP
IF "%d[text]:~0,1%" == "#" (
    <NUL SET /P "=^!"
) else (
    <NUL SET /P "=d!BS!%d[text]:~0,1%"
)
SET "d[text]=%d[text]:~1%"
SET /A "count+=1"
IF "%d[text]%" == "" (
    GOTO :lang  REM Vai all'etichetta :lang dopo aver scritto la frase
) else IF !count! GEQ !max_count! (
    GOTO :EOF
) else (
    FOR /L %%J in (1, 10, 1000000) DO REM
    GOTO :TYPELOOP
)


:lang
echo. 
echo.
echo Choose a Language:
echo.
echo.
echo 1. Italiano
echo.
echo.
echo 2. English
echo.
echo.

set /p choice="Scelta: "
if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="4" exit
echo Scelta non valida. Riprova.
goto lang

:option1
cls & GOTO MENUIT

:option2
cls & GOTO MENUENG



cls


:MENUIT
echo Seleziona un'opzione:
echo.
echo 1. "RAR password cracker con script nel cmd (uso quasi nullo del pc ma lento, consigliato massimo per wordlist da 5-10k password)"
echo.
echo.
echo 2. "RAR password cracker che utilizza le dei tool di john the ripper e hashcat (uso molto elevato del pc, non consigliato per pc di fascia bassa, adatto per wordlist che hanno piu' di 10k password)"
echo.
echo.
echo 3. Esci
echo.
echo.


set /p choice="Scelta: "
if "%choice%"=="1" goto Opzione1IT
if "%choice%"=="2" goto Opzione2IT
if "%choice%"=="3" goto Opzione3IT
if "%choice%"=="4" exit
echo Scelta non valida. Riprova.
goto MENUIT

:Opzione1IT
cls
call %USERPROFILE%\Desktop\zipcracker\scripts\crackfilerar.bat
goto MENU

:Opzione2IT
cls
call %USERPROFILE%\Desktop\zipcracker\scripts\hashcatcrack.bat
goto MENU

:Opzione3IT
exit /b



:MENUENG
echo Seleziona un'opzione:
echo.
echo 1. "RAR password cracker using a cmd script (low impact on PC but slower, reccomended only for wordlist of 5-10k passwords)"
echo.
echo.
echo 2. "RAR password cracker that use john the ripper and hashcat tools (it stresses the pc, not reccomended for low-end PCs, reccomended for wordlist that contains more than 10k passwords )"
echo.
echo.
echo 3. Exit
echo.
echo.


set /p choice="Choose: "
if "%choice%"=="1" goto Opzione1ENG
if "%choice%"=="2" goto Opzione2ENG
if "%choice%"=="3" goto Opzione3ENG
if "%choice%"=="4" exit
echo Scelta non valida. Riprova.
goto MENUENG

:Opzione1ENG
cls
call %USERPROFILE%\Desktop\zipcracker\scripts\crackfilerarENG.bat
goto MENU

:Opzione2ENG
cls
call %USERPROFILE%\Desktop\zipcracker\scripts\hashcatcrackENG.bat
goto MENU

:Opzione3ENG
exit /b