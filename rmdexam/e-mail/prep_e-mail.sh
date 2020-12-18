#!/bin/bash

# wd
cd Data/Projects/Github/charlotte-ngs/lbgfs2020_ghroot/master/lbgfs2020

EMLDIR=rmdexam/e-mail
EMLTMPL=rmdexam/e-mail/e-mail_template.txt

# loop over test-students
cat misc/20200918_exercise_platform/test_students_lbgfs2020.txt | while read e
do
  user=`echo $e | cut -d ',' -f1`
  email=`echo $e | cut -d ',' -f2`
  name=`echo $e | cut -d ',' -f3`
  fname=`echo $e | cut -d ',' -f4`
  echo " * User: $user"
  echo " * E-mail: $email"
  echo " * Name: $name"
  echo " * Fname: $fname"
  emailpath=$EMLDIR/"email_${user}.txt"
  echo $emailpath
  echo "To: $email" > $emailpath
  echo "Re: Exam Livestock Breeding and Genomics" >> $emailpath
  echo >> $emailpath
  echo "Dear $fname $name" >> $emailpath
  cat $EMLTMPL >> $emailpath
  sleep 2
done

# loop over students
cat misc/20200918_exercise_platform/students_lbgfs2020.txt | while read e
do
  user=`echo $e | cut -d ',' -f1`
  email=`echo $e | cut -d ',' -f2`
  name=`echo $e | cut -d ',' -f3`
  fname=`echo $e | cut -d ',' -f4`
  echo " * User: $user"
  echo " * E-mail: $email"
  echo " * Name: $name"
  echo " * Fname: $fname"
  emailpath=$EMLDIR/"email_${user}.txt"
  echo $emailpath
  echo "To: $email" > $emailpath
  echo "Re: Exam Livestock Breeding and Genomics" >> $emailpath
  echo >> $emailpath
  echo "Dear $fname $name" >> $emailpath
  cat $EMLTMPL >> $emailpath
  sleep 2
done
