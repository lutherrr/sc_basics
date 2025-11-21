#!/usr/bin/env python3
"""
Test script for AI Warden - simulates sensor data via OSC.
Run warden.py first, then run this script.
"""

from pythonosc import udp_client
import time

# Connect to Warden OSC server
client = udp_client.SimpleUDPClient("127.0.0.1", 8000)

print("Sending test sensor data to Warden...")

# Send simulated biometric data
client.send_message("/biometric/stress", 0.72)
client.send_message("/biometric/focus", 0.35)
client.send_message("/biometric/deviant", 3)
client.send_message("/biometric/deviant", 7)
client.send_message("/warden/phase", "interrogation")

time.sleep(0.5)

# Trigger Warden comment
print("Triggering Warden response...")
client.send_message("/warden/trigger", 1)

print("Done. Check warden.py output for the comment.")
