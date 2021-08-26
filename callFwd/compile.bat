cls
set BASE=/kim/gitdir/RLAB/callFwd
set SRC=%BASE%
set JAR=%BASE%
set CP="%JAR%/jTCPfwd.jar"
set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1
%JAVA_HOME%/bin/javac  -cp  %CP% %SRC%/CallFwd.java



