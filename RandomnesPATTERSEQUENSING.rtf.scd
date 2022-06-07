

PATTERNS01

Array.rand(100, 60,80);
Array.rand(100, 36,48);



(


SynthDef(\smooth, { |freq = 440, sustain = 1, amp = 0.5|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.linen(0.05, sustain, 0.1), doneAction: 2);
    Out.ar(0, sig ! 2)


}).add;
)


(
p = Pbind(
        // the name of the SynthDef to use for each note
    \instrument, \smooth,
        // MIDI note numbers -- converted automatically to Hz
    \midinote, Pseq([73, 63, 72, 64, 64, 65, 76, 78, 61, 76, 73, 80, 69, 69, 79, 77, 75, 79, 69, 61, 80, 60, 79, 74, 78, 62, 79, 77, 76, 66, 80, 61, 79, 73, 63, 61, 68, 75, 70, 71, 62, 77, 70, 65, 73, 68, 67, 79, 80, 60, 71, 63, 75, 61, 74, 79, 79, 60, 65, 79, 71, 60, 73, 68, 64, 64, 77, 62, 60, 68, 60, 61, 77, 68, 75, 67, 72, 62, 70, 76, 62, 66, 76, 69, 74, 78, 74, 69, 65, 67, 80, 72, 77, 79, 65, 67, 77, 77, 66, 70 ], 1),
        // rhythmic values
    \dur, Pseq([1.1364456415176, 1.2453687787056, 3.5037177801132, 1.7526358962059, 2.9249324202538, 0.56083250045776, 3.0195878744125, 2.2985454201698, 2.3809688687325, 2.2755655050278, 2.5686237812042, 1.800335586071, 1.6233518123627, 3.7245735526085, 3.311979830265, 0.98146587610245, 3.8165766596794, 0.78661704063416, 1.6260166764259, 0.86873340606689, 3.5317533016205, 1.360161960125, 2.3097159862518, 2.5555393695831, 3.9933730959892, 3.1503351926804, 0.92297446727753, 3.5411556363106, 1.6399276256561, 2.6630443334579], 1)
).play;
)




===== rrand



(


Pbind(


\dur,rrand(0.325,1.225),


	\freq, Pseq([Pfunc({ rrand(145.0,500.0) },inf), Pxrand([840, 741, 642], 2)], inf)


// Pxrand never repeats the same value from the array twice in a row


).play;
)

== Pbrown distribution
(


Pbind(


	\midinote, Pbrown(48, 72, 5, inf),
	\dur, 0.2
).play;
)

== Pgbrown distribution
(


Pbind(


	\midinote, Pgbrown(48, 72, 0.5, inf).round,
	\dur, 0.2
).play;
)


= MdaPIANO!!!

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

====== Piano Pgbrown Distribution


(
SynthDef(\help_mdapiano, { |out=0, freq=440, gate=1|
	var son = MdaPiano.ar(freq, gate, release: 0.9, stereo: 0.3, sustain: 0);
	DetectSilence.ar(son, 0.01, doneAction:2);
	Out.ar(out, son * 0.1);
}).add;
)

(


TempoClock.default.tempo = 1.2;
Ppar([


	Pbind(
		\instrument, \help_mdapiano,
		\midinote, Pgbrown(48, 72, 0.5, inf).round,
	\dur, 0.2,
		\octave, 3,
		\root, 3,
		\vel, Pgbrown(48, 72, 0.5, inf).round,
		\legato, 0.95
	),
	Pbind(
		\instrument, \help_mdapiano,
	\midinote, Pgbrown(24, 36, 0.5, inf).round,
	\dur, 0.2,
		\octave, 6,
		\root, 3,
		\vel, Pgbrown(24, 36, 0.5, inf).round
	)
], inf).play
)



// MdaPianoLatoocarfian2DC.

(
SynthDef(\help_mdapiano, { |out=0, freq=440, gate=1|
	var son = MdaPiano.ar(freq, gate, release: 0.9, stereo: 0.3, sustain: 0);
	DetectSilence.ar(son, 0.01, doneAction:2);
	Out.ar(out, son * 0.1);
}).add;
)

(
y = {
	MdaPiano.ar(
		Latoocarfian2DC.kr(1).range(20, 60).round.midicps, // random note
		stereo: 0.5,
		gate: FhnTrig.kr(8, 2*FhnTrig.kr(5, 8, 0.3, 0.3, 1, 1), 0.27, 0.27, 0.6, 0.8),
		vel: LFPar.kr(0.1).range(10, 100), // varying velocity
		mul: 0.2
	)
}.play
)

y.free;

====



Array.rand(10,0.01,0.5);
Array.rand(10,0.1,0.9);
Array.rand(10,0.1,0.9);
Array.rand(100, 0.5,4);



(


SynthDef(\bass, { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15,
        detune = 1.005, preamp = 4|
    var    sig,
        env = Env.adsr(0.15977650046349, 0.19329496622086, 0.063460744619369, 0.12358303189278, 0.17703483939171, 0.32015365242958, 0.16432047128677, 0.22015101313591, 0.37972446680069, 0.26652456283569);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort * amp
        * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)


}).add;



TempoClock.default.tempo = 132/60;

p = Pxrand([
    Pbind(
        \instrument, \bass,
        \midinote, 36,
        \dur, Pseq([0.1833948135376, 0.83628158569336, 0.80094089508057, 0.73715991973877, 0.6976788520813, 0.53407344818115, 0.34385614395142, 0.22787895202637, 0.61922311782837, 0.5110559463501], 1),
        \legato, Pseq([0.44074106216431, 0.66071825027466, 0.83578720092773, 0.66291627883911, 0.67899808883667, 0.21487836837769, 0.43043785095215, 0.71392612457275, 0.50937957763672, 0.50104026794434], 1),
        \amp, 0.5, \detune, 1.005
    ),
    Pmono(\bass,
        \midinote, Pseq([36, 48, 36], 1),
        \dur, Pseq([0.34385614395142, 0.22787895202637, 0.61922311782837,0.44074106216431, 0.66071825027466, 0.83578720092773, 0.66291627883911, 0.67899808883667, 0.21487836837769, 0.43043785095215], 1),
        \amp, 0.5, \detune, 1.005
    ),
    Pmono(\bass,
        \midinote, Pseq([44, 45, 48, 38, 46, 47, 48, 36, 42, 40, 39, 47, 38, 47, 47, 45, 43, 39, 36, 44, 45, 47, 39, 42, 37, 42], 1),
        \dur, Pseq([0.22787895202637, 0.61922311782837,0.44074106216431, 0.66071825027466, 0.83578720092773, 0.66291627883911], 1),
        \amp, 0.5, \detune, 1.005
    ),
    Pmono(\bass,
        \midinote, Pseq([46, 47, 48, 36, 42, 40, 39, 47, 38, 47, 47, 45, 43, 39, 36, 44, 45, 47, 39, 42, 37, 42, 44, 40, 44, 46, 38, 37, 38, 41, 36, 40, 43, 46, 45, 46, 37, 41, 40, 45, 36, 47, 38, 47, 43, 40, 44, 37, 44, 48, 40], 1),
        \dur, Pseq([0.66291627883911, 0.67899808883667, 0.21487836837769, 0.43043785095215, 0.7139261245727], 1),
        \amp, 0.5, \detune, 1.005
    )


], inf).play(quant: 1);
)
