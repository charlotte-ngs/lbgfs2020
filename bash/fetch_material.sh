#!/bin/bash

SCRIPTDIR=/home/quagadmin/source/misctools/
#DIRTOFETCH=ex/w03_qg
DIRTOFETCH=sol/w02_linalg
TESTSTUDENT=/home/quagadmin/lbgfs2020/test-student-usernames-lbgfs2020.txt
STUDENTUSER=/home/quagadmin/lbgfs2020/student-usernames-lbgfs2020.txt
#' fetch individual directory
#' change to progdir
cd $SCRIPTDIR

#' fetch for test student
cat $TESTSTUDENT | while read s
do 
  echo " * Student: $s"
  ./fetch.sh -s $s -d $DIRTOFETCH
  sleep 2
done

#' fetch for real students
cat $STUDENTUSER | while read s
do 
  echo " * Student: $s"
  ./fetch.sh -s $s -d $DIRTOFETCH
  sleep 2
done

# check content
cat $STUDENTUSER | while read s
do 
  echo " * Student: $s"
  ls -l /home/quagadmin/lbgfs2020/home/$s/lbgfs2020/$DIRTOFETCH
  sleep 2
done
