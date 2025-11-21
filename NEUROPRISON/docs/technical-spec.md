# NEUROPRISON Technical Specification

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AUDIENCE (20-25 participants)            │
│                    [EEG] [GSR] [Eye-tracking]               │
└─────────────────────┬───────────────────────────────────────┘
                      │ Biometric Data (Bluetooth/WiFi)
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              DATA AGGREGATION LAYER                         │
│         Python/OSC Bridge - Data Normalization              │
└─────────────────────┬───────────────────────────────────────┘
                      │ OSC Messages
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              AI CONDUCTOR / WARDEN                          │
│         Rule-based + ML behavioral analysis                 │
│         Collective state computation                        │
└────────┬────────────┬────────────┬─────────────────────────┘
         │            │            │
         ▼            ▼            ▼
┌────────────┐ ┌────────────┐ ┌────────────┐
│ SOUND      │ │ VISUALS    │ │ PERFORMER  │
│ SuperCollider│ │ TouchDesigner│ │ CUE SYSTEM │
│ Pure Data  │ │ Processing │ │ (OSC/MIDI) │
└────────────┘ └────────────┘ └────────────┘
```

## Hardware Requirements

### Sensors (per participant)
- **EEG**: Muse 2 Headband (~$250)
- **GSR**: BITalino Electrodermal Activity sensor (~$150)
- **Fleet**: 20-25 complete sensor sets

### Computing
- **Main Server**: Mac Pro / high-end Linux workstation
  - 64GB RAM minimum
  - NVIDIA RTX 4090 or better for real-time video
- **Audio Interface**: Multi-channel (16+ outputs)
- **Network**: Dedicated WiFi router for sensor data

### Output
- **Projectors**: 4K laser projectors (3-4 units)
- **Sound**: Multi-channel speaker array (8.1 minimum)
- **Lighting**: DMX-controlled intelligent fixtures

## Software Stack

### Data Collection Layer
```python
# Sensor data aggregation
- muse-lsl (EEG streaming)
- bitalino-python (GSR data)
- python-osc (OSC routing)
```

### AI Conductor
```python
# Core AI system
- numpy/scipy (signal processing)
- scikit-learn (classification)
- pytorch (neural models for pattern recognition)
```

### Sound Engine
- SuperCollider (primary synthesis)
- Pure Data (backup/parallel processing)
- Max/MSP (integration layer)

### Visual Engine
- TouchDesigner (primary)
- Processing (auxiliary effects)

## OSC Protocol

### Biometric Data Messages
```
/neuroprison/eeg/focus [0.0-1.0]
/neuroprison/eeg/relaxation [0.0-1.0]
/neuroprison/gsr/arousal [0.0-1.0]
/neuroprison/gaze/x [0.0-1.0]
/neuroprison/gaze/y [0.0-1.0]
/neuroprison/collective/stress [0.0-1.0]
/neuroprison/collective/compliance [0.0-1.0]
```

### Control Messages
```
/neuroprison/warden/voice/intensity [0.0-1.0]
/neuroprison/sound/intensity [0.0-1.0]
/neuroprison/visual/distortion [0.0-1.0]
/neuroprison/performer/cue [string]
```

## Phase 1 Deliverables

1. Single-participant biometric capture working
2. Basic OSC routing established
3. Simple rule-based AI responding to stress levels
4. 5-minute proof-of-concept demo

## Ethical Safeguards

- Clear opt-out mechanism (physical button/gesture)
- Data not stored beyond performance
- Informed consent documentation
- Intensity limits on all outputs
