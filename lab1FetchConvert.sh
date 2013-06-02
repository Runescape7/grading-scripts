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
# Use the Lab1Return.sh script to return the graded PDF to the students.

# The script takes a single parameter, which is the concatenation of all
# of the Bitbucket accounts of the students in the team, separated by a dashes.
# e.g. jsmith1-mjones
# It expects that the first username is the owner of the shared repository.


source "$(dirname "$0")/lib.sh"


cd Lab1 # folder for local repository

# add and fetch remote for the student repository, if it fails, rollback and exit
getRemote $1 lab1.git || exit 1

# Convert file(s) to PDF(s) and place in grading directory
~/Dropbox/a2pdf-1.13-OSX-Intel/a2pdf --noperl-syntax Lab1/HelloWorld.java > ../grading/Lab1/$1.java.pdf
~/Dropbox/a2pdf-1.13-OSX-Intel/a2pdf --noperl-syntax Lab1.txt > ../grading/Lab1/$1.txt.pdf
pdftk ../grading/Lab1/$1.java.pdf ../grading/Lab1/$1.txt.pdf cat output ../grading/Lab1/$1.pdf
rm ../grading/Lab1/$1.java.pdf
rm ../grading/Lab1/$1.txt.pdf

git checkout master # return to master branch




















































