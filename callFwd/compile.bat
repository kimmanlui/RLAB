cls
set BASE=/kim/gitdir/RLAB/callFwd
set SRC=%BASE%
set JAR=%BASE%
set CP="%JAR%/jTCPfwd.jar"
REM set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1
set JAVA_HOME=/progra~1/JAVA/jdk1.8.0_301
%JAVA_HOME%/bin/javac  -cp  %CP% %SRC%/CallFwd.java



