@echo off
SETLOCAL enableDelayedExpansion

echo Welcome to
echo.
echo [32m    Folder Stream Tool[0m
echo [33m        Version 1 by puff-dayo [0m
echo.

set /p pathInput=Enter the path and press Enter (e.g. E:\Livestream\): 
set /p fileType=Enter the file type (e.g. mp4): 
set /p streamLink=Enter the stream link (e.g. rtmps://link): 

:: Ensure path ends with a backslash
if not "%pathInput:~-1%"=="\" set pathInput=%pathInput%\

:: Count the total number of files of the specified type
for /f %%A in ('dir /b "%pathInput%*.%fileType%" ^| find /v /c ""') do set totalCount=%%A

:loop
set playedCount=0

for %%f in ("%pathInput%*.%fileType%") do (
    set /a playedCount+=1
    set /a remainingCount=totalCount-playedCount
    echo %DATE% %TIME% - Streaming file: %%f File !playedCount! of !totalCount!, !remainingCount! remaining >> "%pathInput%stream-log.txt"
    
    ffmpeg -re -i "%%f" -c:v libx264 -preset veryfast -b:v 1000k -maxrate 1500k -bufsize 7000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv "%streamLink%"
)
goto loop
