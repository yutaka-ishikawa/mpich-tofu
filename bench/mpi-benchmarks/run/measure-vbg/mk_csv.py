import sys
import fileinput
from pathlib import Path

if not Path(sys.argv[1]).exists():
  print('input file!')
  sys.exit()

benchmarking=""
processes=""
out=0
file = sys.argv[1]
f = open(file, 'r')
line = f.readline()

while line:
  #print(line.strip())

  if '# Benchmarking' in line:
    benchmarking = str(line).replace('Benchmarking ', '')
    benchmarking = benchmarking.replace('# ', '')
    benchmarking = benchmarking.strip()

  if '# #processes =' in line:
    processes = str(line).replace('#', '')
    processes = processes.replace('processes', '')
    processes = processes.replace('=', '')
    processes = processes.strip()

  if out == 1:
    if line != '\n':
      line_sp = str(line).strip()
      line_sp =",".join(line_sp.split())
      txt = benchmarking + ',' + processes + ',' + line_sp
      print(txt)
    else:
      out = 0

  if '       #bytes' in line:
    out = 1
       
  line = f.readline()
f.close()
