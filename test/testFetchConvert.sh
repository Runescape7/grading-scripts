#!/bin/bash

# Copyright (C) 2013 Karl R. Wurst, Stoney Jackosn
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
# It will leave the graded assignment in a new branch.
# The student will have to merge the changes into their master branch
# (or you have to issue a pull request, and maybe merge it depending on
# how much you want to do for the students.)

# This script will fetch a student assignment from Bitbucket for grading.
# The files are converted to a single PDF and put into the grading folder.
# Use the TestReturn.sh script to return the graded PDF to the students.

# The script takes a single parameter, which is the concatenation of all
# of the Bitbucket accounts of the students in the team, separated by a dashes.
# e.g. jsmith1-mjones
# It expects that the first username is the owner of the shared repository.

###########################################################################
# SETUP
#
# cp grading-scripts/test/test* grading-scripts
# mkdir -p grading/Test
# grading-scripts/test/gitinit.sh Test
#
# RUN
#
# bash grading-scripts/testFetchCovnert.sh dr_stoney-kwurst
###########################################################################

cd Test # folder for local repository

git remote add ${1%%-*} git@bitbucket.org:${1%%-*}/test.git # add a remote for the student repository
git fetch ${1%%-*} # fetch the student work
git checkout -b $1 ${1%%-*}/fixture1 # make a student branch

# Convert file(s) to PDF(s) and place in grading directory
cp Test/file2.java ../grading/Test/$1.java.pdf
cp file1.txt ../grading/Test/$1.txt.pdf
cat ../grading/Test/$1.java.pdf ../grading/Test/$1.txt.pdf > ../grading/Test/$1.pdf
rm ../grading/Test/$1.java.pdf
rm ../grading/Test/$1.txt.pdf

git checkout master # return to master branch

