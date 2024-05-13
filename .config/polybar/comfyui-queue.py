#!/usr/bin/python
from urllib import request
from urllib.error import URLError
import json

URL = "http://10.0.1.99:8188/queue"

try:
    response = request.urlopen(URL)
except URLError:
    print()
    exit()
response_text = response.read().decode("utf-8")
data = json.loads(response_text)
pending = data["queue_pending"]
length = len(pending)
if length:
    print(length)
else:
    print()
