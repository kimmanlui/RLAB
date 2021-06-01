
echo off
cls

set HOME=c:/kim/gitdir/RLAB
set PACKAGE=%HOME%/schedule/stock
echo PACKAGE PATH IS :%PACKAGE%


REM set JAVAHM=D:\Program Files\graalvm-ce-java8-19.3.1\bin
set JAVAHM=c:\Program Files\Java\jdk1.8.0_45\bin

set SRC=%HOME%/schedule
set CLASSPF="%SRC%/;%PACKAGE%/" 

cd %SRC%

"%JAVAHM%\javac.exe"   -classpath %CLASSPF%   "%SRC%/Scheduler.java"
"%JAVAHM%\java.exe" -version
"%JAVAHM%\java.exe" -classpath %CLASSPF% Scheduler NA err.txt submit_win.txt 