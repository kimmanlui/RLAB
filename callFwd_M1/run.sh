

echo off

export MF=/Users/admin/Library/CloudStorage/Box-Box

#SET MF="c:\users\cskml\box"



set BASE=/kim/gitdir/RLAB/callFwd
set SRC=%BASE%
set JAR=%BASE%
set CP="%JAR%/jTCPfwd.jar;%SRC%"
REM set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1
set JAVA_HOME=/progra~1/JAVA/jdk1.8.0_301
REM %JAVA_HOME%/bin/javac  -cp  %CP% %SRC%/CallFwd.java
REM Unit Test
set RERUN=112 

set RERUN=%ERRORLEVEL%
:loop
echo %RERUN%
IF %RERUN% EQU 112 GOTO ERROR
%JAVA_HOME%/bin/java -cp %CP%  CallFwd %MASTERFILE%
set RERUN=%ERRORLEVEL%
goto loop


:ERROR
ECHO "Program END"
