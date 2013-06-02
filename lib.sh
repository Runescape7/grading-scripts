# Copyright (C) 2013 Karl R. Wurst and  Stoney Jackson
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


# This script contains functions that are used by other scripts. Other
# scripts should include this one as follows:
#
#     source ./lib.sh


function getRemote {
  # Adds a remote repository to the current local repository, checks
  # out the remote master into a new branch, and switches to that branch.
  # Returns 0 if successful, or 1 if failed. If failed, any changes to
  # local repository are undone.
  # 
  # $1 teamname (e.g., smith-johnson)
  # $2 repo (e.g., lab1.git)
  #
  # Example call
  #     $ getBranch smith-johnson lab1.git
  #
  # New branch is smith-johnson.
  # Remote is smith -> git@bitbucket.org:smith/lab1.git.
  #
  if git remote add -f ${1%%-*} git@bitbucket.org:${1%%-*}/$2 ; then
    git checkout -b $1 ${1%%-*}/master
    return 0
  else
    git remote remove ${1%%-*}
    return 1
  fi
}
