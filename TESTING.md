# Testing and Usage Guide

## Overview

This repository contains audio synthesis and algorithmic composition examples for three audio programming environments:

- **SuperCollider** (.scd files) - Sound synthesis and algorithmic composition
- **Pure Data** (.pd files) - Visual audio programming patches
- **Max/MSP** (.maxpat files) - Interactive audio/visual patches

## Prerequisites

Install the appropriate software for the files you want to use:

| File Type | Software | Download |
|-----------|----------|----------|
| `.scd` | SuperCollider | https://supercollider.github.io/ |
| `.pd` | Pure Data | https://puredata.info/ |
| `.maxpat` | Max/MSP | https://cycling74.com/products/max |

## Testing SuperCollider Files (.scd)

### Step-by-Step Instructions

1. **Launch SuperCollider IDE**

2. **Boot the audio server**
   - Press `Cmd+B` (Mac) or `Ctrl+B` (Windows/Linux)
   - Or execute: `s.boot;`

3. **Open a .scd file** (e.g., `0Basics.scd`)

4. **Execute code blocks**
   - Place cursor inside parentheses `( ... )`
   - Double-click to select the block
   - Press `Cmd+Enter` (Mac) or `Ctrl+Enter` (Win/Linux)

5. **Stop all sounds**
   - Press `Cmd+.` (Mac) or `Ctrl+.` (Win/Linux)

### Example Test

```supercollider
// Boot server first, then run this:
{ SinOsc.ar(440, 0, 0.2) }.play;
```

### Key Files to Start With

- `0Basics.scd` - Fundamental synthesis examples
- `0SC_0.scd` - Additional basics
- `SC_MODULATION.scd` - Modulation synthesis
- `SC_MarkovSynth.scd` - Algorithmic composition

## Testing Pure Data Files (.pd)

### Step-by-Step Instructions

1. **Launch Pure Data**

2. **Open a .pd file** (e.g., `pd_fluid.pd`)

3. **Enable DSP**
   - Menu: Media → DSP On
   - Or click the DSP toggle in the main window

4. **Interact with the patch**
   - Click bang objects (circles)
   - Adjust sliders and number boxes
   - Toggle switches on/off

5. **Stop audio**
   - Menu: Media → DSP Off

### Key Files to Start With

- `pd_fluid.pd` - Fluid synthesis
- `pd_DDSP_VST.pd` - DDSP integration
- `grannie-basher.pd` - Granular synthesis

## Testing Max/MSP Files (.maxpat)

### Step-by-Step Instructions

1. **Launch Max/MSP**

2. **Open a .maxpat file**

3. **Enable audio**
   - Click "Audio On" button (or use Options → Audio Status)

4. **Lock the patcher** (if in edit mode)
   - Press `Cmd+E` (Mac) or `Ctrl+E` (Win)

5. **Interact with UI elements**
   - Click buttons, adjust sliders, toggle switches

### Key Files to Start With

- `classification-video-demo.maxpat` - Classification demo
- `regressor-video-demo.maxpat` - Regression demo
- Files in `MaxMsp02_Alice Eldridge and Chris Kiefer Examples/` folder

## Troubleshooting

### No Sound in SuperCollider
- Ensure server is booted (`s.boot;`)
- Check Post window for errors
- Verify audio output device in Preferences

### No Sound in Pure Data
- Ensure DSP is enabled
- Check Media → Audio Settings for correct device
- Look for error messages in Pd console

### No Sound in Max/MSP
- Ensure Audio is On (check Audio Status window)
- Verify output device in Options → Audio Status

## Notes

- These are creative/educational examples, not production software
- Some patches may require additional libraries or quarks
- Audio levels vary - start with low volume
