
echo off
cls


set PACKAGE=c:/kimman/schedule/stock
echo PACKAGE PATH IS :%PACKAGE%


REM set JAVAHM=D:\Program Files\graalvm-ce-java8-19.3.1\bin
set JAVAHM=c:\Program Files\Java\jdk1.8.0_45\bin

set SRC=c:/kimman/schedule
set CLASSPF="%SRC%/;%PACKAGE%/" 

cd %SRC%

REM "%JAVAHM%\javac.exe"  -d %SRC% -classpath %CLASSPF%   "%SRC%/ReadXML.java"
REM "%JAVAHM%\java.exe" -version
"%JAVAHM%\java.exe" -classpath %CLASSPF% stock/ReadXML 