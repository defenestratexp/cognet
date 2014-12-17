#!/usr/bin/env python
import requests
import sys

domain = sys.argv[1]

url = 'http://mcp-interface.cognet.tv/status'
params = {'target': domain, 'verbose': 'True'}

r = requests.get(url, params=params)
content = r.json()

for user in content[domain]['users']:
    print user
