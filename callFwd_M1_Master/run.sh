#!/bin/zsh

echo on
export MF=/Users/admin/Library/CloudStorage/Box-Box

export MASTERFILE=/Users/admin/RLAB/callFwd_M1_Master/confMaster.txt 

export BASE=/Users/admin/RLAB/callFwd_M1_Master
export SRC=$BASE
export JAR=$BASE
export CP=$JAR/jTCPfwd.jar:$SRC
export JAVA_HOME=/usr
export RERUN=112 

cd $MF
echo $JAVA_HOME/bin/java
java -version
STATUS="111"
while [ $STATUS -lt 112 ]
do
  java -cp $CP  CallFwd $MASTERFILE
  STATUS="${?}"
  echo "${STATUS}"
done

echo "---END---"
