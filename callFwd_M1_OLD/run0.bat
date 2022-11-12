cls
set BASE=/kim/gitdir/RLAB/callFwd
set SRC=%BASE%
set JAR=%BASE%
set CP="%JAR%/jTCPfwd.jar;%SRC%"
set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1
REM %JAVA_HOME%/bin/javac  -cp  %CP% %SRC%/CallFwd.java
REM Unit Test
set RERUN=112 


%JAVA_HOME%/bin/java -cp %CP%  CallFwd /kim/gitdir/RLAB/callFwd/confMaster.txt
