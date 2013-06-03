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
# It will leave the graded assignment in a new branch.
# The student will have to merge the changes into their master branch
# (or you have to issue a pull request, and maybe merge it depending on
# how much you want to do for the students.)

# This script will fetch a student assignment from Bitbucket for grading.
# The files are converted to a single PDF and put into the grading folder.
# Use the Lab2Return.sh script to return the graded PDF to the students.

# The script takes a single parameter, which is the concatenation of all
# of the Bitbucket accounts of the students in the team, separated by a dashes.
# e.g. jsmith1-mjones
# It expects that the first username is the owner of the shared repository.

source "$(dirname "$0")/lib.sh"

cd Lab3 # folder for local repository

# Fetch repo into branch and switch to it.
# Exits with error on failure.
getRemote $1 lab3.git

git fetch ${1%%-*} # fetch the student work
git checkout -b $1 ${1%%-*}/master # make a student branch

# Convert file(s) to PDF(s) and place in grading directory
~/Dropbox/a2pdf-1.13-OSX-Intel/a2pdf --noperl-syntax Lab3Code/Lab3.java > ../grading/Lab3/$1Lab3.pdf
~/Dropbox/a2pdf-1.13-OSX-Intel/a2pdf --noperl-syntax Lab3Code/Person.java > ../grading/Lab3/$1Person.pdf
pdftk ../grading/Lab3/$1Lab3.pdf ../grading/Lab3/$1Person.pdf cat output ../grading/Lab3/$1.pdf
rm ../grading/Lab3/$1Lab3.pdf
rm ../grading/Lab3/$1Person.pdf
git checkout master # return to master branch
