#!/usr/bin/python3
import re
import sys
import os
import time
from datetime import datetime

template = """%% Parent: [[{pname}]] | Created-on: {datetimenow} 
# {pprojname}{projname}

## Sub Projects
*

## Pending Tasks | project.is:'{pprojname}{projname}' -COMPLETED | project:'{pprojname}{projname}'
* [ ]

## Hyperlinks



## Notes
* 

## Completed Tasks | project.is:'{pprojname}{projname}' +COMPLETED | project:'{pprojname}{projname}'
"""
filenameext = ("missing-filename" if len(sys.argv) < 3
        else sys.argv[2])

pfilenameext = ("missing-parent" if len(sys.argv) < 4
        else sys.argv[3])
        # else sys.argv[1].rsplit(".", 1)[0])

projname = os.path.basename(filenameext).rsplit(".",1)[0]
pname = os.path.basename(pfilenameext).rsplit(".",1)[0]

pprojname = ""
pattern = re.compile("^#  *(.*)$")
if pfilenameext != "missing":
    for i, line in enumerate(open(pfilenameext)):
        for match in re.finditer(pattern, line):
            pprojname = match.groups()[0].strip()
    if pprojname == "index":
        pprojname = ""
    else:
        pprojname = pprojname + "."

with open(sys.argv[1], 'w') as f:
    print(template.format(pname=pname, datetimenow = datetime.now().strftime("%Y-%m-%d %H:%M"), projname=projname, pprojname=pprojname), file=f)
time.sleep(1)
