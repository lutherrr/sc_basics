# NEUROPRISON Sensor System

## Overview

A network of 20+ sensors creates a rich, real-time data body of the audience.

---

## Sensor 1: EEG (Brainwaves)

### Device: Muse 2 Headband
- **Price**: ~$250 USD
- **Connectivity**: Bluetooth LE
- **Channels**: 4 EEG electrodes (TP9, AF7, AF8, TP10)

### What it Measures
- **Focus**: Beta wave activity (12-30 Hz)
- **Relaxation**: Alpha wave activity (8-12 Hz)
- **Raw EEG**: Full spectrum data

### Data Streaming
```python
from muselsl import stream, list_muses

muses = list_muses()
stream(muses[0]['address'])
# Streams to LSL at 256 Hz
```

### Role in NEUROPRISON
Provides the "collective focus" metric for the AI Warden. Audience mental engagement directly influences system narration and pacing.

---

## Sensor 2: GSR (Skin Conductivity)

### Device: BITalino Kit
- **Price**: ~$150-200 USD
- **Connectivity**: Bluetooth
- **Resolution**: 10-bit ADC

### What it Measures
- **Electrodermal Activity (EDA)**: Skin conductance response
- **Arousal**: Stress and emotional activation
- **Baseline**: Tonic skin conductance level

### Data Streaming
```python
import bitalino

device = bitalino.BITalino("MAC_ADDRESS")
device.start(1000, [0])  # 1000 Hz, channel 0 (EDA)
data = device.read(100)
```

### Role in NEUROPRISON
Core "stress" signal. Collective anxiety modulates soundscape intensity and AI voice aggression.

---

## Sensor 3: Eye-Tracking (Gaze)

### Solution: Software-based / Inferred
- **Option A**: Webcam + OpenCV/MediaPipe
- **Option B**: Tobii Eye Tracker 5 (~$230)
- **Option C**: Inferred from head position (Muse accelerometer)

### What it Measures
- **Gaze Direction**: Where attention is focused
- **Fixation Duration**: Length of attention on targets
- **Saccades**: Rapid eye movements

### Role in NEUROPRISON
Secondary data stream. Informs system where attention is focused, potentially guiding performers or highlighting individuals in "Quantum Mirror."

---

## Data Flow Architecture

```
[Muse 2] ──Bluetooth──> [LSL Stream] ──>
                                         │
[BITalino] ──Bluetooth──> [Python] ───>  ├──> [OSC Aggregator] ──> [AI Conductor]
                                         │
[Eye-tracker] ──USB/BT──> [OpenCV] ──>
```

## Collective Metrics

### Computed Values
```python
collective_stress = mean([p.gsr_normalized for p in participants])
collective_focus = mean([p.eeg_focus for p in participants])
collective_compliance = weighted_avg(stress, focus, gaze_conformity)
risk_score = ai_model.predict(collective_state)
```

### Thresholds
| Metric | Low | Medium | High | Critical |
|--------|-----|--------|------|----------|
| Stress | 0-0.25 | 0.25-0.5 | 0.5-0.75 | 0.75-1.0 |
| Focus | 0-0.25 | 0.25-0.5 | 0.5-0.75 | 0.75-1.0 |

---

## Procurement List

### Phase 1 (Proof of Concept)
- 3x Muse 2 Headband: $750
- 3x BITalino EDA Kit: $450
- **Total**: ~$1,200

### Full Deployment (20-25 participants)
- 25x Muse 2: $6,250
- 25x BITalino: $3,750
- 5x Spare units: $2,000
- **Total**: ~$12,000
