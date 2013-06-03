import json
import sys
import os.path as op

def loadConfig(file):
  return json.loads(open(file).read())

def gradeFetch(cfg):
  for a in c['git-accounts'] :
    fetch(a, c['git-project'])
    for f in c['pdf-files'] :
      c['__a'] = a
      dest = "{pdf-dest}/{__a}".format(c))
      a2pdf(f, dest)

