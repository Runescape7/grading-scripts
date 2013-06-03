import json
import sys
import logging

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
  pass
  for ta in cfg['bitbucket_team_accounts']:
    a = cfg['bitbucket_team_accounts'][ta]
    logging.debug(a)

#    fetch(a, c['git-project'])
#    for f in c['pdf-files'] :
#      c['__a'] = a
#      dest = "{pdf-dest}/{__a}".format(c))
#      a2pdf(f, dest)

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



