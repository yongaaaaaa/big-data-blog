#!/usr/bin/env python
import sys
 
#--- get all lines from stdin ---
for line in sys.stdin:
    #--- remove leading and trailing whitespace---
    line = line.strip()

    #--- split the line into words ---
    cols = line.split(str=",")

    #for col in cols: 
    #    print '%s\t%s' % (col, "1")
    print cols[0] , cols[1] 