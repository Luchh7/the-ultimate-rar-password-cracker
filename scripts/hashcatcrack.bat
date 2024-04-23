@echo off

setlocal EnableDelayedExpansion

cd  %USERPROFILE%\Desktop\zipcracker\reporitories\JohnTheRipper\run

:START
set /p rar="Scegli l'archivio RAR: "
if not exist "%rar%" (
   echo Archivio non trovato!
   pause
)
cls

echo %rar% | find /i ".rar" >nul
if errorlevel 1 goto ERR
echo Formato corretto!
goto CONTINUE

:ERR
cls
echo Errore: Tipo di file non valido,seleziona un file RAR valido
echo (1) Prova un altro file:
echo (2) Esci
set /p choice=Scegli:
if /i "%choice%"=="1" cls & goto start
if /i "%choice%"=="2" exit
goto ERR

:CONTINUE
cls
set /p cartella="Scegli la cartella dell'output di john the ripper (creane una solo per il file, verra' cancellata alla fine del procedimento): "
if not exist "%cartella%" (
   echo Cartella non trovata!
   pause
   GOTO CONTINUE
)


dir "%cartella%" /AD /B >nul 2>&1
if errorlevel 1 cls & goto ERROR
cls
echo Cartella trovata!
goto CONTINUA

:ERROR
echo Errore: Tipo di file non valido,seleziona una cartella valida
echo (1) Prova un altro file:
echo (2) Esci
set /p choice=Scegli:
if /i "%choice%"=="1" cls & goto CONTINUE
if /i "%choice%"=="2" exit
goto ERR




:CONTINUA
   rar2john.exe "%rar%" > "%cartella%\output.txt"
   
   set "file_input=%cartella%\output.txt"
   set "file_output=%cartella%\output2.txt"
   set "string_to_remove=%rar%:"
   
   
   for /f "tokens=*" %%a in ('type "%file_input%"') do (
    set "line=%%a"
    set "line=!line:%string_to_remove%=!"
    echo !line!>> "%file_output%"
	
	ren %file_output% "output2.hash"
	
	cls
	
	echo Prima parte dell'operazione completata!
	
	del %file_input%
	
	pause	
)

cls

cd %USERPROFILE%\Desktop\zipcracker\reporitories\hashcat-6.2.6
 
 :WORD
 set /p wordlist="Scegli la wordlist: "
if not exist "%wordlist%" (
   echo Archivio non trovato!
   GOTO ERR2
)

echo %wordlist% | find /i ".txt" >nul
if errorlevel 1 goto ERR
echo Formato del file corretto!
goto CONTINUA2



:CONTINUA2
cls
hashcat.exe "%cartella%\output2.hash" -m 13000 %wordlist%
pause

rd /s /q "%cartella%"

echo Cartella cancellata correttamente, premi invio per chiudere il tool!

pause 
exit


:ERR2
   
   cls
   echo Seleziona una wordlist corretta (deve essere un file.txt)
   echo (1) Prova un altro file:
   echo (2) Esci
   set /p choice=Scegli:
   if /i "%choice%"=="1" cls & goto WORD
   if /i "%choice%"=="2" exit
   goto ERR2


   