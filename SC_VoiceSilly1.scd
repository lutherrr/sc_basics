////////////////////////////////////////////
// Silly formant synthesis example.
// Using Pmono or Pbind to create a voice.
// SynthDef is hardwired to bass formants.

// Evaluate SynthDef first, then scroll down for examples

(
// SynthDef
SynthDef("sillyVoice", { arg
	freq = 220,
	amp = 0.5,
	vibratoSpeed = 6,
	vibratoDepth = 4,
	vowel = 0,
	att = 0.01,
	rel = 0.1,
	pos = 0,
	gate = 1;

	var in, vibrato, above, below, env, va, ve, vi, vo, vu, snd;

	// calculate vibrato
	// vibratoDepth is number of semitones to go up and down
	above = (freq.cpsmidi + vibratoDepth).midicps - freq;
	below = (freq.cpsmidi - vibratoDepth).midicps - freq;
	vibrato = SinOsc.kr(vibratoSpeed).range(below, above);
	// this is the basic sound source
	in = Saw.ar(Lag.kr(freq) + vibrato);
	// amplitude envelope
	env = Env.asr(att, amp, rel).kr(doneAction: 2, gate: gate);

	va = BBandPass.ar(
		in: in,
		freq: [ 600, 1040, 2250, 2450, 2750 ],
		bw: [ 0.1, 0.0673, 0.0488, 0.0489, 0.0472 ],
		mul: [ 1, 0.4466, 0.3548, 0.3548, 0.1 ]);

	ve = BBandPass.ar(
		in: in,
		freq: [ 400, 1620, 2400, 2800, 3100 ] ,
		bw: [ 0.1, 0.0494, 0.0417, 0.0429, 0.0387 ],
		mul: [ 1, 0.2512, 0.3548, 0.2512, 0.1259 ]);

	vi = BBandPass.ar(
		in: in,
		freq: [ 250, 1750, 2600, 3050, 3340 ] ,
		bw: [ 0.24, 0.0514, 0.0385, 0.0393, 0.0359 ],
		mul: [ 1, 0.0316, 0.1585, 0.0794, 0.0398 ] );

	vo = BBandPass.ar(
		in: in,
		freq:[ 400, 750, 2400, 2600, 2900 ] ,
		bw: [ 0.1, 0.1067, 0.0417, 0.0462, 0.0414 ],
		mul: [ 1, 0.2818, 0.0891, 0.1, 0.01 ]);

	vu = BBandPass.ar(
		in: in,
		freq: [ 350, 600, 2400, 2675, 2950 ],
		bw: [ 0.1143, 0.1333, 0.0417, 0.0449, 0.0407 ],
		mul: [ 1, 0.1, 0.0251, 0.0398, 0.0158 ]);

	snd = SelectX.ar(Lag.kr(vowel, 0.3), [va, ve, vi, vo, vu]);
	snd = Pan2.ar(Mix(snd), pos);
	Out.ar(0, snd * env * 2);
}).add;
)

// Play around with these examples/
// Vowels a e i o u correspond to number 0 1 2 3 4

// Example 1
(
Pbind(
	\instrument, "sillyVoice",
	\note, Pseq([0, -5, -3, -8, -7, 0, -7, -5], inf),
	\ctranspose, -12,
	\dur, 1,
	\amp, 1,
	\vibratoSpeed, 6,
	\vibratoDepth, 1, // in semitones
	\vowel, Pseq([0, 1, 2, 3, 4], inf),
	\legato, 1,
	\att, 0.1,
	\rel, 0.1,
	\pos, Pwhite(-1, 1.0)
).play;
)


// Example 2
(
Pbind(
	\instrument, "sillyVoice",
	\note, Prand([0, 5, 7, 9, -11, -7], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 1,
	\vibratoSpeed, Pwhite(6,8),
	\vibratoDepth, Pwhite(0.5, 1.5),
	\vowel, Pwrand([0, 1, 3], [0.8, 0.1, 0.1], inf),
	\legato, 2, // notes overlap
	\att, 1.1, // softer attack
	\rel, 2.5
).play;
)

// Example 3: using Pmono
(
Pmono(
	"sillyVoice",
	\note, Pseq([-5, -3, -1, 0], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.5, 1.0),
	\amp, 1,
	\vibratoSpeed, Pwhite(6,7),
	\vibratoDepth, 1,
	\vowel, Prand([0, 1, 2, 3, 4], inf),
	\lag, 0.3
).play;
)

////////////////////OTHER

////////////////////////////////////////////
// Silly formant synthesis example.
// Using Pmono or Pbind to create a voice.
// SynthDef is hardwired to bass formants.

// Evaluate SynthDef first, then scroll down for Pmono and Pbind.

(
// SynthDef
SynthDef("sillyVoice", { arg
	freq = 220,
	amp = 0.5,
	vibratoSpeed = 6,
	vibratoDepth = 4,
	vowel = 0,
	att = 0.01,
	rel = 0.1,
	lag = 1,
	gate = 1;

	var in, vibrato, env, va, ve, vi, vo, vu, snd;

	vibrato = SinOsc.kr(vibratoSpeed, mul: vibratoDepth);
	in = Saw.ar(Lag.kr(freq, lag) + vibrato);
	env = EnvGen.kr(Env.asr(att, 1, rel), gate, doneAction: 2);

	va = BBandPass.ar(
		in: in,
		freq: [ 600, 1040, 2250, 2450, 2750 ],
		bw: [ 0.1, 0.067307692307692, 0.048888888888889, 0.048979591836735, 0.047272727272727 ],
		mul: [ 1, 0.44668359215096, 0.35481338923358, 0.35481338923358, 0.1 ]);

	ve = BBandPass.ar(
		in: in,
		freq: [ 400, 1620, 2400, 2800, 3100 ] ,
		bw: [ 0.1, 0.049382716049383, 0.041666666666667, 0.042857142857143, 0.038709677419355 ],
		mul: [ 1, 0.25118864315096, 0.35481338923358, 0.25118864315096, 0.12589254117942 ]);

	vi = BBandPass.ar(
		in: in,
		freq: [ 250, 1750, 2600, 3050, 3340 ] ,
		bw: [ 0.24, 0.051428571428571, 0.038461538461538, 0.039344262295082, 0.035928143712575 ],
		mul: [ 1, 0.031622776601684, 0.15848931924611, 0.079432823472428, 0.03981071705535 ] );

	vo = BBandPass.ar(
		in: in,
		freq:[ 400, 750, 2400, 2600, 2900 ] ,
		bw: [ 0.1, 0.10666666666667, 0.041666666666667, 0.046153846153846, 0.041379310344828 ],
		mul: [ 1, 0.28183829312645, 0.089125093813375, 0.1, 0.01 ]);

	vu = BBandPass.ar(
		in: in,
		freq: [ 350, 600, 2400, 2675, 2950 ],
		bw: [ 0.11428571428571, 0.13333333333333, 0.041666666666667, 0.044859813084112, 0.040677966101695 ],
		mul: [ 1, 0.1, 0.025118864315096, 0.03981071705535, 0.015848931924611 ]);

	snd = SelectX.ar(Lag.kr(vowel, lag), [va, ve, vi, vo, vu]);
	snd = Mix.new(snd);
	Out.ar(0, snd!2 * env * amp);
}).add;
)


// Play around with these examples/
// Vowels a e i o u correspond to number 0 1 2 3 4

// Example 1
(
Pmono(
	"sillyVoice",
	\note, Pseq([5, 7, 9, 11], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,7),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 2], [0.8, 0.2], inf),
	\lag, 0.5
).play;
)

// Example 2
(
Pmono(
	"sillyVoice",
	\note, Pseq([-5, -3, -1, 0], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,7),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 1], [0.8, 0.2], inf),
	\lag, 0.5
).play;
)

// Example 3
(
Pbind(
	\instrument, "sillyVoice",
	\note, Prand([0, 5, 7, 9], inf),
	\ctranspose, -14,
	\dur, Pwhite(0.61, 1.7),
	\amp, 0.2,
	\vibratoSpeed, Pwhite(6,8),
	\vibratoDepth, 4,
	\vowel, Pwrand([0, 1], [0.8, 0.2], inf),
	\legato, 1,
	\att, 1.1,
	\rel, 2.5
).play;
)