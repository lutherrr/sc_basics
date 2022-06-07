

/*To launch patch
  [STEP 1] - LOAD SAMPLE
  [STEP 2] - SET PROBABILITIES AND EVALUATE
  [STEP 3] - EVALUATE THE MUSICAL DICTIONARY
  [STEP 4] - EVALUATE VIOLIN DICTIONARY
  [STEP 5] - EVALUATE SYNTH DEF'S
  [STEP 6] - EVALUATE PTPARTY
  see far right side*/


//////////////////////////////////////////////////////////////////////////////1)SAMPLE
/* Specify path to ViolinA.wav sample. Ignore nil in post window,
   the sound file IS loaded to buffer*/
( //<-LOAD SAMPLE---------------------------------------------------------------------------------------------------[STEP 1]
(
~filePath = "/Users/lisek/Desktop/SOUNDS/sieveoutput1.wav";
~sample = Buffer.read(Server.default, ~filePath);
);
~sample.numChannels;
)

//////////////////////////////////////////////////////////////////////////////2)MUSICAL DICTIONARY LANGUAGE
/* This is where the probabilities of certain choice of notes can be made*/

( //<-SET PROBABILITIES AND EVALUATE--------------------------------------------------------------------------------[STEP 2]
		//							|Examples	A	B	C	D	E
~min = 3;	//MINOR notes (A, D, E)					|~min		0	0	8	2	2
~maj = 8;	//MAJOR notes (C, F, G)					|~maj		0	0	4	8	2
~dim = 1;	//DIMINISHED note (B)					|~dim		0	0	2	2	1
~out = 0;	//OUTSIDE major scale (A#, C#, D#, F#, G#)		|~out		0	2	1	0	2
~rep = 1;	//REPETITION of the same note				|~rep		0	1	0	0	1
~jum = 1;	//JUMP an octave up or down to the same note		|~jum		1	0	0	0	1
~chr = 0	//CHROMATIC step up or down from any given note		|~chr		1	0	0	2	2
)

//////////////////////////////////////////////////////////////////////////////3)MUSICAL DICTIONARY
/* A musical dictionary is made using the markov system.
   The above set probabilities randomly generate two arrays
   of 16 and 32 midi numbers. The range is 25 notes long,
   from A(220Hz) to A(880Hz)*/

( //<-EVALUATE THE MUSICAL DICTIONARY-------------------------------------------------------------------------------[STEP 3]
~notes = (57..81);
~markov = ();
~markov[57] = ( // A
	62: ~min, 64: ~min, 69: ~min,		//the multiplier by some of the notes is to
	60: ~maj, 65: ~maj, 67: ~maj,		//balance the probabilities set above, so that
	59: ~dim*2, 71: ~dim, 			//if every type of note (major, minor, chromatic etc)
	58: ~out, 61: ~out, 63: ~out,		//is set at, for example, 1, each have exactly the same
	57: ~rep*3,					//probability of being the next note
	69: ~jum*3,
	58: ~chr*3
);
~markov[58] = ( // A#
	57: ~min, 62: ~min, 64: ~min,
	60: ~maj, 65: ~maj, 67: ~maj,
	59: ~dim*2, 71: ~dim,
	61: ~out, 63: ~out, 66: ~out,
	58: ~rep*3,
	70: ~jum*3,
	57: ~chr*1.5, 59: ~chr*1.5
);
~markov[59] = ( // B
	57: ~min, 62: ~min, 64: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	71: ~dim,
	58: ~out, 61:~out, 63: ~out,
	59: ~rep*3,
	71: ~jum*3,
	58: ~chr*1.5, 60: ~chr*1.5
);
~markov[60] = ( //C
	57: ~min, 62: ~min, 64: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim*2, 71: ~dim,
	58: ~out, 61:~out, 63: ~out,
	60: ~rep*3,
	72: ~jum*3,
	59: ~chr*1.5, 61: ~chr*1.5
);
~markov[61] = ( //C#
	57: ~min, 62: ~min, 64: ~min,
	60: ~maj, 65: ~maj, 67: ~maj,
	59: ~dim*2, 71: ~dim,
	58: ~out, 63: ~out, 66: ~out,
	61: ~rep*3,
	73: ~jum*3,
	60: ~chr*1.5, 62: ~chr*1.5
);
~markov[62] = ( // D
	57: ~min, 64: ~min, 69: ~min,
	60: ~maj, 65: ~maj, 67: ~maj,
	59: ~dim*2, 71: ~dim,
	61: ~out, 63: ~out, 66: ~out,
	62: ~rep*3,
	74: ~jum*3,
	61: ~chr*1.5, 63: ~chr*1.5
);
~markov[63] = ( // D#
	62: ~min, 64: ~min, 69: ~min,
	60: ~maj, 65: ~maj, 67: ~maj,
	59: ~dim*2, 71: ~dim,
	61: ~out, 66: ~out, 68: ~out,
	63: ~rep*3,
	75: ~jum*3,
	62: ~chr*1.5, 64: ~chr*1.5
);
~markov[64] = ( // E
	57: ~min, 62: ~min, 69: ~min,
	60: ~maj, 65: ~maj, 67: ~maj,
	59: ~dim*2, 71: ~dim,
	61: ~out, 63: ~out, 66: ~out,
	64: ~rep*3,
	76: ~jum*3,
	63: ~chr*1.5, 65: ~chr*1.5
);
~markov[65] = ( // F
	62: ~min, 64: ~min, 69: ~min,
	60: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim*2, 71: ~dim,
	63: ~out, 66: ~out, 68: ~out,
	65: ~rep*3,
	77: ~jum*3,
	64: ~chr*1.5, 66: ~chr*1.5
);
~markov[66] = ( // F#
	62: ~min, 64: ~min, 69: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim*2, 71: ~dim,
	63: ~out, 68: ~out, 70: ~out,
	66: ~rep*3,
	78: ~jum*3,
	65: ~chr*1.5, 67: ~chr*1.5
);
~markov[67] = ( // G
	62: ~min, 64: ~min, 69: ~min,
	60: ~maj, 65: ~maj, 72: ~maj,
	59: ~dim, 71: ~dim*2,
	66: ~out, 68: ~out, 70: ~out,
	67: ~rep*3,
	79: ~jum*3,
	66: ~chr*1.5, 68: ~chr*1.5
);
~markov[68] = ( // G#
	62: ~min, 64: ~min, 69: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim, 71: ~dim*2,
	66: ~out, 70: ~out, 73: ~out,
	68: ~rep*3,
	80: ~jum*3,
	67: ~chr*1.5, 69: ~chr*1.5
);
~markov[69] = ( // A
	62: ~min, 64: ~min, 74: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim, 71: ~dim*2,
	68: ~out, 70: ~out, 73: ~out,
	69: ~rep*3,
	81: ~jum*3,
	68: ~chr*1.5, 70: ~chr*1.5
);
~markov[70] = ( // A#
	64: ~min, 69: ~min, 74: ~min,
	65: ~maj, 67: ~maj, 72: ~maj,
	59: ~dim, 71: ~dim*2,
	66: ~out, 68: ~out, 73: ~out,
	70: ~rep*3,
	58: ~jum*3,
	69: ~chr*1.5, 71: ~chr*1.5
);
~markov[71] = ( // B
	69: ~min, 74: ~min, 76: ~min,
	67: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim,
	70: ~out, 73: ~out, 75: ~out,
	71: ~rep*3,
	59: ~jum*3,
	70: ~chr*1.5, 72: ~chr*1.5
);
~markov[72] = ( // C
	69: ~min, 74: ~min, 76: ~min,
	67: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	70: ~out, 73: ~out, 75: ~out,
	72: ~rep*3,
	60: ~jum*3,
	71: ~chr*1.5, 73: ~chr*1.5
);
~markov[73] = ( // C#
	69: ~min, 74: ~min, 76: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	68: ~out, 70: ~out, 75: ~out,
	73: ~rep*3,
	61: ~jum*3,
	72: ~chr*1.5, 74: ~chr*1.5
);
~markov[74] = ( // D
	69: ~min, 76: ~min, 81: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	70: ~out, 73: ~out, 75: ~out,
	74: ~rep*3,
	62: ~jum*3,
	73: ~chr*1.5, 75: ~chr*1.5
);
~markov[75] = ( // D#
	74: ~min, 76: ~min, 81: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	70: ~out, 73: ~out, 78: ~out,
	75: ~rep*3,
	63: ~jum*3,
	74: ~chr*1.5, 76: ~chr*1.5
);
~markov[76] = ( // E
	69: ~min, 74: ~min, 81: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	73: ~out, 75: ~out, 78: ~out,
	76: ~rep*3,
	64: ~jum*3,
	75: ~chr*1.5, 77: ~chr*1.5
);
~markov[77] = ( // F
	74: ~min, 76: ~min, 81: ~min,
	67: ~maj, 72: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	75: ~out, 78: ~out, 80: ~out,
	77: ~rep*3,
	65: ~jum*3,
	76: ~chr*1.5, 78: ~chr*1.5
);
~markov[78] = ( // F#
	74: ~min, 76: ~min, 81: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	73: ~out, 75: ~out, 80: ~out,
	78: ~rep*3,
	66: ~jum*3,
	77: ~chr*1.5, 79: ~chr*1.5
);
~markov[79] = ( // G
	74: ~min, 76: ~min, 81: ~min,
	67: ~maj, 72: ~maj, 77: ~maj,
	59: ~dim, 71: ~dim*2,
	75: ~out, 78: ~out, 80: ~out,
	79: ~rep*3,
	67: ~jum*3,
	78: ~chr*1.5, 80: ~chr*1.5
);
~markov[80] = ( // G#
	74: ~min, 76: ~min, 81: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	73: ~out, 75: ~out, 78: ~out,
	80: ~rep*3,
	68: ~jum*3,
	79: ~chr*1.5, 81: ~chr*1.5
);
~markov[81] = ( // A
	69: ~min, 74: ~min, 76: ~min,
	72: ~maj, 77: ~maj, 79: ~maj,
	59: ~dim, 71: ~dim*2,
	75: ~out, 78: ~out, 80: ~out,
	81: ~rep*3,
	69: ~jum*3,
	80: ~chr*3
);
//------------
~markov['next'] = {
	var return, current;
	current = ~markov['current'];
	return = ~markov[current].keys(Array)
	.wchoose(~markov[current].values.asArray.normalizeSum);
	~markov['current'] = return;
	return
};
~markov['current'] = ~notes.choose;
~markovNotes = Array.fill(16, {
	~markov['next'].value
}).postln;
~markov['current'] = ~notes.choose;
~markovNotes2 = Array.fill(32, {
	~markov['next'].value
})
//------
);

////////////////////////////////////////////////////////////////////////////////4)VIOLIN DICTIONARY
/* The randomly generated values from above are
   converted in a way that they influence the panning
   and pitch of the violin sample. After the evaluation
   of the whole section the post window shows the 16 midi
   note values in an array, then the converted pitches
   of those values in semitones, and the float numbers
   show panning positions */

( //<-EVALUATE VIOLIN DICTIONARY------------------------------------------------------------------------------------[STEP 4]
~markovNotes.postln;

(
~note0 = ~markovNotes[0];
(
if (~note0<69)
{~n0 = ~note0.linlin(57, 68, 0, 11)}  //the if statements look at each of the 16 midi
{~n0 = ~note0.linlin(69, 81, 0, 12)}  //values of the first array and converts them to
).postln;				   //a semitone position of a single octave

~note1 = ~markovNotes[1];
(
if (~note1<69)
{~n1 = ~note1.linlin(57, 68, 0, 11)}
{~n1 = ~note1.linlin(69, 81, 0, 12)}
).postln;

~note2 = ~markovNotes[2];
(
if (~note2<69)
{~n2 = ~note2.linlin(57, 68, 0, 11)}
{~n2 = ~note2.linlin(69, 81, 0, 12)}
).postln;

~note3 = ~markovNotes[3];
(
if (~note3<69)
{~n3 = ~note3.linlin(57, 68, 0, 11)}
{~n3 = ~note3.linlin(69, 81, 0, 12)}
).postln;

~note4 = ~markovNotes[4];
(
if (~note4<69)
{~n4 = ~note4.linlin(57, 68, 0, 11)}
{~n4 = ~note4.linlin(69, 81, 0, 12)}
).postln;

~note5 = ~markovNotes[5];
(
if (~note5<69)
{~n5 = ~note5.linlin(57, 68, 0, 11)}
{~n5 = ~note5.linlin(69, 81, 0, 12)}
).postln;

~note6 = ~markovNotes[6];
(
if (~note6<69)
{~n6 = ~note6.linlin(57, 68, 0, 11)}
{~n6 = ~note6.linlin(69, 81, 0, 12)}
).postln;

~note7 = ~markovNotes[7];
(
if (~note7<69)
{~n7 = ~note7.linlin(57, 68, 0, 11)}
{~n7 = ~note7.linlin(69, 81, 0, 12)}
).postln;

~note8 = ~markovNotes[8];
(
if (~note8<69)
{~n8 = ~note8.linlin(57, 68, 0, 11)}
{~n8 = ~note8.linlin(69, 81, 0, 12)}
).postln;

~note9 = ~markovNotes[9];
(
if (~note9<69)
{~n9 = ~note9.linlin(57, 68, 0, 11)}
{~n9 = ~note9.linlin(69, 81, 0, 12)}
).postln;

~note10 = ~markovNotes[10];
(
if (~note10<69)
{~n10 = ~note10.linlin(57, 68, 0, 11)}
{~n10 = ~note10.linlin(69, 81, 0, 12)}
).postln;

~note11 = ~markovNotes[11];
(
if (~note11<69)
{~n11 = ~note11.linlin(57, 68, 0, 11)}
{~n11 = ~note11.linlin(69, 81, 0, 12)}
).postln;

~note12 = ~markovNotes[12];
(
if (~note12<69)
{~n12 = ~note12.linlin(57, 68, 0, 11)}
{~n12 = ~note12.linlin(69, 81, 0, 12)}
).postln;

~note13 = ~markovNotes[13];
(
if (~note13<69)
{~n13 = ~note13.linlin(57, 68, 0, 11)}
{~n13 = ~note13.linlin(69, 81, 0, 12)}
).postln;

~note14 = ~markovNotes[14];
(
if (~note14<69)
{~n14 = ~note14.linlin(57, 68, 0, 11)}
{~n14 = ~note14.linlin(69, 81, 0, 12)}
).postln;

~note15 = ~markovNotes[15];
(
if (~note15<69)
{~n15 = ~note15.linlin(57, 68, 0, 11)}
{~n15 = ~note15.linlin(69, 81, 0, 12)}
).postln;
);
//------------
(
if (~n0 == 12) { ~n0 = 0 } { ~n0 = ~n0 };		//because there are 25 possible note values
if (~n1 == 12) { ~n1 = 0 } { ~n1 = ~n1 };		//there are two 12 equal tempered scale octaves
if (~n2 == 12) { ~n2 = 0 } { ~n2 = ~n2 };		//(which is fine) + an additional note on top
if (~n3 == 12) { ~n3 = 0 } { ~n3 = ~n3 };		//(which is not so fine),therefore, for the
if (~n4 == 12) { ~n4 = 0 } { ~n4 = ~n4 };		//scale to work the additional note had to be
if (~n5 == 12) { ~n5 = 0 } { ~n5 = ~n5 };		//treated seperately
if (~n6 == 12) { ~n6 = 0 } { ~n6 = ~n6 };
if (~n7 == 12) { ~n7 = 0 } { ~n7 = ~n7 };
if (~n8 == 12) { ~n8 = 0 } { ~n8 = ~n8 };
if (~n9 == 12) { ~n9 = 0 } { ~n9 = ~n9 };
if (~n10 == 12) { ~n10 = 0 } { ~n10 = ~n10 };
if (~n11 == 12) { ~n11 = 0 } { ~n11 = ~n11 };
if (~n12 == 12) { ~n12 = 0 } { ~n12 = ~n12 };
if (~n13 == 12) { ~n13 = 0 } { ~n13 = ~n13 };
if (~n14 == 12) { ~n14 = 0 } { ~n14 = ~n14 };
if (~n15 == 12) { ~n15 = 0 } { ~n15 = ~n15 };
);
//------------
(
~markovScale = Scale.new(#[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12).ratios; //this is where the
~ms = ~markovScale[[~n0, ~n1, ~n2, ~n3, ~n4, ~n5, ~n6, ~n7, 			 //midi values are put
		      ~n8, ~n9, ~n10, ~n11, ~n12, ~n13, ~n14, ~n15]]		 //as scale ratios
);

//------------
(
~p1 = ~markovNotes[0..3].sum/4;			//this is where the 5 float values that affect panning
~pan1 = (~p1.linlin(57, 81, -1, 1) * -1).postln; //are created. each midi note value (no matter
~p2 = ~markovNotes[4..7].sum/4;			//what the octave) has it's own panning space. The
~pan2 = (~p2.linlin(57, 81, -1, 1) * -1).postln; //average midi note value, therefore the panning position,
~p3 = ~markovNotes[8..11].sum/4;			//is calculated so that the panning of the violin sample
~pan3 = (~p3.linlin(57, 81, -1, 1) * -1).postln; //can be directly opposite to it. a calculation
~p4 = ~markovNotes[12..16].sum/4;			//for a sort of balance in panning. the first 4 do this with
~pan4 = (~p4.linlin(57, 81, -1, 1) * -1).postln; //some of the midi note values and the last one for the
p = ~markovNotes.sum/16;				//whole array
~pan = (p.linlin(57, 81, -1, 1) * -1);
)
//------
);

/////////////////////////////////////////////////////////////////////////////5)SYNTH DEF'S
/*Two very simple and basic SynthDef's are created*/

( //<-EVALUATE SYNTH DEF'S------------------------------------------------------------------------------------------[STEP 5]

SynthDef(\simple, {|frq, amp, dur, pan|
	var sig;
	sig = Pan2.ar(SinOsc.ar(frq, 0, mul: amp),
			pan);
	sig = sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, sig)
}).add;
//------------
SynthDef(\warpSample, {|buffer, fscale, wsize, ratio, envdur, panStart, panEnd, warp, dn, amp|
	var pointer, dens;
	dens = XLine.kr(dn, 1, envdur);
	pointer = LFSaw.kr(warp/BufDur.kr(buffer), 1).range(0,1);
	Out.ar(0, Pan2.ar(
			Warp1.ar(1, buffer, pointer, fscale, wsize, -1, dens, ratio, 2)
			* EnvGen.kr(Env.perc(0.001, envdur, 1, -0.2), levelScale: amp, doneAction: 2),
			Line.kr(panStart, panEnd, envdur))
		)
}).add
//------
);

////////////////////////////////////////////////////////////////////////////////6)PTPARTY
/*All the previous evaluations come together here to create an audible
  result.*/

( //<-EVALUATE PTPARTY----------------------------------------------------------------------------------------------[STEP 6]
Ptpar([
	0.0,
	Pbind(
		\instrument, \simple,				   //the synth def \simple uses the initial
		\frq, Pseq((~markovNotes - 24).midicps, 10),	   //midi note value array and converts
		\amp, 0.25,						   //it to frequencies as well as panning
		\dur, Pseq([0.08, 0.5, 0.08, 1.3], inf),		   //positions. most are pitchshifted
		\delta, Pseq([0.1, 0.2, 0.3, 1.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	13.6,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes).midicps, 8),
		\amp, 0.25,
		\dur, Pseq([1.3, 0.08, 0.5, 0.08], inf),
		\delta, Pseq([1.1, 0.3, 0.2, 0.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	20.4,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes + 24).midicps, 7),
		\amp, 0.18,
		\dur, Pseq([0.5, 0.08, 1.3, 0.08], inf),
		\delta, Pseq([0.2, 0.3, 1.1, 0.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	27.2,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes + 12).midicps, 6),
		\amp, 0.25,
		\dur, Pseq([0.08, 1.3, 0.08, 0.5], inf),
		\delta, Pseq([0.1, 1.1, 0.3, 0.2], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	40.8,
//------
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([Prand(~ms[0..3]), Prand(~ms[4..7]), Prand(~ms[8..11]), Prand(~ms[12..15])], 4),
		\wsize, 0.1,
		\warp, 1,
		\dn, Pwhite(1, 4, inf),
		\panStart, Pseq([~pan1, ~pan2, ~pan3, ~pan4], inf),	//the \warpSample synth def uses the same
		\panEnd, Pseq([~pan2, ~pan3, ~pan4, ~pan1], inf),	//initial array but already converted
		\ratio, 0.02,							//for it's specific pitch and panning use
		\envdur, Pseq([1.7], inf),					//which itself is a little randomized
		\dur, Pkey(\envdur),
		\delta, Pkey(\envdur),
		\amp, 0.8
		),
	47.6,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([Prand(~ms[0..3]), Prand(~ms[0..3]), Prand(~ms[4..7]), Prand(~ms[4..7]),
				 Prand(~ms[8..11]), Prand(~ms[8..11]), Prand(~ms[12..15]), Prand(~ms[12..15])], 3),
		\wsize, 0.1,
		\warp, 1,
		\dn, Pwhite(1, 4, inf),
		\panStart, ~pan,
		\panEnd, ~pan,
		\ratio, 0.02,
		\envdur, Prand([Pseq([1.1, 0.6]), Pseq([0.6, 1.1]), Pseq([0.85, 0.85])], inf),
		\dur, Pkey(\envdur),
		\delta, Pkey(\envdur),
		\amp, 0.8
		),
	68,
//------
	Pbind(									//these 4 \simple synth def's
		\instrument, \simple,					//use the other array of midi
		\frq, Pseq((~markovNotes2).midicps, 2),			//values created at the beginning
		\amp, 0.25,							//and aren't pitchshifted
		\dur, Pseq([0.08, 0.5, 0.08, 1.3], inf),
		\delta, Pseq([0.1, 0.2, 0.3, 1.1], inf),
		\pan, Pseq(~markovNotes2.linlin(57, 81, -1, 1), inf)
		),
	68,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes2).midicps, 2),
		\amp, 0.25,
		\dur, Pseq([1.3, 0.08, 0.5, 0.08], inf),
		\delta, Pseq([1.1, 0.3, 0.2, 0.1], inf),
		\pan, Pseq(~markovNotes2.linlin(57, 81, -1, 1), inf)
		),
	68,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes2).midicps, 2),
		\amp, 0.25,
		\dur, Pseq([0.5, 0.08, 1.3, 0.08], inf),
		\delta, Pseq([0.2, 0.3, 1.1, 0.1], inf),
		\pan, Pseq(~markovNotes2.linlin(57, 81, -1, 1), inf)
		),
	68,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes2).midicps, 2),
		\amp, 0.25,
		\dur, Pseq([0.08, 1.3, 0.08, 0.5], inf),
		\delta, Pseq([0.1, 1.1, 0.3, 0.2], inf),
		\pan, Pseq(~markovNotes2.linlin(57, 81, -1, 1), inf)
		),
	95.2,
//------									//back to the original melody
	Pbind(									//with a sort of string orchestra
		\instrument, \warpSample,					//and dramatic ending
		\buffer, ~sample,
		\fscale, Pseq([~ms[0]*0.5, ~ms[4]*0.5, ~ms[8]*0.5, ~ms[12]*0.5], 5),
		\wsize, Pwhite(0.1, 0.3, inf),
		\warp, 1,
		\dn, Pwhite(2, 10, inf),
		\panStart, Pseq([~pan1, ~pan2, ~pan3, ~pan4], inf),
		\panEnd, Pseq([~pan2, ~pan3, ~pan4, ~pan1], inf),
		\ratio, 0.02,
		\envdur, Prand([2.4], inf),
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	95.2,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[1], ~ms[5], ~ms[9], ~ms[13]], 7),
		\wsize, Pwhite(0.1, 0.3, inf),
		\warp, 1,
		\dn, Pwhite(2, 10, inf),
		\panStart, Pseq([~pan2, ~pan3, ~pan4, ~pan1], inf),
		\panEnd, Pseq([~pan3, ~pan4, ~pan1, ~pan2], inf),
		\ratio, 0.02,
		\envdur, Prand([2.4], inf),
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	95.2,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[2]*2, ~ms[6]*2, ~ms[10]*2, ~ms[14]*2], 5),
		\wsize, Pwhite(0.1, 0.3, inf),
		\warp, 1,
		\dn, Pwhite(2, 10, inf),
		\panStart, Pseq([~pan3, ~pan4, ~pan1, ~pan2], inf),
		\panEnd, Pseq([~pan4, ~pan1, ~pan2, ~pan3], inf),
		\ratio, 0.02,
		\envdur, Prand([2.4], inf),
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.5
		),
	95.2,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[3]*0.25, ~ms[7]*0.25, ~ms[11]*0.25, ~ms[15]*0.25], 5),
		\wsize, Pwhite(0.2, 0.3, inf),
		\warp, 1,
		\dn, Pwhite(2, 10, inf),
		\panStart, Pseq([~pan4, ~pan1, ~pan2, ~pan3], inf),
		\panEnd, Pseq([~pan1, ~pan2, ~pan3, ~pan4], inf),
		\ratio, 0.02,
		\envdur, Prand([2.4], inf),
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	95.2,
//------
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes - 24).midicps, 2),
		\amp, 0.25,
		\dur, Pseq([0.08, 0.5, 0.08, 1.3], inf),
		\delta, Pseq([0.1, 0.2, 0.3, 1.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	95.2,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes).midicps, 3),
		\amp, 0.25,
		\dur, Pseq([1.3, 0.08, 0.5, 0.08], inf),
		\delta, Pseq([1.1, 0.3, 0.2, 0.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	95.2,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes + 24).midicps, 4),
		\amp, 0.18,
		\dur, Pseq([0.5, 0.08, 1.3, 0.08], inf),
		\delta, Pseq([0.2, 0.3, 1.1, 0.1], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
	95.2,
	Pbind(
		\instrument, \simple,
		\frq, Pseq((~markovNotes + 12).midicps, 7),
		\amp, 0.25,
		\dur, Pseq([0.08, 1.3, 0.08, 0.5], inf),
		\delta, Pseq([0.1, 1.1, 0.3, 0.2], inf),
		\pan, Pseq(~markovNotes.linlin(57, 81, -1, 1), inf)
		),
//------
	133.0,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[0]*0.5], 1),
		\wsize, 8,
		\warp, 1,
		\dn, Pwhite(2, 6, inf),
		\panStart, 0.4,
		\panEnd, 0.4,
		\ratio, 0.02,
		\envdur, 25,
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	133.0,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[1]], 1),
		\wsize, 8,
		\warp, 1,
		\dn, Pwhite(2, 6, inf),
		\panStart, -0.4,
		\panEnd, -0.4,
		\ratio, 0.02,
		\envdur, 25,
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	133.0,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[2]*2], 1),
		\wsize, 8,
		\warp, 1,
		\dn, Pwhite(2, 6, inf),
		\panStart, -1,
		\panEnd, -1,
		\ratio, 0.02,
		\envdur, 25,
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.5
		),
	133.0,
	Pbind(
		\instrument, \warpSample,
		\buffer, ~sample,
		\fscale, Pseq([~ms[3]*0.25], 1),
		\wsize, 8,
		\warp, 1,
		\dn, Pwhite(2, 6, inf),
		\panStart, 1,
		\panEnd, 1,
		\ratio, 0.02,
		\envdur, 25,
		\dur, Pkey(\envdur),
		\delta, 1.7,
		\amp, 0.7
		),
	],
1).play
);
//////////////////////////////////////////////////////////////////////////////7)FIN