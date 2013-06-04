'''
Interface to Git. It is not intended to be a complete API for Git.
Instead, it only provides access to Git needed by the grading-script
project.
'''
import logging
import subprocess

def removeRemote(remoteName) :
  ''' git remote remove remoteName '''
  logging.debug("git.removeRemote("+remoteName+")")
  return subprocess.call(['git', 'remote', 'remove', remoteName])

def addRemote(remoteName, remoteUrl) :
  ''' git remote add -f remoteName url '''
  logging.debug(
    "git.addRemote("+
    remoteName+","+
    remoteUrl+","+
    remoteBranch+","+
    localBranch+")"
  )
  r = subprocess.call(['git', 'remote', 'add', '-f', remoteName, remoteUrl]) 
  if r == 1 : 
    removeRemote(remoteName)
    return 1
  return 0

def checkoutRemote(newBranch, remoteName, remoteBranch) :
  logging.debug(
    "git.checkoutRemote("+newBranch+","+remoteName+","+remoteBranch+")")
  return subprocess.call(
    ['git','checkout','-b',newBranch,remoteName+'/'+remoteBranch]
  )

def checkout(localBranch) :
  ''' git checkout localBranch '''
  logging.debug("git.checkout("+localBranch+")")
  return subprocess.call(['git','checkout',localBranch])

def add(file) :
  ''' git add file '''
  logging.debug("git.add("+file+")")
  return subprocess.call(['git','add',file])

def commit(message) :
  ''' git commit -m'message' '''
  logging.debug("git.commit("+message+")")
  return subprocess.call(['git','commit','-m',message])

def push(remote, branch) :
  ''' git push remote branch '''
  logging.debug("git.push("+remote+','+branch+")")
  return subprocess.call(['git','push',remote,branch])

