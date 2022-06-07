

Randomness in SC



As in any computer program, there are no "truly random" number generators in SC.
They are pseudo-random, meaning they use very complex, but deterministic
algorithms to generate sequences of numbers that are long enough and complicated enough
to seem "random" for human beings. (i.e. the patterns are too complex for us to detect.)

If you start a random number generator algorithm with the same "seed" number
several times, you get the same sequence of random numbers.
(See example below, randomSeed)






Create single random numbers:






1. Between zero and <number>:



5.rand				// evenly distributed.

1.0.linrand			// probability decreases linearly from 0 to <number>.






2. Between -<number> and <number>:



5.0.rand2				// evenly distributed.

10.bilinrand			// probability is highest around 0,
					// decreases linearly toward +-<number>.

1.0.sum3rand			// quasi-gaussian, bell-shaped distribution.





3. Within a given range:



rrand(24, 48)			// linear distribution in the given range.

exprand(0.01, 1)		// exponential distribution;
					// both numbers must have the same sign.






Test them multiple times with a do loop:




20.do({ 5.rand.postln; });			// evenly distributed

20.do({ 1.0.linrand.postln; });		// probability decreases linearly from 0 to 1.0


20.do({ 5.0.rand2.postln; });		// even

20.do({ 10.bilinrand.postln; });		// probability is highest around 0,
							// decreases linearly toward +-<number>.

20.do({ 1.0.sum3rand.postln; });	// quasi-gaussian, bell-shaped.







Collect the results in an array:



Array.fill(10, { 1000.linrand }).postln;



// or more compact:



{ 1.0.sum3rand }.dup(100)



// or:



({ 1.0.sum3rand } ! 100)







You can seed a random generator in order to repeat
the same sequence of random numbers:



(
5.do({
	thisThread.randSeed = 4;
	Array.fill(10, { 1000.linrand}).postln;
});
)



// Just to check, no seeding:



(
5.do({ Array.fill(10, { 1000.linrand }).postln; });
)



// see also "file:///SuperCollider/Help/Core/Kernel/randomSeed.html"randomSeed.









Demonstrate the various statistical distributions visually, with histograms:

[plot may not work in non-Mac SC3 versions.]



Array.fill(500, {  1.0.rand }).plot("Sequence of 500x 1.0.rand");

Array.fill(500, {  1.0.linrand }).plot("Sequence of 500x 1.0.linrand");

Array.fill(500, {  1.0.sum3rand }).plot("Sequence of 500x 1.0.sum3rand");



// Use a histogram to display how often each (integer)
// occurs in a collection of random numbers, :


(


var randomNumbers, histogram, maxValue = 500, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.rand; });
histogram = randomNumbers.histo(numBins, 0, maxValue);
histogram.plot("histogram for rand 0 - " ++ maxValue);
)







A histogram for linrand:



(


var randomNumbers, histogram, maxValue = 500.0, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.linrand; });
histogram = randomNumbers.histo(numBins, 0, maxValue);
histogram.plot("histogram for linrand 0 - " ++ maxValue);
)





A histogram for bilinrand:



(


var randomNumbers, histogram, minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.bilinrand; });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for bilinrand" + minValue + "to" + maxValue);
)







A histogram for exprand:



(


var randomNumbers, histogram, minValue = 5.0, maxValue = 500, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { exprand(minValue, maxValue); });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for exprand: " ++ minValue ++ " to " ++ maxValue);
)






And for sum3rand (cheap quasi-gaussian):




(


var randomNumbers, histogram, minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;

randomNumbers = Array.fill(numVals, { maxValue.sum3rand; });
histogram = randomNumbers.histo(numBins, minValue, maxValue);
histogram.plot("histogram for sum3rand " ++ minValue ++ " to " ++ maxValue);
)





All of the single-number methods also work for (Sequenceable)Collections,
simply by applying the given random message to each element of the collection:



[ 1.0, 10, 100.0, \aSymbol ].rand.postln;		// note: Symbols are left as they are.


List[ 10, -3.0, \aSymbol ].sum3rand.postln;








Arbitrary random distributions

An integral table can be used to create an arbitrary random distribution quite efficiently. The table
building is expensive though. The more points there are in the random table, the more accurate the
distribution.



(


var randomNumbers, histogram, distribution, randomTable, randTableSize=200;
var minValue = -250, maxValue = 250, numVals = 10000, numBins = 500;



// create some random distribution with values between 0 and 1


distribution = Array.fill(randTableSize,
	{ arg i; (i/ randTableSize * 35).sin.max(0) * (i / randTableSize) }
);



// render a randomTable


randomTable = distribution.asRandomTable;



// get random numbers, scale them



randomNumbers = Array.fill(numVals, { randomTable.tableRand * (maxValue - minValue) + minValue; });
histogram = randomNumbers.histo(numBins, minValue, maxValue);


histogram.plot("this is the histogram we got");
distribution.plot("this was the histogram we wanted");
)










Random decisions:






coin 	simulates a coin toss and results in true or false.
		1.0 is always true, 0.0 is always false, 0.5 is 50:50 chance.



20.do({ 0.5.coin.postln });



biased random decision can be simulated bygenerating a single value
and check against a threshhold:



20.do({ (1.0.linrand > 0.5).postln });
20.do({ (exprand(0.05, 1.0) > 0.5).postln });





Generating Collections of random numbers:





		// size, minVal, maxVal


Array.rand(7, 0.0, 1.0).postln;



// is short for:





Array.fill(7, { rrand(0.0, 1.0) }).postln;


		// size, minVal, maxVal
List.linrand(7, 10.0, 15.0).postln;



// is short for:





List.fill(7, { 10 + 5.0.linrand }).postln;

Signal.exprand(10, 0.1, 1);

Signal.rand2(10, 1.0);







Random choice from Collections





choose 			equal chance for each element.



10.do({ [ 1, 2, 3 ].choose.postln });






Weighted choice:

wchoose(weights)	An array of weights sets the chance for each element.



10.do({ [ 1, 2, 3 ].wchoose([0.1, 0.2, 0.7]).postln });







Randomize the order of a Collection:





scramble



List[ 1, 2, 3, 4, 5 ].scramble.postln;






Generate random numbers without duplicates:





f = { |n=8, min=0, max=7| (min..max).scramble.keep(n) };
f.value(8, 0, 7)







Randomly group a Collection:





curdle(probability)

The probability argument sets the chance that two adjacent elements will be separated.



[ 1, 2, 3, 4, 5, 6, 7, 8 ].curdle(0.2).postln;	// big groups

[ 1, 2, 3, 4, 5, 6, 7, 8 ].curdle(0.75).postln;	// small groups










Random signal generators, i.e. UGens:





"file:///SuperCollider/Help/UGens/Noise/PinkNoise.html"PinkNoise


"file:///SuperCollider/Help/UGens/Noise/WhiteNoise.html"WhiteNoise


"file:///SuperCollider/Help/UGens/Noise/GrayNoise.html"GrayNoise


"file:///SuperCollider/Help/UGens/Noise/BrownNoise.html"BrownNoise


"file:///SuperCollider/Help/UGens/Noise/PinkerNoise.html"PinkerNoise


"file:///SuperCollider/Help/UGens/Noise/ClipNoise.html"ClipNoise


"file:///SuperCollider/Help/UGens/Noise/LFNoise0.html"LFNoise0
"file:///SuperCollider/Help/UGens/Noise/LFNoise1.html"LFNoise1
"file:///SuperCollider/Help/UGens/Noise/LFNoise2.html"LFNoise2
"file:///SuperCollider/Help/UGens/Noise/LFClipNoise.html"LFClipNoise
"file:///SuperCollider/Help/UGens/Noise/LFDNoise0.html"LFDNoise0
"file:///SuperCollider/Help/UGens/Noise/LFDNoise1.html"LFDNoise1
"file:///SuperCollider/Help/UGens/Noise/LFDNoise3.html"LFDNoise3
"file:///SuperCollider/Help/UGens/Noise/LFDClipNoise.html"LFDClipNoise
"file:///SuperCollider/Help/UGens/Noise/Dust.html"Dust
"file:///SuperCollider/Help/UGens/Noise/Dust2.html"Dust2
"file:///SuperCollider/Help/UGens/Noise/Crackle.html"Crackle
"file:///SuperCollider/Help/UGens/Triggers/TWChoose.html"TWChoose








UGens that generate random numbers once, or on trigger:



"file:///SuperCollider/Help/UGens/Random/Rand.html"Rand		uniform distribution of float between (lo, hi), as for numbers.


"file:///SuperCollider/Help/UGens/Random/IRand.html"IRand		uniform distribution of integer numbers.


"file:///SuperCollider/Help/UGens/Random/TRand.html"TRand		uniform distribution of float numbers, triggered


"file:///SuperCollider/Help/UGens/Random/TIRand.html"TIRand		uniform distribution of integer numbers, triggered


"file:///SuperCollider/Help/UGens/Random/LinRand.html"LinRand		skewed distribution of float numbers, triggered


"file:///SuperCollider/Help/UGens/Random/NRand.html"NRand 		sum of n uniform distributions, approximates gaussian distr. with higher n.


"file:///SuperCollider/Help/UGens/Random/ExpRand.html"ExpRand 		exponential distribution
"file:///SuperCollider/Help/UGens/Random/TExpRand.html"TExpRand	exponential distribution, triggered
"file:///SuperCollider/Help/UGens/Random/CoinGate.html"CoinGate		statistical gate for a trigger
"file:///SuperCollider/Help/UGens/Triggers/TWindex.html"TWindex		triggered weighted choice between a list

	Like using randSeed to set the random generatorsfor each thread in sclang,
	you can choose which of several random generators on the server to use,
	and you can reset (seed) these random generators:
"file:///SuperCollider/Help/UGens/Random/RandID.html"RandID
"file:///SuperCollider/Help/UGens/Random/RandSeed.html"RandSeed






UGens that generate random numbers on demand ("Demand UGens"):



"file:///SuperCollider/Help/UGens/Synth%20control/Demand%20Rate/Dwhite.html"Dwhite


"file:///SuperCollider/Help/UGens/Synth%20control/Demand%20Rate/Dbrown.html"Dbrown


Diwhite
Dibrown


"file:///SuperCollider/Help/UGens/Synth%20control/Demand%20Rate/Drand.html"Drand


Dxrand

see random patterns with analogous names





Random Patterns:






"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Prand.html"Prand([ 1, 2, 3 ], inf);		// choose randomly one from a list ( list, numRepeats)


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pxrand.html"Pxrand([ 1, 2, 3 ]);			// choose one element from a list, no repeat of previous choice


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pwhite.html"Pwhite(24, 72);				// within range [<hi>, <lo>], choose a random value.


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pbrown.html"Pbrown(24, 72, 5)				// within range [<hi>, <lo>], do a random walk


							// with a maximum <step> to the next value.


Pgbrown(24, 72, 1.4)			// geometric brownian motion





"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Plprand.html"Plprand


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Phprand.html"Phprand


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pmeanrand.html"Pmeanrand


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pbeta.html"Pbeta


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pcauchy.html"Pcauchy


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pgauss.html"Pgauss


"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Ppoisson.html"Ppoisson
"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pexprand.html"Pexprand





"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pwrand.html"Pwrand([ 1, 2, 3 ], [0.1, 0.3, 0.6], 20);	// choose from a list, probabilities by weights





"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pshuf.html"Pshuf([ 1, 2, 3, 4 ], 2);		// scramble the list, then repeat that order <repeats> times.





"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pwalk.html"Pwalk( (0 .. 10), Prand([ -2,-1, 1, 2], inf));		// random walk.



"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pfsm.html"Pfsm 						// random finite state machine pattern, see its help file.


							// see also MarkovSet in MathLib quark



"file:///SuperCollider/Help/Streams-Patterns-Events/Patterns/Pseed.html"Pseed(seed, pattern)			// sets the random seed for that stream.






// some basic examples



(


Pbind(\note, Prand([ 0, 2, 4 ], inf),
	\dur, 0.2
).play;
)

(
Pbind(


	\note, Pxrand([ 0, 2, 4 ], inf),
	\dur, 0.2
).play;
)

(


Pbind(


	\note, Pwrand([ 0, 2, 4 ], [0.1, 0.3, 0.6], inf),
	\dur, 0.2
).play;
)

(


Pbind(


	\midinote, Pwhite(48, 72, inf),
	\dur, 0.2
).play;
)

(


Pbind(


	\midinote, Pbrown(48, 72, 5, inf),
	\dur, 0.2
).play;
)

(


Pbind(


	\midinote, Pgbrown(48, 72, 0.5, inf).round,
	\dur, 0.2
).play;
)



===MdaPiano!A!

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



// Then we can use it in a pattern > Classic very simple:


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





========  A!!! ==========

(


TempoClock.default.tempo = 1.2;
Ppar([


	Pbind(
		\instrument, \help_mdapiano,
		\midinote, Pgbrown(48, 72, 0.5, inf).round,
	\dur, 0.2,
		\octave, 3,
		\root, 3,
		\vel, Pwhite(50, 100, inf),
		\legato, 0.95
	),
	Pbind(
		\instrument, \help_mdapiano,
	\midinote, Pgbrown(24, 36, 0.5, inf).round,
	\dur, 0.2,
		\octave, 6,
		\root, 3,
		\vel, Pwhite(50, 100, inf)
	)
], inf).play
)

