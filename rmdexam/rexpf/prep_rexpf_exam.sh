#!/bin/bash

#ghroot dir
GHROOTDIR=/Users/pvr/Data/Projects/Github/charlotte-ngs/lbgfs2020_ghroot

# wd
cd ${GHROOTDIR}/master/lbgfs2020

# rexpf src dir
REXPFSDIR=rmdexam/rexpf

# rmdexamdir
REXAMOUTDIR=rmdexam/out

# REXPFTRGDIR
REXPFTRGDIR=${GHROOTDIR}/rexpf/lbgfs2020

# loop over test-students
cat misc/20200918_exercise_platform/test_students_lbgfs2020.txt | while read e
do
  user=`echo $e | cut -d ',' -f1`
  echo " * User: $user"
  # create target directory
  curtrgdir=${REXPFTRGDIR}/exam_${user}
  if [ ! -d "$curtrgdir" ]
  then
    echo " * Create trg dir: $curtrgdir ..."
    mkdir -p $curtrgdir
  fi
  # cp exam rmd
  echo " * copy $REXAMOUTDIR/exam_${user}/*_exam_${user}.Rmd to $curtrgdir ..."
  cp $REXAMOUTDIR/exam_${user}/*_exam_${user}.Rmd $curtrgdir
  cp -r $REXAMOUTDIR/exam_${user}/tex $curtrgdir

  sleep 2
done


# loop over test-students
cat misc/20200918_exercise_platform/students_lbgfs2020.txt | while read e
do
  user=`echo $e | cut -d ',' -f1`
  echo " * User: $user"
  # create target directory
  curtrgdir=${REXPFTRGDIR}/exam_${user}
  if [ ! -d "$curtrgdir" ]
  then
    echo " * Create trg dir: $curtrgdir ..."
    mkdir -p $curtrgdir
  fi
  # cp exam rmd
  echo " * copy $REXAMOUTDIR/exam_${user}/*_exam_${user}.Rmd to $curtrgdir ..."
  cp $REXAMOUTDIR/exam_${user}/*_exam_${user}.Rmd $curtrgdir
  cp -r $REXAMOUTDIR/exam_${user}/tex $curtrgdir

  sleep 2
done
