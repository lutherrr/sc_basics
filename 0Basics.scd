

{ SinOsc.ar(440, 0, 0.2)}.play;
.
{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;
.
//with panning

{Pan2.ar(SinOsc.ar(840,0,0.1),0.0)}.play;
.
// hear the difference, LinPan having a slight drop in the middle...
{ LinPan2.ar(SinOsc.ar(440), Line.kr(-1, 1, 5)) }.play;

// ... whereas Pan2 is more smooth
{ Pan2.ar(SinOsc.ar(440), Line.kr(-1, 1, 5)) }.play;

// other examples
{ Pan2.ar(PinkNoise.ar(0.4), FSinOsc.kr(2), 0.3) }.play;

{Pan2.ar(SinOsc.ar(MouseY.kr(440,880),0,0.1),0.0)}.play;


(
{
	var n = 11; 	//try changing me to 34, or 3, and then re-running...

	Resonz.ar(
		Mix.fill(n,{

			var freq=rrand(50,560.3);
			var numcps= rrand(2,20);

			Pan2.ar(Gendy1.ar(6.rand,6.rand,1.0.rand,1.0.rand,freq ,freq, 1.0.rand, 1.0.rand, numcps, SinOsc.kr(exprand(0.02,0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt)), 1.0.rand2)
		}),
		MouseX.kr(100,2000),
		MouseY.kr(0.01,1.0)
	);
}.play
)

(		//double click on the inside of any bracket to highlight the code contained within

)


(		//select this code within the outer parentheses
		//then press the evalute key command
{
SinOsc.ar(440,0,0.1)
+
Pulse.ar(443,0.6,0.05)
}.play

)



(
var freq;

freq=rrand(300,600);


Server.default=s=Server.internal;   //run this line first, SC3.5

s.boot;

(
{
//some synthesis code
}.scope
)


{WhiteNoise.ar(0.1)}.scope
;
{Resonz.ar(WhiteNoise.ar(0.1),Line.kr(1000,20000,100))}.scope

{SinOsc.ar(100,0,0.1) +SinOsc.ar(600,0,0.1)+ SinOsc.ar(1260,0,0.1)}.scope


{Pan2.ar(WhiteNoise.ar(0.1), Line.kr(-1,1,10))}.scope



(
Pbind(
	\dur,0.125,
	\midinote, Pseq([0, 4, 6, 9, 0, 7, 4, 0, 5, 1, 0] + 60,inf),
	\amp, Prand([0.125, 0.2, 0.25],inf)
).play(quant:1.0)
)

(
Pbind(
	\freq, Pseq([100,200,300],2)       // try a different list
).play;
)


//Newcooo

a = Pseq([1, 3, 400],1);  //make Pattern, a Pseq



(
var a, x, y;

a = Pshuf([1, 2, 3], inf);
x = a.asStream;	// this creates a Routine from the Pattern.
y = a.asStream;
x.nextN(10).postln;
y.nextN(10);
)


(
var a =  Pshuf([1, 1, 0, 1, 0], 3);
Pbind(
	\dur, 0.125,
	\midinote, a * 7 + 60,
	\amp, a * 0.1
).play
)

////////New
(
	a = Pseq([Prand([440, 442, 445, 448]), Pxrand([840, 741, 642], 2)],inf).asStream;
	20.do({a.next.postln;});
)

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
/////

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


/////GENDY1

//defaults
{Pan2.ar(Gendy1.ar)}.play

//wandering bass/ powerline
{Pan2.ar(Gendy1.ar(1,1,1.0,1.0,30,100,0.3,0.05,5))}.play

//play me
{Pan2.ar(RLPF.ar(Gendy1.ar(2,3,minfreq:20, maxfreq:MouseX.kr(100,1000), durscale:0.0, initCPs:40), 500,0.3, 0.2), 0.0)}.play

//scream! - careful with your ears for this one!
(
{
var mx, my;

mx= MouseX.kr(220,440);
my= MouseY.kr(0.0,1.0);

Pan2.ar(Gendy1.ar(2,3,1,1,minfreq:mx, maxfreq:8*mx, ampscale:my, durscale:my, initCPs:7, mul:0.3), 0.0)}.play
)


//1 CP = random noise effect
{Pan2.ar(Gendy1.ar(initCPs:1))}.play

//2 CPs = suudenly an oscillator (though a fast modulating one here)
{Pan2.ar(Gendy1.ar(initCPs:2))}.play


//used as an LFO
(
{Pan2.ar(SinOsc.ar(Gendy1.kr(2,4,SinOsc.kr(0.1,0,0.49,0.51),SinOsc.kr(0.13,0,0.49,0.51), 3.4,3.5, SinOsc.kr(0.17,0,0.49,0.51), SinOsc.kr(0.19,0,0.49,0.51),10,10,50, 350), 0, 0.3), 0.0)}.play
)