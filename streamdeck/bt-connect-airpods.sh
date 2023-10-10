#!/bin/bash

exec >> ~/.files/streamdeck/log.txt
exec 2>&1

# Josh’s AirPods Pro:
#     Address: B8:F1:2A:BD:30:21
#     Vendor ID: 0x004C
#     Product ID: 0x200E
#     Firmware Version: 4E71
#     Minor Type: Headphones
#     Serial Number: GN3C1HLCLKKT

# /usr/local/bin/BluetoothConnector --connect B8-F1-2A-BD-30-21 --notify


/usr/local/bin/BluetoothConnector --connect c0-95-6d-c1-0a-ec --notify
