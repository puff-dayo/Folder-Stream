@echo off
SETLOCAL enableDelayedExpansion

echo Welcome to
echo.
echo [32m    Folder Stream Tool[0m
echo [33m        Version 2 by puff-dayo [0m
echo.

rem Check if folder-stream.data exists 
if exist "folder-stream-user-data.txt" (
    echo Data file exists.
    set /p loadConfig="Load last configuration (y/n)?"
    if /i "!loadConfig!"=="y" (
      set lineFlag=0
      for /f "delims=*" %%i in (folder-stream-user-data.txt) do (
      set /a lineFlag+=1
      if !lineFlag!==1 (
        set pathInput=%%i
        echo Path: !pathInput!
          )
      if !lineFlag!==2 (
        set fileType=%%i
        echo File type: !fileType!
          )
      if !lineFlag!==3 (
        set streamLink=%%i
        echo Stream server URL: !streamLink!
          )
      if !lineFlag!==4 (
        set overlaySwitch=%%i
        echo Now-playing overlay: !overlaySwitch!
          )
      )
    )
)
echo.
rem Only prompt for input if not using the last configuration
if not defined pathInput del /f /q folder-stream-user-data.txt
if not defined pathInput set /p pathInput=Enter the path and press Enter (e.g. E:\Livestream\): 
if not defined fileType set /p fileType=Enter the file type (e.g. mp4): 
if not defined streamLink set /p streamLink=Enter the stream link (e.g. rtmps://link): 
if not defined overlaySwitch set /p overlaySwitch="Do you want to enable the now-playing overlay? (y/n): "

REM Save user input to folder-stream.data
(
    echo %pathInput%
    echo %fileType%
    echo %streamLink%
    echo %overlaySwitch%
) > folder-stream-user-data.txt

rem Ensure path ends with a backslash
if not "%pathInput:~-1%"=="\" set pathInput=%pathInput%\

rem Check if the path is valid
if not exist "%pathInput%" (
    echo The path %pathInput% does not exist!
    pause
    exit
)

rem Count the total number of files of the specified type
for /f %%A in ('dir /b "%pathInput%*.%fileType%" 2^>nul ^| find /v /c ""') do set totalCount=%%A

:loop
set playedCount=0

for %%f in ("%pathInput%*.%fileType%") do (
    set /a playedCount+=1
    set /a remainingCount=totalCount-playedCount
    echo %DATE% %TIME% - Streaming file: %%f File !playedCount! of !totalCount!, !remainingCount! remaining >> "%pathInput%folder-stream-log.log"
    
    if /i "%overlaySwitch%"=="y" (
      ffmpeg -re -i "%%f" -c:v libx264 -preset veryfast -b:v 1500k -maxrate 1700k -bufsize 7000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -filter_complex "drawtext=fontfile=NotoSansCJKsc-Regular.ttf:text='NOW PLAYING %%~nf.%fileType%':fontsize=30:fontcolor=ffffff:alpha='if(lt(t,1),0,if(lt(t,11),(t-1)/10,if(lt(t,31),1,if(lt(t,40),(9-(t-31))/9,0))))':x=10:y=10" -f flv "%streamLink%"
    ) else (
      ffmpeg -re -i "%%f" -c:v libx264 -preset veryfast -b:v 1500k -maxrate 1700k -bufsize 7000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv "%streamLink%"
    )

)
goto loop
