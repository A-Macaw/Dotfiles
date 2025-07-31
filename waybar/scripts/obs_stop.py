#!/usr/bin/env python3
from obsws_python import ReqClient
client = ReqClient(host='localhost', port=4455, password='changeme')
client.stop_record()
