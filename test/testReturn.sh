#!/bin/bash

# Copyright (C) 2013 Karl R. Wurst, Stoney Jackson
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

# This script returns a graded student assignment to their repository.
# It also copies the solution to their repository.
# It will leave the graded assignment in a new branch.
# The student will have to merge the changes into their master branch
# (or you have to issue a pull request, and maybe merge it depending on
# how much you want to do for the students.)

####################################################################
# SETUP
#
# cp grading-scripts/test/test* grading-scripts
# mkdir -p grading/Test
# grading-scripts/test/gitinit.sh Test
#
# RUN
#
# bash grading-scripts/testReturn.sh dr_stoney-kwurst
####################################################################

# The script takes two parameters

# Parameter 1 is the concatenation of all of the Bitbucket accounts of the students in the team, 
# separated by a dashes e.g. jsmith1-mjones
# It expects that the first username is the owner of the shared repository.

# Parameter 2 is name of the assignment e.g. Lab1

# Fail on error (don't keep running).
set -e

# Set this to "true" to have rollback to undo last commit.
ROLLBACK_COMMIT=

# Undo changes.
function rollback {
  if [ "$ROLLBACK_COMMIT" == "true" ] ; then
    git reset --hard HEAD^
  else
    git reset --hard HEAD
    git clean -df
  fi
  git checkout master
  cd -
  exit 1
}
# Doesn't do anything.
function noop {
  return 0
}

# folder for local repository
cd $2

# checkout the student branch
git checkout $1
# DO NOT ADD CODE BETWEEN PREVIOUS AND NEXT STATEMENT.
# Register rollback to run on exit.
# Don't set the trap earlier or else rollback will undo changes
# in the current branch, not the student branch!
trap rollback EXIT

# copy the graded assignment to student repository
cp ../grading/$2/$1.pdf ./

# copy the solution to student repository
# cp -r ../../../Labs/$2/$2'Solution' ./$2'Solution'

# add the graded assignment
git add $1.pdf

# add the solution
# git add $2'Solution'

# commit the graded assignment
git commit -m"Returned graded $2 (and solution)"
# DO NOT ADD CODE BETWEEN PREVIOUS AND NEXT STATEMENT.
# Flag that commit has occurred in case of rollback.
ROLLBACK_COMMIT="true"

# push the changes to student repository
git push ${1%%-*} $1
# DO NOT ADD CODE BETWEEN PREVIOUS AND NEXT STATEMENT.
# Nothing we can do about it now.
trap noop EXIT 

# return to the master branch
git checkout master 

