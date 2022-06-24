MdaPiano

A piano synthesiser (originally a VST plugin by Paul Kellett, ported to SC by Dan Stowell). This UGen is not polyphonic (but can be retriggered to play notes in sequence).

s.boot;

// This simple example triggers one note per second, monophonically:
(
x = {
    MdaPiano.ar(
        LFNoise0.kr(1).range(20, 60).round.midicps, // random note
        stereo: 0.5,
        gate: LFPulse.kr(1),
        vel: LFPar.kr(0.1).range(10, 100), // varying velocity
        mul: 0.2
    )
}.play
)
x.free;


// Now let's define a piano synthdef:
(
SynthDef(\help_mdapiano, { |out=0, freq=440, gate=1|
    var son = MdaPiano.ar(freq, gate, release: 0.9, stereo: 0.3, sustain: 0);
    DetectSilence.ar(son, 0.01, doneAction:2);
    Out.ar(out, son * 0.1);
}).add;
)
// Then we can use it in a pattern:
(
TempoClock.default.tempo = 1.2;
Ppar([
    Pbind(
        \instrument, \help_mdapiano,
        \degree,
            Pseq([
                0, 7, -5, 7,  0, 5, -7, 5,  -2, 5, -7, 5,  -2,  3, -9,  3,
                0, 7, -5, 7,  0, 5, -7, 5,  -2, 5, -7, 5,  -2, -3, -4, -5 ], inf),
        \dur, 0.5,
        \octave, 3,
        \root, 3,
        \vel, Prand([Pseq([100, 30, 50, 10]), Pseq([100, 30, 10, 10, 5, 10, 20, 30])], inf),
        \legato, 0.95
    ),
    Pbind(
        \instrument, \help_mdapiano,
        \degree,
            Pseq([ \, 0, -1, 0, 2, 0, \, \, \, 0, -2, \, \, -2, -4, \, \ ], inf),
        \dur, 0.5,
        \octave, 6,
        \root, 3,
        \vel, Pwhite(50, 100, inf)
    )
], inf).play
)
// Try changing the synthdef while this is running (e.g. activate sustain, tweak stereo)...