// NEUROPRISON - Stochastic Soundscape Engine
// Biometric-driven audio synthesis
// Robert B. Lisek

(
// Boot server with multi-channel output
s.options.numOutputBusChannels = 8;
s.boot;
)

(
// OSC responders for biometric data
~stress = 0.5;
~focus = 0.5;
~collectiveCompliance = 0.5;

OSCdef(\stress, { |msg|
    ~stress = msg[1].clip(0, 1);
}, '/neuroprison/collective/stress');

OSCdef(\focus, { |msg|
    ~focus = msg[1].clip(0, 1);
}, '/neuroprison/eeg/focus');

OSCdef(\compliance, { |msg|
    ~collectiveCompliance = msg[1].clip(0, 1);
}, '/neuroprison/collective/compliance');
)

// Server Drone - modulated by collective stress
(
SynthDef(\serverNoise, {
    arg out=0, amp=0.3, stress=0.5;
    var sig, freq, mod;
    freq = LFNoise1.kr(0.1).range(40, 80);
    mod = LFNoise2.kr(stress.linlin(0, 1, 0.5, 8));
    sig = LFSaw.ar(freq * mod, 0, 0.3);
    sig = sig + BrownNoise.ar(stress * 0.2);
    sig = RLPF.ar(sig, stress.linexp(0, 1, 200, 2000), 0.3);
    sig = sig * amp * EnvGen.kr(Env.asr(2, 1, 2));
    Out.ar(out, sig ! 2);
}).add;
)

// Heartbeat Distortion - modulated by GSR arousal
(
SynthDef(\heartbeat, {
    arg out=0, amp=0.4, rate=1, distortion=0.5;
    var sig, env, freq;
    freq = rate.linlin(0, 1, 0.8, 2.5);
    env = EnvGen.kr(
        Env.perc(0.01, 0.3),
        Impulse.kr(freq),
        levelScale: amp
    );
    sig = SinOsc.ar(60) * env;
    sig = sig + (SinOsc.ar(120) * env * 0.5);
    sig = (sig * (1 + (distortion * 10))).tanh;
    sig = RLPF.ar(sig, distortion.linexp(0, 1, 100, 400), 0.5);
    Out.ar(out, Pan2.ar(sig, 0));
}).add;
)

// Warden Voice Intensity Control
(
SynthDef(\wardenAmbience, {
    arg out=0, amp=0.2, intensity=0.5;
    var sig, mod;
    mod = SinOsc.kr(intensity.linlin(0, 1, 0.1, 2)).range(0.5, 1);
    sig = Formant.ar(
        intensity.linexp(0, 1, 80, 200),
        intensity.linexp(0, 1, 400, 2000),
        intensity.linexp(0, 1, 200, 800)
    );
    sig = sig * mod * amp;
    sig = FreeVerb.ar(sig, 0.8, 0.9, 0.3);
    Out.ar(out, sig ! 2);
}).add;
)

// Granular Texture - focus modulation
(
SynthDef(\focusGrain, {
    arg out=0, amp=0.3, focus=0.5;
    var sig, trig, rate;
    rate = focus.linlin(0, 1, 5, 50);
    trig = Impulse.ar(rate);
    sig = GrainSin.ar(
        2,
        trig,
        focus.linlin(0, 1, 0.1, 0.01),
        TRand.ar(200, 2000, trig),
        0
    );
    sig = sig * amp * focus;
    Out.ar(out, sig);
}).add;
)

// Main performance control
(
~startPerformance = {
    ~serverSynth = Synth(\serverNoise);
    ~heartSynth = Synth(\heartbeat);
    ~wardenSynth = Synth(\wardenAmbience);
    ~focusSynth = Synth(\focusGrain);

    // Update loop - reads biometric values
    ~updateTask = Task({
        loop {
            ~serverSynth.set(\stress, ~stress);
            ~heartSynth.set(\rate, ~stress, \distortion, ~stress);
            ~wardenSynth.set(\intensity, 1 - ~collectiveCompliance);
            ~focusSynth.set(\focus, ~focus);
            0.1.wait;
        }
    }).play;
};

~stopPerformance = {
    ~updateTask.stop;
    ~serverSynth.free;
    ~heartSynth.free;
    ~wardenSynth.free;
    ~focusSynth.free;
};
)

// Test with simulated data
(
~testMode = {
    Task({
        loop {
            ~stress = (sin(thisThread.seconds * 0.2) + 1) / 2;
            ~focus = (sin(thisThread.seconds * 0.15 + 1) + 1) / 2;
            ~collectiveCompliance = (sin(thisThread.seconds * 0.1 + 2) + 1) / 2;
            0.05.wait;
        }
    }).play;
};
)

// To run:
// ~startPerformance.value;
// ~testMode.value;  // for testing without sensors
// ~stopPerformance.value;  // to stop
