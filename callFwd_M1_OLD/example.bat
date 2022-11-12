cls
echo off
set BASE=/kim/gitdir/RLAB/callFwd
set SRC=%BASE%
set JAR=%BASE%
set CP="%JAR%/jTCPfwd.jar;%SRC%"
REM set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1
REM set JAVA_HOME=/progra~1/JAVA/jdk1.8.0_301
set JAVA_HOME=/progra~1/JAVA/graalvm
echo Using Graalvm
echo %JAVA_HOME%
PATH=%PATH%;%BASE%
%JAVA_HOME%/bin/javac  -cp  %CP% %SRC%/Example.java
 

%JAVA_HOME%/bin/native-image  -H:-CheckToolchain  -H:+ReportExceptionStackTraces -cp %CP%  Example


