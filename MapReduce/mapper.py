#!/usr/bin/env python
import sys
 
#--- get all lines from stdin ---
for line in sys.stdin:
    line = line.strip()
    cols = line.split(',')
    print '%s,%s\t%s,%s' % (cols[0],cols[1],cols[2],cols[3] )