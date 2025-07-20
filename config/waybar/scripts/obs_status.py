#!/usr/bin/env python3
from obsws_python import ReqClient

try:
    client = ReqClient(host='localhost', port=4455, password='changeme')
    status = client.get_record_status()
    if status.output_active:
        if status.output_paused:
            print('{"text": "⏸ Paused", "class": "paused"}')
        else:
            print('{"text": "▶ Recording", "class": "recording"}')
    else:
        print('{"text": "⏹ Not Recording", "class": "stopped"}')
except Exception as e:
    print(f'{{"text": " Error: {e}", "class": "error"}}')
