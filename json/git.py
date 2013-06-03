'''
Interface to Git. It is not intended to be a complete API for Git.
Instead, it only provides access to Git needed by the grading-script
project.
'''
import logging

def checkoutRemote(remoteName, remoteUrl, remoteBranch, localBranch) :
  '''
  git remote add -f remoteName url
  git checkout -b localBranch remoteName/remoteBranch
  '''
  logging.debug("checkoutRemote("+remoteName+","+remoteUrl+","+remoteBranch+","+localBranch+")")
  pass

def checkout(localBranch) :
  '''
  git checkout localBranch
  '''
  pass

def add(file) :
  '''
  git add file
  '''
  pass

def commit(message) :
  '''
  git commit -m'message'
  '''
  pass

def push(remote, branch) :
  '''
  git push remote branch
  '''
  pass

