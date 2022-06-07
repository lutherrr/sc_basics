{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;{disc};;

Basic Vocabulary: Generating values



Before getting to the really cool things patterns can do, we need to build up a basic vocabulary. We'll start with some words, then move into phrases in the next tutorial.

Some of the patterns will be demonstrated with a Pbind construct. This is a taste of things to come -- sequencing sonic events using patterns. Don't worry about how Pbind works just yet... all in good time.

Let's start with a very quick reference of some basic patterns. More complete descriptions follow this list. The list might seem long at first, but concentrate your attention on patterns marked with a star. Those are the most basic, and commonly used. Again, the purpose is to start learning the vocabulary of patterns -- like learning new words when studying a human language.

This document describes a lot of patterns, but what I call "primary patterns" are the most important. If you are new to patterns, concentrate on these first. You can always come back and look at the rest later.

For more information on any of these patterns, select the class name and use the help key for your editor to open its help file.




Quick reference





Primary Patterns



Pseq(list, repeats, offset): Play through the entire list 'repeats' times. Like list.do.
Prand(list, repeats): Choose items from the list randomly (same as list.choose).
Pxrand(list, repeats): Choose randomly, but never repeat the same item twice.
Pshuf(list, repeats): Shuffle the list in random order, and use the same random order 'repeats' times. Like list.scramble.
Pwrand(list, weights, repeats): Choose randomly by weighted probabilities (like list.wchoose(weights)).





Pseries(start, step, length): Arithmetic series (addition).
Pgeom(start, grow, length): Geometric series (multiplication).





Pwhite(lo, hi, length): Random numbers, equal distribution ("white noise"). Like rrand(lo, hi).
Pexprand(lo, hi, length): Random numbers, exponential distribution. Like exprand(lo, hi).
Pbrown(lo, hi, step, length): Brownian motion, arithmetic scale (addition).





Pfunc(nextFunc, resetFunc): Get the stream values from a user-supplied function.
Pfuncn(func, repeats): Get values from the function, but stop after 'repeats' items.
Proutine(routineFunc): Use the function like a routine. The function should return values using .yield or .embedInStream.






Additional List Patterns



repeats, offset): Play through the list as many times as needed, but output only 'repeats' items.
repeats, len, step, start, wrapAtEnd): Play overlapping segments from the list.





stepPattern, directionPattern, startPos): Random walk over the list.





repeats, offset): Interlace any arrays found in the main list.
repeats, offset): Interlace any patterns found in the main list.
repeats): Collect the list items into an array as the return value.






Additional Random Number Generators



hi, step, length): Brownian motion, geometric scale (multiplication).





hi, prob1, prob2, length): Beta distribution, where prob1 =  (alpha) and prob2 =  (beta).
spread, length): Cauchy distribution.
dev, length): Guassian (normal) distribution.
hi, length): Returns the greater of two equal-distribution random numbers.
hi, length): Returns the lesser of two equal-distribution random numbers.
hi, length): Returns the average of two equal-distribution random numbers, i.e., (x +  y) / 2.
length): Poisson distribution.





lo, hi, length, tableSize): Arbitrary distribution, based on a probability table.





Random numbers and probability distributions



hi, length): Produces 'length' random numbers with equal distribution ('white' refers to white noise).
hi, length): Same, but the random numbers have an exponential distribution, favoring lower numbers. This is good for frequencies, and also durations (because you need more notes with a shorter duration to balance the weight of longer notes).
hi, step, length): Brownian motion. Each value adds a random step to the previous value, where the step has an equal distribution between -step and +step.
hi, step, length): Brownian motion on a geometric scale. Each value multiplies a random step factor to the previous value.





hi, prob1, prob2, length): Beta distribution, where prob1 =  (alpha) and prob2 =  (beta).
spread, length): Cauchy distribution.
dev, length): Guassian (normal) distribution.
hi, length): Returns the greater of two equal-distribution random numbers.
hi, length): Returns the lesser of two equal-distribution random numbers.
hi, length): Returns the average of two equal-distribution random numbers, i.e., (x + y) / 2.
length): Poisson distribution.





lo, hi, length, tableSize): Given an array of relative probabilities across the desired range (a histogram) representing an arbitrary distribution, generates random numbers corresponding to that distribution.



To see a distribution, make a histogram out of it.



Pwhite(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;


Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;


Pexprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;


Pbrown(0.0, 1.0, 0.1, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pgbrown(0.0, 1.0, 0.1, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pbeta(0.0, 1.0, 1, 3, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pcauchy(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Phprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Plprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Ppoisson(0.0001, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pprob((Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0)), 0.0, 1.0, inf, 100).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;




Functional descriptions of patterns





List Patterns



The most obvious thing one would want to do with a pattern is to give it a list of values and have it read them out in order. You have a couple of choices, which differ in their handling of the 'repeats' parameter.



Pseq(list, repeats, offset): Play through the entire list 'repeats' times.
Pser(list, repeats, offset): Play through the list as many times as needed, but output only 'repeats' items.



Pseq(#[1, 2, 3], 4).asStream.all;	// 12 items = 4 repeats * 3 items
Pser(#[1, 2, 3], 4).asStream.all;	// 4 items only





"http://help.sccode.org/Streams-Patterns-Events/Patterns/Pseq.html"Pseq is an obvious choice for streaming out known pitch and rhythm values.

Before playing a Pbind pattern such as this, make sure the server is booted.



s.boot;

(
p = Pbind(
	\degree, Pseq(#[0, 0, 4, 4, 5, 5, 4], 1),
	\dur, Pseq(#[0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1], 1)
).play;
)



To stop the examples in this file, use the "stop" keyboard shortcut (cmd-. on Mac OSX, alt-. on Windows, check documentation for other editors). Or:



p.stop;



A variation, "http://help.sccode.org/Streams-Patterns-Events/Patterns/Pslide.html"Pslide, plays overlapping segments of the input list.



Pslide(list, repeats, len, step, start, wrapAtEnd)
repeats: 	number of segments
len:		length of each segment
step:		is how far to step the start of each segment from previous.
start:		what index to start at.
wrapAtEnd: if true (default), indexing wraps around if goes past beginning or end. If false, the pattern stops if it hits a nil element or goes outside the list bounds.

If step == 1, then the first segment is at 'start', the second at 'start' + 1, and so on.



Pslide(#[1, 2, 3, 4, 5, 6, 7, 8], 10, 3, 1, 0, false).asStream.all;



// or, to show the segments as separate arrays


Pslide(#[1, 2, 3, 4, 5, 6, 7, 8], 10, 3, 1, 0, false).clump(3).asStream.all;



// Flock of Seagulls!


(
p = Pbind(
	\degree, Pslide((-6, -4 .. 12), 8, 3, 1, 0),
	\dur, Pseq(#[0.1, 0.1, 0.2], inf),
	\sustain, 0.15
).play;
)





Random-order list patterns

Prand(list, repeats): Choose items from the list randomly (same as list.choose).



// Prand: given scale degrees (pentatonic) with equal probability of each


(
p = Pbind(
	\degree, Prand([0, 1, 2, 4, 5], inf),
	\dur, 0.25
).play;
)





Pxrand(list, repeats): Choose randomly, but never repeat the same item twice in immediate succession.



// Pxrand: same as above but never repeats a pitch twice in a row


(
p = Pbind(
	\degree, Pxrand([0, 1, 2, 4, 5], inf),
	\dur, 0.25
).play;
)





Pshuf(list, repeats): Shuffle the list in random order, and use the same random order 'repeats' times. Like list.scramble.



// Pshuf: randomly ordered once and repeated


(
p = Pbind(
	\degree, Pshuf([0, 1, 2, 4, 5], inf),
	\dur, 0.25
).play;
)





Pwrand(list, weights, repeats): Choose randomly, according to weighted probabilities (same as list.wchoose(weights)).



// Pwrand: these probabilities favor triadic notes from scale degrees


(
p = Noise(
	\degree, Pwrand((0..7), [4, 1, 3, 1, 3, 2, 1].normalizeSum, inf),
	\dur, 0.25
).play;
)




PIANO PGBROWN DISTRIBUTION





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






Pwalk(list, stepPattern, directionPattern, startPos): Random walk over the list. This pattern is a bit more complicated; see its help file for details.




Interlacing values and making arrays



These are opposing operations: interlacing means splitting arrays and merging them into a stream of single values, and arrays can be made out of single-value streams as well.



Place(list, repeats, offset): Take one from each item in the main array item in succession. Hard to explain, easier to see:



Place([0, [1, 2], [3, 4, 5]], 3).asStream.all;
--> [ 0, 1, 3, 0, 2, 4, 0, 1, 5 ]



If we turn this into a matrix and read vertically, the original arrays are clearly visible:



Place([0, [1, 2], [3, 4, 5]], 3).clump(3).do(_.postln);

[ 0, 1, 3 ]	// leftmost column: 0 from first Place item
[ 0, 2, 4 ]	// second column: alternates between 1 and 2, from second Place item
[ 0, 1, 5 ]	// third column: 3, 4, 5 from third Place item





Ppatlace(list, repeats, offset): Take one value from each sub-pattern in order.



// Hanon exercise


(
p = Pbind(
	\degree, Ppatlace([
		Pseries(0, 1, 8),		// first, third etc. notes
		Pseries(2, 1, 7)		// second, fourth etc. notes
	], inf),
	\dur, 0.25
).play;
)



That's also a taste of things to come: Patterns can be nested.



Ptuple(list, repeats): Get one value from each item in the array, and return all of them as an array of values.



// Chords
// \degree receives [7, 9, 4], then [6, 7, 4] successively, expanded to chords on the server


(
p = Pbind(
	\degree, Ptuple([
		Pseries(7, -1, 8),
		Pseq([9, 7, 7, 7, 4, 4, 2, 2], 1),
		Pseq([4, 4, 4, 2, 2, 0, 0, -3], 1)
	], 1),
	\dur, 1
).play;
)




Ptuple(list, repeats): Get one value from each item in the array, and return all of them as an array of values.



// Chords
// \degree receives [7, 9, 4], then [6, 7, 4] successively, expanded to chords on the server


(
p = Pbind(
	\degree, Ptuple([
		Pseries(7, -1, 8),
		Pseq([9, 7, 7, 0.068047149782946, 0.097609503892181, 2, 2], 1),
		Pseq([4, 4, 4, 0.17145443631153, 0.18544098027668, 0.19847170532612], 1)
	], 1),
	\dur, 1
).play;
)





Generating values





Arithmetic and geometric series

Now, let's move to patterns that produce values mathematically, without using a predefined list.

Pseries(start, step, length): Arithmetic series, successively adding 'step' to the starting value, returning a total of 'length' items.
Pgeom(start, grow, length): Geometric series, successively multiplying the current value by 'grow'.



// Use Pseries for a scale and Pgeom for an accelerando


(
p = Pbind(
	\degree, Pseries(-7, 1, 15),
	\dur, Pgeom(0.5, 0.89140193218427, 15)
).play;
)





Third-party extension alert: If you want an arithmetic or geometric series to start at one number and end at another specific number, the step size/multiplier must be calculated from the endpoints and the number of items desired. The ddwPatterns quark includes a convenience method, fromEndpoints, for both Pseries and Pgeom that performs this calculation. It's necessary to give an exact number of repeats, at least two and less than infinity.



p = Pgeom.fromEndpoints(0.5, 0.1, 15);	// error if ddwPatterns not installed
p.postcs;



Prints:


Pgeom(0.5, 0.89140193218427, 15)






Random numbers and probability distributions



hi, length): Produces 'length' random numbers with equal distribution ('white' refers to white noise).
hi, length): Same, but the random numbers have an exponential distribution, favoring lower numbers. This is good for frequencies, and also durations (because you need more notes with a shorter duration to balance the weight of longer notes).
hi, step, length): Brownian motion. Each value adds a random step to the previous value, where the step has an equal distribution between -step and +step.
hi, step, length): Brownian motion on a geometric scale. Each value multiplies a random step factor to the previous value.





hi, prob1, prob2, length): Beta distribution, where prob1 =  (alpha) and prob2 =  (beta).
spread, length): Cauchy distribution.
dev, length): Guassian (normal) distribution.
hi, length): Returns the greater of two equal-distribution random numbers.
hi, length): Returns the lesser of two equal-distribution random numbers.
hi, length): Returns the average of two equal-distribution random numbers, i.e., (x + y) / 2.
length): Poisson distribution.





lo, hi, length, tableSize): Given an array of relative probabilities across the desired range (a histogram) representing an arbitrary distribution, generates random numbers corresponding to that distribution.



To see a distribution, make a histogram out of it.



Pwhite(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;


Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pexprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pbrown(0.0, 1.0, 0.1, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pgbrown(0.0, 1.0, 0.1, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pbeta(0.0, 1.0, 1, 3, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pcauchy(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Phprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Plprand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Ppoisson(0.0001, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pprob((Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0)), 0.0, 1.0, inf, 100).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;
Pmeanrand(0.0, 1.0, inf).asStream.nextN(10000).histo(200, 0.0, 1.0).plot;

















M



Pbrown(0.0, 1.0, 0.1, inf).asStream.nextN(100)

(
p = Pbind(
	\degree, Ppatlace([
		 0.76495883464813, 0.79431092739105, 0.84242269992828, 0.85245070457458, 0.91813497543335, 0.9447732925415, 0.99615490436554, 0.98666462898254, 0.94673218727112, 0.99808065891266, 0.93810284137726, 0.92610540390015, 0.97790050506592, 0.96269376277924, 0.88132109642029, 0.97059926986694, 0.94373598098755, 0.99126493930817, 0.95556571483612, 0.94604728221893, 0.90615334510803, 0.81338424682617, 0.89738013744354, 0.9719605922699, 0.8831235408783, 0.81825168132782, 0.74042339324951, 0.64816992282867		// second, fourth etc. notes
	], inf),
	\dur, 0.25
).play;
)
=====


UWAGA! PIANO PBROWN DISTRIBUTION





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
		\midinote, Pbrown(24, 36, 0.5, inf).round,
	\dur, 0.2,
		\octave, 3,
		\root, 3,
		\vel, Pwhite(50, 100, inf),
		\legato, 0.95
	)
], inf).play
)



===========


Pwhite(lo, hi, length)

		lo, hi			lower and upper boundary of values (default: 0.0 and 1.0)
		length		number of values produced  (default: inf)



PIANO PWHITE DISTRIBUTION

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
		\midinote, Pwhite(50, 100, inf),
	\dur, 0.2,
		\octave, 3,
		\root, 3,
		\vel, Pwhite(50, 100, inf),
		\legato, 0.95
	)
], inf).play
)




// example




(


var a;
a = Pwhite(0.0, 1.0, inf);
c = a.asStream.nextN(500);
w = Window.new("Pwhite", Rect(10, 10, 540, 800));


// plot the values


c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);


// a histogram of the values


c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
)

(


var a;
a = Pwhite(0.0, 1.0, inf);
a.asStream.nextN(1000).plot;
)




// sound example


(


SynthDef(\help_sinegrain,


	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)


(


var a;
a = Pwhite(0.0, 1.0, inf).asStream;
{
	loop {
		Synth(\help_sinegrain, [\freq, a.next * 200 + 300]);
		0.02.wait;
	}
}.fork;
)



// this is equivalent to:


(
{
	loop {
		Synth(\help_sinegrain, [\freq, rrand(0.0, 1.0) * 600 + 300]);
		0.02.wait;
	}
}.fork;
)










===Pbrown


(


var a;
a = Pbrown(0.0, 1.0, 0.1, inf);
c = a.asStream.nextN(500);
w = Window.new("Pbrown", Rect(10, 10, 540, 800));
// plot the values


c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);


// a histogram of the values


c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
)

(


var a;
a = Pbrown(0.0, 1.0, 0.2, inf);
a.asStream.nextN(1000).plot;
)


// sound example


(


SynthDef(\help_sinegrain,


	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)


(


var a;
a = Pbrown(0.0, 1.0, 0.1, inf).asStream;
{
	loop {
		Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
		0.02.wait;
	}
}.fork;
)



// parallel browninan motions


(


var a, x, f;
a = Pbrown(0.0, 1.0, 0.1, inf);

f = { |pattern, dt=0.02, min=300, max=900|


	{
		var x = pattern.asStream;
		loop {
			Synth.grain(\help_sinegrain, [\freq, x.next.linexp(0, 1, min, max), \sustain, dt]);
			dt.wait;
		}
	}.fork;
}.flop;



// 3 parallel motions


f.(a, [0.02, 0.08, 0.16]);
)









Plprand(0.0, 1.0, inf).asStream.nextN(10000)

(
p = Pbind(
	\degree, Ppatlace([
		 0.18499624729156, 0.87819421291351, 0.35087406635284, 0.24363338947296, 0.81097602844238, 0.35597717761993, 0.57222485542297, 0.56964504718781, 0.59950399398804, 0.16881740093231, 0.21253836154938, 0.23872709274292, 0.35012233257294, 0.22673523426056, 0.27448713779449, 0.40149891376495, 0.57712364196777, 0.21208488941193, 0.55605530738831, 0.060322403907776, 0.018023014068604, 0.67215847969055, 0.27005362510681, 0.26436507701874, 0.44128906726837, 0.62675774097443, 0.40126299858093, 0.13725066184998		// second, fourth etc. notes
	], inf),
	\dur, 0.25
).play;)
)



o= {Pan2.ar(Mix.new(Gendy3.ar(0, 0, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, [100,205,410], 0.011,0.005, 12, 12, 0.32)), 0.0)}.play;



o= {Pan2.ar(Mix.new(Gendy3.ar(0, 0, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, [100*[0.18499624729156, 0.87819421291351, 0.35087406635284, 0.24363338947296, 0.81097602844238, 0.35597717761993, 0.57222485542297, 0.56964504718781, 0.59950399398804, 0.16881740093231, 0.21253836154938, 0.23872709274292, 0.35012233257294, 0.22673523426056, 0.27448713779449, 0.40149891376495, 0.57712364196777, 0.21208488941193, 0.55605530738831, 0.060322403907776, 0.018023014068604, 0.67215847969055, 0.27005362510681, 0.26436507701874, 0.44128906726837, 0.62675774097443, 0.40126299858093, 0.13725066184998]], 0.011,0.005, 12, 12, 0.32)), 0.0)}.play;




{ Splay.ar(SinOsc.ar(1000*[0.18499624729156, 0.87819421291351, 0.35087406635284, 0.24363338947296, 0.81097602844238, 0.35597717761993, 0.57222485542297, 0.56964504718781, 0.59950399398804, 0.16881740093231, 0.21253836154938, 0.23872709274292, 0.35012233257294, 0.22673523426056, 0.27448713779449, 0.40149891376495, 0.57712364196777, 0.21208488941193, 0.55605530738831, 0.060322403907776, 0.018023014068604, 0.67215847969055, 0.27005362510681, 0.26436507701874, 0.44128906726837, 0.62675774097443, 0.40126299858093, 0.13725066184998])) }.play;











Catchall Patterns



Not everything is pre-written as a pattern class. These patterns let you embed custom logic.



Pfunc(nextFunc, resetFunc): The next value is the return value from evaluating nextFunc. If .reset is called on a stream made from this pattern, resetFunc is evaluated. The stream will run indefinitely until nextFunc returns nil.

Pfuncn(func, repeats): Like Pfunc, output values come from evaluating the function. Pfuncn, however, returns exactly 'repeats' values and then stops. The default number of repeats is 1.

Proutine(routineFunc): Use the routineFunc in a routine. The stream's output values are whatever this function .yields. Proutine ends when it yields nil.


Next, we'll look at the central pattern for audio sequencing: Pbind.

Previous:		"http://help.sccode.org/Streams-Patterns-Events/A%20Practical%20Guide/PG_01_Introduction.html"PG_01_Introduction


Next:		"http://help.sccode.org/Streams-Patterns-Events/A%20Practical%20Guide/PG_03_What_Is_Pbind.html"PG_03_What_Is_Pbind