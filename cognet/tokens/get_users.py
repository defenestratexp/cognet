#!/usr/bin/env python
import requests
import sys

domain = sys.argv[1]

url = 'http://mcp-interface.cognet.tv/status'
params = {'target': domain, 'verbose': 'True'}

r = requests.get(url, params=params)
content = r.json()

tokencounter = 0

for user in content[domain]['users']:
    print user
    tokencounter += 1
    
print tokencounter
