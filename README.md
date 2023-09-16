# Folder Stream

An interactive batch file that uses ffmpeg on Windows to perform rtmps streaming of files with a specified extension in a folder. And it adds an overlay layer to the video to show the current playing file name.

Tested on Telegram PC (Windows11 21H2, 4.8.10 x64) live stream. **Very good audio quality** compared to in-app streaming. 

###  New Features

**Version 1: 09/16/23**
Basic functionality

**Version 2: 09/17/23**
Add save&load last config
Add fade-in&out animation of now-playing overlay and a switch to turn it on/off
Fix bugs

## Usage Example

1. Make sure you installed ``ffmpeg-full`` on your Windows machine and added it to PATH. It should be "ffmpeg-**full**".

Check by running fffmpeg in a ``cmd.exe`` console. You may get something like this:

![图片](https://github.com/puff-dayo/folder-stream/assets/84665734/0ae27b77-5d15-4bc1-b6ac-22660d441392)

2. In version2, I made a new feature. The batch can save (in the same folder with the .bat file) and load last config, making more convenience. Download and place a ``NotoSansCJKsc-Regular.ttf`` in the same folder with the .bat file. Here is the download link: https://github.com/life888888/cjk-fonts-ttf/releases/download/v0.1.0/NotoSansCJKsc-Regular.ttf .

3. Follow the directions print out on the ``cmd.exe`` console. Type some information it requires. Press Enter. And it will run! (it works on my machine)

![图片](https://github.com/puff-dayo/folder-stream/assets/84665734/a586c893-41da-4c73-a7ab-38614e870726)

4. (if you want to) Configure the ffmpeg params.

## How to Install ffmpeg-full (Briefly)

1. Goto https://www.gyan.dev/ffmpeg/builds/ , and download this:

![图片](https://github.com/puff-dayo/folder-stream/assets/84665734/e70147ec-866a-43ba-96cd-f2b517a8489a)

2. Unzip it somewhere safe (you wont delete it by accident), and add the directory to PATH.

Step by step instruction can be found on wikiHow: https://www.wikihow.com/Install-FFmpeg-on-Windows

## How to Stream (Take Telegram as an example)

Step 1: Click the icon on the right side of your Channel title bar.

![图片](https://github.com/puff-dayo/folder-stream/assets/84665734/15e9b3e1-22b9-45f9-8d21-e7569bc2881c)

Step 2: Combine A and B to get the full stream server URL.

![图片](https://github.com/puff-dayo/folder-stream/assets/84665734/bcfedd06-5e06-4cc4-9d58-36a71e58382d)

Step 3: Press button 3 (Picture above).

Step 4: Run the batch file.

:D and enjoy

> FFmpeg text animation is generated with http://ffmpeg.shanewhite.co/ .
>
> FFmpeg is the leading multimedia framework, see https://ffmpeg.org/ .
