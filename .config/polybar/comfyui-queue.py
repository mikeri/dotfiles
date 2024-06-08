#!/usr/bin/python
from urllib import request
from urllib.error import URLError
from time import sleep
import json

URL = "http://10.0.1.99:8188/queue"

while True:
    sleep(5)
    try:
        response = request.urlopen(URL)
    except URLError:
        print("", flush=True)
        continue
    response_text = response.read().decode("utf-8")
    data = json.loads(response_text)
    pending = data["queue_pending"]
    length = len(pending)
    if length:
        print(length, flush=True)
    else:
        print("", flush=True)
