//Stereophonic FM synth;
//by Rino Petrozziello, 2018;

(
SynthDef.new(\FMSynth, {
arg carrier = 35, ratio=1.01, mod=1, amp=0.2;
var expr1, expr2, expr3;
var trig1, trig2, sr, x, y;
var wave1, wave2L, wave2R;
expr1 = carrier.midicps * ratio;
trig1 = Impulse.ar(expr1);
sr = SampleRate.ir;
x = Phasor.ar(trig1, expr1/sr);
wave1 = sin(x*3.141593*2);
expr2 = wave1 * (mod*100);
expr3 = carrier.midicps + expr2;
trig2 = Impulse.ar(expr3);
y = Phasor.ar(trig2, expr3/sr);
wave2L = sin(y*3.141593*2);
wave2R = cos(y*3.141593*2);
Out.ar(0, wave2L * amp);
Out.ar(1, wave2R * amp);
}).add;
)

x = Synth.new(\FMSynth);

(
x.set(\carrier, 45);
x.set(\ratio, 1.01);
x.set(\mod, 5);
x.set(\amp, 0.2);
)

x.free;