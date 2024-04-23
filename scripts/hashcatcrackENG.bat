@echo off

setlocal EnableDelayedExpansion

cd  %USERPROFILE%\Desktop\zipcracker\reporitories\JohnTheRipper\run

:START
set /p rar="Choose a RAR archive: "
if not exist "%rar%" (
   echo Archive didn't find!
   pause
)
cls

echo %rar% | find /i ".rar" >nul
if errorlevel 1 goto ERR
echo Correct file format!
goto CONTINUE

:ERR
cls
echo Error: File type invalid,select a valid RAR file
echo (1) Try with another file:
echo (2) Quit
set /p choice=Scegli:
if /i "%choice%"=="1" cls & goto start
if /i "%choice%"=="2" exit
goto ERR

:CONTINUE
cls
set /p "cartella=Choose a folder where john the ripper will output files (create a folder only for these files, it will be deleted later in the process):"
if not exist "%cartella%" (
   echo Folder didn't find!
   pause
   GOTO CONTINUE
)


dir "%cartella%" /AD /B >nul 2>&1
if errorlevel 1 cls & goto ERROR
cls
echo Correct folder!
goto CONTINUA

:ERROR
echo Error: File type not valid,select another folder
echo (1) Try with another file:
echo (2) Quit
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
	
	echo First step of the process completed!
	
	del %file_input%
	
	pause	
)

cls

cd %USERPROFILE%\Desktop\zipcracker\reporitories\hashcat-6.2.6
 
 :WORD
 set /p wordlist="Choose the wordlist: "
if not exist "%wordlist%" (
   echo File didn't find!
   GOTO ERR2
)

echo %wordlist% | find /i ".txt" >nul
if errorlevel 1 goto ERR
echo File type correct!
goto CONTINUA2



:CONTINUA2
cls
hashcat.exe "%cartella%\output2.hash" -m 13000 %wordlist%
pause

rd /s /q "%cartella%"

echo Temporary folder succesfully deleted, press enter to exit the tool!

pause 
exit


:ERR2
   
   cls
   echo Select a valid wordlist (it must be a .txt file)
   echo (1) Try with another file:
   echo (2) Quit
   set /p choice=Scegli:
   if /i "%choice%"=="1" cls & goto WORD
   if /i "%choice%"=="2" exit
   goto ERR2


   