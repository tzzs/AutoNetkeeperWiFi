@echo off 
title=NetKeeper-WiFi
::
::设置参数
::
SET netkeeper="D:\Program Files\NetKeeper\NetKeeper.exe"
SET nkTask="NK.exe"
SET wifi="D:\Program Files (x86)\kingsoft\kwifi\kwifi.exe"
SET wifiTask="kwifi.exe"
SET log="ping.log"

:: 获取管理员身份
echo Obtaining administrator identity ...
cd /d %~dp0
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit

:: 判断网络是否连接
echo;
echo Start network connection test ...
echo; >> %log%
echo; >> %log%
echo;
echo *********************%date% %time%********************* >> %log%
::baidu DNS
ping /n 2 180.76.76.76>>%log%
ping /n 2 180.76.76.76>tmp.log
echo; >> %log%
for /f %%i in ('findstr /n "超时" tmp.log') do (set r=%%i)
del tmp.log

:: 判断是否连接网络
if defined r ( 
echo; >> %log%
echo Network is not connected >> %log%
echo;
echo Start the network connection ...

::关闭wifi进程
echo;
echo close the wifi task ...
echo; >> %log%
echo close the wifi task ... >> %log%
taskkill /f /t /im %wifiTask% >> %log%


:: 启动netkeeper
echo;
echo start NetKeeper ...
echo; >> %log%
echo start NetKeeper ... >> %log%
start "" %netkeeper% >> %log%


:: 等待连接
echo;
echo Waiting for the program to complete ... 
echo please wait 30 seconds ...
timeout /t 30

:: 关闭NK进程
echo;
echo close the task ...
echo; >> %log%
echo close the task ... >> %log%
taskkill /f /t /im %nkTask% >> %log%

:: 启动wifi
echo;
echo start kwifi ...
echo; >> %log%
echo start kwifi ... >> %log%
start "" %wifi% >> %log%

echo; >> %log%
echo All tasks are completed ... >> %log%

:: 执行完成 关闭窗口
echo;
echo execution completed ...
echo Off automatically after 5 seconds ...
timeout /t 5

) else (

echo Network is connected >> %log%

echo;
echo Network connected ...
echo;
echo Off automatically after 5 seconds ...
echo;
timeout /t 5

)
echo; >> %log%
echo See you ... >> %log%