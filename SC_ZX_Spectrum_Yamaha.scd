//Emulates the General Instrument AY-3-8910 (a.k.a. the Yamaha YM2149) 3-voice sound chip, as found in the ZX Spectrum 128, the Atari ST, and various other home computers during the 1980s.

s.boot;

// Default...
x = {AY.ar * 0.1}.play(s);
x.free;

// Mouse-controlled tones
(
x = {
    Pan2.ar(AY.ar(
        tonea:     MouseY.kr(10, 3900, 1),
        toneb:     MouseX.kr(10, 3900, 1),
        control:     3,
        vola:     14,
        volb:     14,
        volc:     0,
        mul: 0.1
    ))
}.play;
)

x.free;

// A random walk in a ZX Spectrum
(
x = {
    var rate = MouseX.kr(0.1, 10); // You control your wandering speed
    Pan2.ar(AY.ar(
        tonea:     LFDNoise3.kr(rate).range(10, 3900),
        toneb:     LFDNoise3.kr(rate).range(10, 3900),
        tonec:     LFDNoise3.kr(rate).range(10, 3900),
        noise:     LFDNoise3.kr(rate).range(0, 31),
        control:     LFDNoise0.kr(rate).range(0, 31),
        vola:     LFDNoise3.kr(rate).range(0, 15),
        volb:     LFDNoise3.kr(rate).range(0, 15),
        volc:     LFDNoise3.kr(rate).range(0, 15),
        envfreq:     LFDNoise3.kr(rate).range(0, 4095),
        envstyle:     LFDNoise3.kr(rate).range(0, 15),
        mul: 0.1
    ))
}.play;
)

x.free;

// Now to define a synth which can be used in patterns etc
(
SynthDef(\ay1, { | freqa=440, freqb=550, freqc=660, vola=15, volb=0, volc=0, chink=1, wobbly=1, pan=0, amp=0.1, gate=1|
    var ay, chinkenv, wobblyenv;

    //chinkenv = if(chink>0, EnvGen.kr(Env.new([0.06125, 0.06125, 1, 1], [0.05, 0, 0.1], 0, 4, 4)), 1);
    chinkenv = if(chink>0, EnvGen.kr(Env.new([2, 2, 1, 1], [0.05, 0, 0.1], 0, 4, 4)), 1);
    wobblyenv = LFPulse.kr(10, 0.5, mul:wobbly).range(0.5, 1);

    # freqa, freqb, freqc = [freqa, freqb, freqc] * [1, wobblyenv, wobblyenv] * chinkenv;
    ay = AY.ar(AY.freqtotone(freqa), AY.freqtotone(freqb), AY.freqtotone(freqc),
        0, 3, vola, volb, volc, mul: amp);
    ay = ay * EnvGen.kr(Env.asr(0.01, 1, 0.05), gate, doneAction:2);
    Out.ar(0, Pan2.ar(ay, pan));
}).load(s);
)

x = Synth(\ay1, [\wobbly, 0, \chink, 1, \tonea, 1000.rand]);
x.free;

SynthDescLib.read;

// Use the synth in a jerky lo-fi pattern of some sort...
(
Pbind(
    \instrument, \ay1,
    \freqa,    Pseq((#[55, 55, 57, 58, 57, 55, 58, 50]-12).midicps, inf),
    \freqb,    Pseq([
                    Pseq( (#[55, 55, 54, 55, 54, 55, 58, 57]+12).midicps, 2),
                    Prand((#[55, 55, 54, 55, 54, 55, 58, 57]+12).midicps, 2)
                ], inf),
    \dur,    Pseq(#[3, 0.5, 0.5, 1.5, 0.5, 1, 1, 4] * 0.4, inf),
    \wobbly,    Pstutter(8 * 4, Prand(#[0, 1], inf)),
    \vola,    15,
    \volb,    14,
    \chink,    1,
    \amp,    0.4
).play
)