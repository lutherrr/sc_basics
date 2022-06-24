OteyPiano
Piano physical model.
Should not use this class but OteyPianoString instead (see example) for having only one soundboard for all strings which is more efficient.

Digital wave guide physical model of a piano wrapping the code provided by Clayton Otey.

It is important to release synth once finished because because it is CPU expensive.

//example
(
x = {OteyPiano.ar(50,0.5)}.play;
)
x.free;

//Define piano synthdef
(
SynthDef(\help_oteypiano, { |out=0, freq=440,gate=1, amp=0.5,rho=1|
    var son = OteyPiano.ar(freq, amp, rho:rho)*EnvGen.ar(Env.asr(0,1,0.1),gate,doneAction:2);
    Out.ar(out, Pan2.ar(son * 0.1, LinLin.kr(freq,36.midicps,90.midicps,-0.75,0.75)));
}).add;
)

//Use it.
(
Pbind(
    \instrument, \help_oteypiano,
    \delta, 1,
    \dur, 3,
    \degree, Pseq([1,3,5], inf),
    \rho, Pwhite(0.1,3) //comment this line to get standard sound
).play;
)

//two
{[OteyPiano.ar(5,0.5), OteyPiano.ar(5,0.5)]}.play;