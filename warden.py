#!/usr/bin/env python3
"""
AI Warden - Simple OSC to Claude API integration
Receives biometric sensor data via OSC, sends to Claude, returns Warden comments.
"""

import anthropic
from pythonosc import dispatcher, osc_server, udp_client
import threading
import time

# Sensor data storage
sensor_data = {
    'avg_stress': 0.0,
    'avg_focus': 0.0,
    'deviants': [],
    'total_participants': 8,
    'phase': 'observation'
}

# Claude client
client = anthropic.Anthropic()

# OSC output client (for sending Warden comments to other systems)
osc_out = None  # Will be initialized in main()


def create_warden_prompt(data):
    """Build the Warden prompt from sensor data."""
    return f"""You are the AI Warden of NEUROPRISON, an authoritarian surveillance system monitoring prisoners through biometric sensors.

CURRENT BIOMETRIC DATA:
- Collective stress: {data['avg_stress']:.2f}/1.0
- Collective focus: {data['avg_focus']:.2f}/1.0
- Non-compliant participants: {len(data['deviants'])} of {data['total_participants']}
- Phase: {data['phase']}

Generate ONE short, authoritative Warden comment (1-2 sentences). Be cold, clinical, and menacing. Comment on the biometric state you observe."""


def get_warden_comment():
    """Send sensor data to Claude and get Warden comment."""
    prompt = create_warden_prompt(sensor_data)

    message = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=100,
        messages=[{"role": "user", "content": prompt}]
    )

    return message.content[0].text


# OSC Handlers
def handle_stress(address, value):
    """Handle incoming stress data."""
    sensor_data['avg_stress'] = float(value)
    print(f"Stress updated: {value}")


def handle_focus(address, value):
    """Handle incoming focus data."""
    sensor_data['avg_focus'] = float(value)
    print(f"Focus updated: {value}")


def handle_deviant(address, participant_id):
    """Handle deviant participant notification."""
    if participant_id not in sensor_data['deviants']:
        sensor_data['deviants'].append(participant_id)
    print(f"Deviant added: {participant_id}")


def handle_phase(address, phase):
    """Handle phase change."""
    sensor_data['phase'] = phase
    print(f"Phase changed: {phase}")


def handle_trigger(address, *args):
    """Trigger Warden comment generation."""
    print("\n--- Generating Warden Comment ---")
    print(f"Data: stress={sensor_data['avg_stress']:.2f}, focus={sensor_data['avg_focus']:.2f}, deviants={len(sensor_data['deviants'])}")

    try:
        comment = get_warden_comment()
        print(f"WARDEN: {comment}")

        # Send comment via OSC to other systems (e.g., TTS)
        if osc_out:
            osc_out.send_message("/warden/speech", comment)

        return comment
    except Exception as e:
        print(f"Error: {e}")
        return None


def main():
    global osc_out

    # Setup OSC output client
    osc_out = udp_client.SimpleUDPClient("127.0.0.1", 57120)  # Adjust port for your TTS/sound system

    # Setup OSC dispatcher
    disp = dispatcher.Dispatcher()
    disp.map("/biometric/stress", handle_stress)
    disp.map("/biometric/focus", handle_focus)
    disp.map("/biometric/deviant", handle_deviant)
    disp.map("/warden/phase", handle_phase)
    disp.map("/warden/trigger", handle_trigger)

    # Start OSC server
    server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 8000), disp)
    print("Warden listening on port 8000")
    print("OSC addresses: /biometric/stress, /biometric/focus, /biometric/deviant, /warden/phase, /warden/trigger")

    server.serve_forever()


if __name__ == "__main__":
    main()
