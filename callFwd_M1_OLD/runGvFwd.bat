set BASE=/home/pmvnobat/prj/jerrordb
set SRC=%BASE%/src
set JAR=/home/pmvnobat/prj/jerrordb/jar
set CP="%BASE%;%BASE%/mvno;%JAR%/*"

set JAVA_HOME=/progra~1/graalvm-ce-java8-19.3.1

%JAVA_HOME%/bin/java  -cp %CP%  mvno.GvFwd PeerFilter@#10.89.34.95#8085 localhost:80




