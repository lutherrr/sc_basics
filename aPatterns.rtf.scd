

Patterns



// run this code to get ready
Server.default= s = Server.local;
s.boot;


Patterns provide a facility for easily exploring generative music/algorithmic composition. Rather than making single synthesis events, we're looking much more at how we schedule lots of events over time.

We'll work backwards! We'll start with what seems magical then explain some of how it works.



To fully understand how Patterns do what they do requires some effort; some of the detail is hidden 'below the surface' in SuperCollider's own libraries, but the good news is that you can use their  power without needing to go very far into the implementation.

In the following, all the names beginning with capital P are examples of Patterns.

// run this line
a = Pbind.new.play(quant:1.0);

a.stop;		// Or stop it with cmd+period;

// now run this line
Pbind(\freq, 440).play(quant:1.0);

// run this, go back and run some of the others at the same time
(
Pbind(
	\dur,0.125,
	\midinote, Pseq([0, 4, 0, 7, 4, 0, 0] + 60,inf),
	\amp, Prand([0.125, 0.2, 0.25],inf)
).play(quant:1.0)
)

====== A
(
Pbind(
	\dur,0.225,
	\midinote, Pseq([Array.rand(20, 40.7,122.4)].choose ,inf),
	\amp, Prand([0.125, 0.2, 0.25],inf)
).play(quant:1.0)
)
===


The quant parameter allows the delay of scheduling to the next beat, so that patterns started up at different times lock in to each other.



(
Pbind(
	\freq, 770		// try changing me to another number!
).play;
)

The Pbind class allows you to match properties of a sound event (like \freq) to your provided parameter values. Now compare this:

(
Pbind(
	\freq, Pseq([100,200,300],inf)       // try a different list
).play;
)

The Pseq is an example of a Pattern, which can be thought of as generating a sequence of values

 100, 200, 300, 100, 200, 300, ...

returning the next one in the sequence each time it is evaluated


There are many useful types of Pattern class to try. Here are some specific examples:


// loops through the sequence of the array, perpetually:
Pseq([0,1,2,3],inf)

// next value is a random member of the array, after 5 times stop:
Prand([0,1,2,3],5)

// next value is a random member of the array
// except you can't repeat the previous value:
Pxrand([0,1,2,3],inf)

// next value is a weighted choice from the first array
// using the weights given in the second argument.
// After returning one value, stop:
Pwrand([0,1,2,3], [0.5,0.3,0.1,0.1], 1)
// next value is the result of evaluating the
// given function, in this case 4.rand:
Pfunc({ 4.rand })


To explore more Pattern types, a good starting point is the following help file:

[Streams]	// select the text within the box then cmd+d





Making Music with Streams

Here is a sound example to show how you might use Streams to generate musical material.





(
	s = Server.local;
	SynthDef(\help_SPE1, { arg i_out=0, freq;
		var out;
		out = RLPF.ar(
			LFSaw.ar( freq, mul: EnvGen.kr( Env.perc, levelScale: 0.3, doneAction: 2 )),
			LFNoise1.kr(1, 36, 110).midicps,
			0.1
		);
		// out = [out, DelayN.ar(out, 0.04, 0.04) ];
		4.do({ out = AllpassN.ar(out, 0.05, [0.05.rand, 0.05.rand], 4) });
		Out.ar( i_out, out );
	}).send(s);
)


(


// streams as a sequence of pitches


	var stream, dur;
	dur = 1/8;
	stream = Routine.new({
		loop({
			if (0.5.coin, {
				// run of fifths:
				24.yield;
				31.yield;
				36.yield;
				43.yield;
				48.yield;
				55.yield;
			});
			rrand(2,5).do({
				// varying arpeggio
				60.yield;
				#[63,65].choose.yield;
				67.yield;
				#[70,72,74].choose.yield;
			});
			// random high melody
			rrand(3,9).do({  #[74,75,77,79,81].choose.yield });
		});
	});
	Routine({
		loop({
			Synth(\help_SPE1, [ \freq, stream.next.midicps ] );
			dur.wait; // synonym for yield, used by .play to schedule next occurence
		})
	}).play
)





Making Music with Patterns

Here is a variation of the example given in part 1 that uses a Pattern to create two instances of the random melody stream.



(
	s = Server.local;
	SynthDef(\help_SPE2, { arg i_out=0, sustain=1, freq;
		var out;
		out = RLPF.ar(
			LFSaw.ar( freq ),
			LFNoise1.kr(1, 36, 110).midicps,
			0.1
		) * EnvGen.kr( Env.perc, levelScale: 0.3,
							timeScale: sustain, doneAction: 2 );
		//out = [out, DelayN.ar(out, 0.04, 0.04) ];
		4.do({ out = AllpassN.ar(out, 0.05, [0.05.rand, 0.05.rand], 4) });
		Out.ar( i_out, out );
	}).send(s);
)


(
// streams as a sequence of pitches
	var pattern, streams, dur, durDiff;
	dur = 1/7;
	durDiff = 3;
	pattern = Prout.new({
		loop({
			if (0.5.coin, {
				#[ 24,31,36,43,48,55 ].do({ arg fifth; fifth.yield });
			});
			rrand(2,5).do({
				// varying arpeggio
				60.yield;
				#[63,65].choose.yield;
				67.yield;
				#[70,72,74].choose.yield;
			});
			// random high melody
			rrand(3,9).do({  #[74,75,77,79,81].choose.yield });
		});
	});
	streams = [
		(pattern - Pfunc.new({ #[12, 7, 7, 0].choose })).midicps.asStream,
		pattern.midicps.asStream
	];
	Routine({
		loop({
			Synth( \help_SPE2, [ \freq, streams.at(0).next, \sustain, dur * durDiff  ] );
			durDiff.do({
				Synth( \help_SPE2, [ \freq, streams.at(1).next, \sustain, dur  ] );
				dur.wait;
			});
		})
	}).play
)



Patterns are generators for Streams. An example of a Stream is the Routine (see Scheduling)

To demonstrate how a Pattern turns into a Stream, ".asStream" is used:




//run this one line at a time, observing the Post window

a = Pseq([1, 3, 400],1);  //make Pattern, a Pseq

x = a.asStream;			//turn this Pattern into a specific Stream

x.next;					//ask for the next value in the Stream

x.next;					//and so on ...

x.next;

x.next;

y=a.asStream

y.next



// this means that from one pattern one can generate many independent streams:

(


var a, x, y;

a = Pshuf([1, 2, 3], inf);
x = a.asStream;	// this creates a Routine from the Pattern.


y = a.asStream;
x.nextN(10).postln;
y.nextN(10);
)


// A sound example:

(


var a =  Pshuf([1, 1, 0, 1, 0], 3);
Pbind(


	\dur, 0.125,
	\midinote, a * 7 + 60,
	\amp, a * 0.1
).play
)


// Patterns can be built of arbitrary complexity by nesting -



Pseq([Pseq([100, 200, 300], 2), 400, 500, 600], inf);





// Examples of Nested Patterns !!! Func of Func?

(


Pbind(


	\freq, Pseq([Pseq([100, 200, 300], 2), 400, 500, 600],inf)
).play;
)


(


Pbind(


	\freq, Pseq([Prand([440, 442, 445, 448]), Pxrand([840, 741, 642], 2)], inf)
// Pxrand never repeats the same value from the array twice in a row
).play;
)



// Note how we get one random value from the first array,
// followed by two different values from the second.
(
	a = Pseq([Prand([440, 442, 445, 448]), Pxrand([840, 741, 642], 2)],inf).asStream;
	20.do({a.next.postln;});
)


To get back to Pbind, there's stuff going on behind the scenes, which SuperCollider is doing for you...

Let's bring some of the hidden variables into view!

(


var clock;

clock = TempoClock(1.5); // tempoclock at 90 bpm





Pbind(


	\freq, Pseq([440, 660, 990, 880, 770], inf),     // frequency in hertz
	\dur, Pseq([1.0, 0.5],inf),			              // duration of event in beats
	\legato, 0.5,							              // proportion of inter onset time to play
	\pan, Pseq([0.5, -0.5],inf),
	\instrument, \default
).play(clock);
)

The Pbind class always takes pairs of arguments, a literal \property and an associated Pattern (or value, or stream) that returns the values to be tied to that property.

You can see the default properties by looking at the defaults defined in this class:

[Meta_Event:makeParentEvents]		// cmd+J

You can define your own properties, and have the values passed directly to your own synthesis function.

The explanation is deferred until later at the end of this file as an optional topic but to prove it's possible:

// run me first
(


SynthDef(\alicepavelinstr, {arg out=0, alice=440, pavel=0.5, pan=0.0, gate=1;
			var z;
			z = Resonz.ar(Pulse.ar(alice, pavel),XLine.kr(5000,1000),0.1,5) * Linen.kr(gate, 0.01, 0.1, 0.3, 2);
			Out.ar(out, Pan2.ar(z, pan));
			}
).add
)

(
var clock;

clock = TempoClock(1.5); // tempoclock at 90 bpm





Pbind(


	\alice, Pseq(440*[1,2,3],inf),   // freq
	\pavel, Pseq([0.1,0.5, 0.8],inf),		// pulse width
	\dur, Pseq([0.5,0.25,0.25],inf),				// duration of event in beats
	\legato, 0.5,							// proportion of inter onset time to play
	\instrument, \alicepavelinstr			// your own synthesiser
).play(clock);
)


You might have noticed that all the properties are independent of one another.
What happens if frequency depends on amplitude?

(


Pbind(// cobinding of properties


	[\freq, \amp],
	Pseq([
		[440,0.4],
		[330,0.1],
		Pfuncn({
			[550.rand, 0.8.rand]
		}, 1)
	], inf)
).play
)


// checking already decided properties of the Event that will be performed
// before setting a new value
(


Pbind(


	\freq, Pseq([ 440, 330, Pfuncn({ 550.rand + 40 }, 1)], inf),
	\amp, Pfunc({ arg event;
			event.postln;
			if(event.freq > 350, {
				"here".postln;
				rrand(0.1,0.5);
			}, 0.05);
		})
).play
)

Now we're ready to do some prettier things with Patterns, by playing multiple simultaneous voices and adding some polyphony and involvement to the music!


// two simultaneous voices using Ppar
(
	var melodypat, basspat;

	melodypat = Pbind(
			[\midinote, \dur],
			Pseq([
				[60, 0.75],[64, 0.5],[66, 0.5],[69, 0.25],
				[67,0.75],[64,0.5],[60,0.5],[57,0.25]
			],inf)
	);

	basspat = Pbind(
			\midinote, Pseq([48, 42], inf),
			\dur, 1
	);

	Ppar([ melodypat, basspat ]).play(TempoClock(1));
)

Henon map / attractor (returns points in -1.5<x<1.5, -0.4<y<0.4), which are then used for pan (x values) and degrees from a dorian scale (y values) (code adapted from Staffan Liljegren)


(
p = Prout({
	var x0, y0, x, y;
	x0 = 0; y0 = 0;

	loop({
		x = y0 + 1 - (1.4 * x0 * x0);
		y = 0.3 * x0;
		x0=x; y0=y;
		[x, (y*14).asInteger].yield;
	});
});

// \degree is the degree of the scale provided in \scale-
// this is where the dorian tuning comes from
b = Pbind(\scale, [0,2,4,5,7,9,11], \dur,0.125,[\pan, \degree], p);

// the order of arguments in Pbindf has been switched since SC2- this may change back again- be careful!


Ptpar([ 0.0, Pbindf(b, \octave, 4,\stretch, 3.0), 4.0, b]).play(TempoClock(1));
)




Pbindf is a filter Pbind - this means it operates on the Pattern b, adjusting the current properties
of the environment - in this case \octave and \stretch

Note how this allows a slow version of b in the bass and a faster version higher up coming in after 4 seconds


Note that you can use normal Patterns without Pbind and they are often extremely useful for quickly generating sequences of values for algorithmic composition. This example is parallel to the Scheduling tutorial.

(


// run me first-


SynthDef(\pulsepan,{arg freq;


		Out.ar(0,
			Pan2.ar(
				LFCub.ar(freq*0.5, Rand(0.4, 0.6), 0.2)
				* (XLine.kr(0.001, 1, 0.9, doneAction:2)),
				Rand(-1.0, 1.0)
			)
		)
}).add
)


(


var p, t;

p = Pseq([100, 200, 300, 330, 478, Prand([987, 789], 1)],inf).asStream;

t = {
		loop({
			Synth(\pulsepan,[\freq,p.next]); // get next frequency value from pattern


			0.1.wait;
		});
	}.play;
)





A little more detail about SynthDescLib:



Note that since SC 3.4, we .add SynthDefs, and this makes sure they're ready for Patterns library use.

The SynthDescLib facility supports using your own SynthDefs with patterns and bind to the SynthDef arguments.

The command



SynthDescLib.global.read

will prepare a library of SynthDesc objects - SynthDef descriptions - from all the synthdefs in your synthdefs folder.

This then allows those SynthDefs to be used in Pbind as an \instrument target, and for the properties of the Event to be passed through to the spawned Synths that use that definition.

To make a new SynthDef and make sure it is ready for use with Pbind you can just use .add.

Note though that if you want to put this on disk as well, you need to use .store rather than .load. This will save a SynthDef file on disk, read it into the SynthDescLib and send it to the active Server.

(
SynthDef(\nickinstr, { arg out=0, freq=440, amp=0.1, pan=0, gate=1;
			var z;
			z = LPF.ar(
				Mix.ar(LFSaw.ar(freq*[0.99,1,1.01],0.0,amp)),
				XLine.kr(5000, 1000, 1.5))
			* EnvGen.kr(Env.new([0,1,0],[0.01,0.01],\lin,1), gate, doneAction:2);
			Out.ar(out, Pan2.ar(z, pan));
		}).store;
)


You can supply the \out and \gate arguments for controlling the target audio bus and the release of the Synth after a given duration. Whether you use gate or not, you should use a doneAction to release the enclosing Synth at some point to prevent build up of Synths and eventual overload of the Server.

(
Pbind(


	\dur, 1.0,
	\midinote, Pseq([0,5,0,7,4,0,0]+60,inf),
	\amp, Prand([0.125,0.2,0.25],inf),
	\instrument, Pseq([\nickinstr,\default],inf),
	\pan, Prand([-1,0,1],inf)
).play
)





Example of combining Patterns and effects units:

[Pfx]





(


SynthDef(\echo, { arg out=0, maxdtime=0.2, dtime=0.2, decay=2, gate=1;
	var env, in;
	env = Linen.kr(gate, 0.05, 1, 0.1, 2);
	in = In.ar(out, 2);
	XOut.ar(out, env, CombL.ar(in * env, maxdtime, dtime, decay, 1, in));
}, [\ir, \ir, 0.1, 0.1, 0]).store;

SynthDef(\distort, { arg out=0, pregain=40, amp=0.2, gate=1;
	var env;
	env = Linen.kr(gate, 0.05, 1, 0.1, 2);
	XOut.ar(out, env, (In.ar(out, 2) * pregain).distort * amp);
}, [\ir, 0.1, 0.1, 0]).store;

SynthDef(\wah, { arg out=0, gate=1;
	var env, in;
	env = Linen.kr(gate, 0.05, 1, 0.4, 2);
	in = In.ar(out, 2);
	XOut.ar(out, env, RLPF.ar(in, LinExp.kr(LFNoise1.kr(0.3), -1, 1, 200, 8000), 0.1).softclip * 0.8);
}, [\ir, 0]).store;
)

(
var p, q, r, o;
p = Pbind(\degree, Prand((0..7),12), \dur, 0.3, \legato, 0.2);

q = Pfx(p, \echo, \dtime, 0.2, \decay, 3);

r = Pfx(q, \distort, \pregain, 20, \amp, 0.25);

o = Pfx(r, \wah);

Pseq([p, q, r, o], 2).play;
)





(


Pbind(


\dur,rrand(0.325,1.225),


	\freq, Pseq([Pfunc({ rrand(145.0,500.0) },inf), Pxrand([840, 741, 642], 2)], inf)
// Pxrand never repeats the same value from the array twice in a row
).play;
)


A!!!

(


Pbind(


\dur,0.005,


	\freq, Pseq([Pfunc({ rrand(35, 400) },inf), Pxrand([340, 441, 442, 543, 666], 3)], inf)
// Pxrand never repeats the same value from the array twice in a row
).play;
)




--------U8888 !



(


SynthDef(\help_mdapiano, { |out=0, freq=440, gate=1|


	var son = MdaPiano.ar(freq, gate, release: 0.9, stereo: 0.3, sustain: 0);
	DetectSilence.ar(son, 0.01, doneAction:2);
	Out.ar(out, son * 0.1);
}).add;
)



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





------U9 !


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
