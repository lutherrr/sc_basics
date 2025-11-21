"""
Warden Claude - Biometric Prison AI Commentary System
Receives sensor data via OSC, sends to Claude API, returns text for display.
"""

import anthropic
from pythonosc import dispatcher, osc_server, udp_client
import threading
import json

# ============== SENSOR DATA STRUCTURE ==============
class SensorData:
    def __init__(self):
        self.avg_stress = 0.5
        self.avg_focus = 0.5
        self.deviants = []
        self.total_participants = 15
        self.phase = "observation"  # calibration/observation/interrogation/crisis

    def to_dict(self):
        return {
            'avg_stress': self.avg_stress,
            'avg_focus': self.avg_focus,
            'deviants': self.deviants,
            'total_participants': self.total_participants,
            'phase': self.phase
        }

# ============== WARDEN CLAUDE ==============
class WardenClaude:
    def __init__(self, api_key=None):
        self.client = anthropic.Anthropic(api_key=api_key)  # Uses ANTHROPIC_API_KEY env var if None
        self.system_prompt = """You are the Warden of a biometric prison. You monitor prisoners through
biometric sensors measuring stress and focus levels. You speak in short, authoritative,
cold sentences. You comment on anomalies and non-compliance. Maximum 2 sentences."""

    def generate_comment(self, sensor_data: dict) -> str:
        prompt = f"""BIOMETRIC SURVEILLANCE DATA:
- Collective stress: {sensor_data['avg_stress']:.2f}/1.0
- Collective focus: {sensor_data['avg_focus']:.2f}/1.0
- Non-compliant units: {len(sensor_data['deviants'])} of {sensor_data['total_participants']}
- Deviant IDs: {sensor_data['deviants']}
- Phase: {sensor_data['phase']}

Generate one Warden comment about this state."""

        message = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=100,
            system=self.system_prompt,
            messages=[{"role": "user", "content": prompt}]
        )
        return message.content[0].text

# ============== OSC BRIDGE ==============
class WardenOSCBridge:
    """Receives sensor data via OSC, sends to Claude, returns comment via OSC"""

    def __init__(self, receive_port=7400, send_port=7401, send_ip="127.0.0.1"):
        self.sensor_data = SensorData()
        self.warden = WardenClaude()
        self.osc_client = udp_client.SimpleUDPClient(send_ip, send_port)

        # Setup OSC receiver
        self.dispatcher = dispatcher.Dispatcher()
        self.dispatcher.map("/sensor/stress", self._handle_stress)
        self.dispatcher.map("/sensor/focus", self._handle_focus)
        self.dispatcher.map("/sensor/deviants", self._handle_deviants)
        self.dispatcher.map("/sensor/phase", self._handle_phase)
        self.dispatcher.map("/sensor/total", self._handle_total)
        self.dispatcher.map("/warden/generate", self._handle_generate)

        self.server = osc_server.ThreadingOSCUDPServer(("0.0.0.0", receive_port), self.dispatcher)

    def _handle_stress(self, address, *args):
        self.sensor_data.avg_stress = float(args[0])
        print(f"Stress: {self.sensor_data.avg_stress}")

    def _handle_focus(self, address, *args):
        self.sensor_data.avg_focus = float(args[0])
        print(f"Focus: {self.sensor_data.avg_focus}")

    def _handle_deviants(self, address, *args):
        self.sensor_data.deviants = list(args)
        print(f"Deviants: {self.sensor_data.deviants}")

    def _handle_phase(self, address, *args):
        self.sensor_data.phase = str(args[0])
        print(f"Phase: {self.sensor_data.phase}")

    def _handle_total(self, address, *args):
        self.sensor_data.total_participants = int(args[0])

    def _handle_generate(self, address, *args):
        """Generate and send Warden comment"""
        print("Generating Warden comment...")
        try:
            comment = self.warden.generate_comment(self.sensor_data.to_dict())
            print(f"Warden: {comment}")
            self.osc_client.send_message("/warden/comment", comment)
        except Exception as e:
            print(f"Error: {e}")
            self.osc_client.send_message("/warden/error", str(e))

    def start(self):
        print(f"Warden listening on port {self.server.server_address[1]}")
        print("OSC addresses: /sensor/stress, /sensor/focus, /sensor/deviants, /sensor/phase, /warden/generate")
        self.server.serve_forever()


# ============== STANDALONE TEST ==============
def test_warden():
    """Test without OSC"""
    warden = WardenClaude()

    test_data = {
        'avg_stress': 0.72,
        'avg_focus': 0.35,
        'deviants': [3, 7, 12],
        'total_participants': 15,
        'phase': 'interrogation'
    }

    print("Testing Warden Claude...")
    print(f"Input: {test_data}")
    comment = warden.generate_comment(test_data)
    print(f"Warden: {comment}")
    return comment


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "test":
        test_warden()
    else:
        # Start OSC bridge
        bridge = WardenOSCBridge(
            receive_port=7400,  # From Max/SC
            send_port=7401      # To Max/SC for display
        )
        bridge.start()
