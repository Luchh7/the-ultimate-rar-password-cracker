@echo off 

if not exist "C:\Program Files\7-Zip" (
    echo 7-Zip non installato!
	pause 
	exit
)

set /p archive="Scegli un archivio ZIP o RAR: "
if not exist "%archive%" (
   echo Archivio non trovato!
   pause
   exit
)

set /p wordlist="Inserisci la wordlist: "
if not exist "%wordlist%" (
   echo Wordlist non trovata!
   pause
   exit
)


set /p output="Seleziona la cartella dove vuoi che venga estratto il file: "
if not exist "%output%" (
   echo Cartella non trovata!
   pause
   exit
)

for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)
echo Password non trovata, prova con un altra wordlist o usa il metodo che utilizza john the ripper di questo tool!
pause
exit



:attempt
"C:\Program Files\7-Zip\7z.exe" x -p%pass% "%archive%" -o"%output%" -y >nul 2>&1
echo attempt: %pass%
if /I %errorlevel% EQU 0 (
    echo Password Trovata: %pass%
	pause 
	exit
)
	
	

