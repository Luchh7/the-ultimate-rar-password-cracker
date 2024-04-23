@echo off 

if not exist "C:\Program Files\7-Zip" (
    echo 7-Zip not installed!
	pause 
	exit
)

set /p archive="Choose a ZIP OR RAR archive: "
if not exist "%archive%" (
   echo Archive didn't found!
   pause
   exit
)

set /p wordlist="Choose a wordlist: "
if not exist "%wordlist%" (
   echo Wordlist didn't found!
   pause
   exit
)


set /p output="Select the folder where the file will be extracted to: "
if not exist "%output%" (
   echo Folder didn't found!
   pause
   exit
)

for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)
echo Impossible to find the password, try another wordlist or use the john the ripper method of the tool
pause
exit



:attempt
"C:\Program Files\7-Zip\7z.exe" x -p%pass% "%archive%" -o"%output%" -y >nul 2>&1
echo attempt: %pass%
if /I %errorlevel% EQU 0 (
    echo Password Found: %pass%
	pause 
	exit
)
	
	