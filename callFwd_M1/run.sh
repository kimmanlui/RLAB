#!/bin/zsh

echo on
export MF=/Users/admin/Library/CloudStorage/Box-Box/M1_ROOT

#SET MF="c:\users\cskml\box"

export MASTERFILE=$MF/confFwd.txt 

export BASE=/Users/admin/RLAB/callFwd_M1
export SRC=$BASE
export JAR=$BASE
export CP=$JAR/jTCPfwd.jar:$SRC
export JAVA_HOME=/usr
export RERUN=112 

cd $MF
echo $JAVA_HOME/bin/java
java -version
java -cp $CP  CallFwd $MASTERFILE
STATUS="${?}"
echo "${STATUS}"

