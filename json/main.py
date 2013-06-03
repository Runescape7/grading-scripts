import json
import sys
import logging
import git
import a2pdf
import os

# Configure logger. Change level before deployment.
logging.basicConfig(level=logging.DEBUG)


def usage(exitCode = 0, message = None, die = True) :
  if message :
    if exitCode :
      sys.stderr.write(message + "\n")
    else :
      print(message)
  print("usage: " + sys.argv[0] + " COMMAND CONFIG.json")
  if die :
    exit(exitCode)


def cmd_fetch(cfg) :

  # Grab files from each team's repo.
  for teamName in cfg['bitbucket_team_accounts']:

    logging.info("Processing team: " + teamName)

    # Account names are a concatenation of team member names separated
    # by a -. The first name is the account name.
    account = teamName.split('-')[0]

    # Construct URL for bitbucket repository.
    remoteUrl="git@bitbucket.org:" + account + "/" + cfg['git_project']

    logging.debug("remoteUrl = " + remoteUrl)

    # Pull remote repo into current repo.
    git.checkoutRemote(account, remoteUrl, 'master', teamName)

    # Snatch all the files to grade, converting to pdf, and depositing
    # into grading directoy.
    for srcFile in cfg['files_to_grade'] :

      # Break the filename into parts.
      dir = os.path.dirname(srcFile)
      file = os.path.basename(srcFile)

      # Construct pdf filename.
      pdfFile = '.'.join(file.split('.')[:-1]) + ".pdf"

      # Create destination folder in grading directory.
      destFile =  '/'.join( [
        cfg['grade_directory_root'],
        teamName,
        pdfFile
      ] )

      # Convert to pdf and copy.
      a2pdf.a2pdf(srcFile, destFile)


def cmd_return(cfg) :
  pass


# Ensure we've been called from the command line.
if __name__ == "__main__" :

  # Check command line arguments.
  if len(sys.argv) <= 2 :
    usage()

  # Load configuration.
  command = sys.argv[1]
  json_config_filename = sys.argv[2]
  cfg = json.loads(open(json_config_filename).read())
  logging.debug(cfg)

  # Dispatch command.
  if command == 'fetch' :
    cmd_fetch(cfg)
  elif command == 'return' :
    cmd_return(cfg)
  else :
    usage(exitCode=1, message="Unrecognized command: " + command)



