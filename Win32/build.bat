@echo off
rem see http://www.tcpdump.org/#source
rem AppVeyor CI: libpcap (Windows)
rem https://ci.appveyor.com/project/guyharris/libpcap/build/job/ie3x315d5jt6s9ri

echo need cmake
set path=F:\develop\cmake-3.14.5-win64-x64\bin;%path%
echo need vs2017
call "d:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"

echo Environment: GENERATOR=Visual Studio 15 2017, SDK=WpdPack
set GENERATOR=Visual Studio 15 2017
set SDK=WpdPack

set mypath=%~dp0
if not exist "%mypath%winflexbison" (
echo Download winflexbison  from 'https://sourceforge.net/projects/winflexbison/files/old_versions/win_flex_bison-2.4.9.zip'
echo Extract to %mypath%winflexbison
)
set path=%mypath%winflexbison;%path%

if not exist "%mypath%WpdPack" (
echo Download File from 'http://www.winpcap.org/install/bin/WpdPack_4_1_2.zip'
echo Extract WpdPack_4_1_2.zip to %mypath%
)

if not exist "%mypath%npcap-sdk-0.1" (
echo Download File from 'https://nmap.org/npcap/dist/npcap-sdk-0.1.zip'
echo Extract npcap-sdk-0.1.zip to %mypath%
)
cd %mypath%
cd ..

rmdir /s /q build
md build
cd build
cmake -DCMAKE_PREFIX_PATH=%mypath%%SDK% -G"%GENERATOR%" ..
msbuild /m /nologo /p:Configuration=Release pcap.sln

cd %mypath%