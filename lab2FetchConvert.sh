#!/bin/bash

# This script will fetch a student assignment from Bitbucket for grading.
# The files are converted to a single PDF and put into the grading folder.
# Use the Lab2Return.sh script to return the graded PDF to the students.

# The script takes a single parameter, which is the concatenation of all
# of the Bitbucket accounts of the students in the team, separated by a dashes.
# e.g. jsmith1-mjones
# It expects that the first username is the owner of the shared repository.

cd Lab2 # folder for local repository

git remote add ${1%%-*} git@bitbucket.org:${1%%-*}/lab2.git # add a remote for the student repository
git fetch ${1%%-*} # fetch the student work
git checkout -b $1 ${1%%-*}/master # make a student branch

# Convert file(s) to PDF(s) and place in grading directory
~/Dropbox/a2pdf-1.13-OSX-Intel/a2pdf --noperl-syntax Lab2Code/Lab2.java > ../grading/Lab2/$1.java.pdf # convert the Java file to PDF

git checkout master # return to master branch





















































