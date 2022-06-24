// an interpretation of John Cage's piece 0'00" (4'33" No.2) 

play{WhiteNoise.ar(999)!2*EnvGen.ar(Env.perc(0.000001,0.001))*{{{|i|SinOsc.ar(20+(i*9),0,SinOsc.ar(2.2.rand).range(0.001,0.1))}.sum(200)}!2}}

// another interpretation

SynthDef(\zerozerozero, {Out.ar(0, 9*Impulse.ar(10)!2)}).play

y = Synth(\zerozerozero, [\Impuls, 20]);

z = Synth(\zerozerozero, [\Impuls, 5]);


w = Synth(\zerozerozero, [\Impuls, 500]);

y.free;

z.free;