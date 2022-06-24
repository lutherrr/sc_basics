//Band limited impulse generator based on B-Spline interpolation of order 3.

{ BlitB3.ar(XLine.kr(10000, 20, 10), 0.5) }.play;

//spot the aliasing
{ Impulse.ar(XLine.kr(10000, 20, 10), 0.0, 0.5) }.play;

//sawtooth
x = { LeakDC.ar(Integrator.ar(BlitB3.ar(MouseX.kr(20,1000,'exponential'), 0.5), 0.99)) }.play;


//sawtooth; super-saw, can integrate mix
//leaks dealt with one by one so don't accumulate
x = {Mix(LeakDC.ar( Integrator.ar(BlitB3.ar(MouseX.kr(1,4)*[220,221,223,224], 0.125), 0.99)) ) }.play;



//sound very similar, but BlitB3 more efficient
x = {MoogFF.ar(Mix(LeakDC.ar( Integrator.ar(BlitB3.ar(MouseX.kr(0.125,4)*[220,221,223,224], 0.125), 0.99)) ), MouseY.kr(200,10000,'exponential'),3) }.play;

//comparison
x = {MoogFF.ar(Mix(LeakDC.ar(Saw.ar(MouseX.kr(0.125,4)*[220,221,223,224], 0.125), 0.99) ), MouseY.kr(200,10000,'exponential'),3) }.play;


//even more efficient; see BlitB3Saw help file
x = {MoogFF.ar(Mix(BlitB3Saw.ar(MouseX.kr(0.125,4)*[220,221,223,224], 0.99, 0.125)), MouseY.kr(200,10000,'exponential'),3) }.play;

{ BlitB3Saw.ar(XLine.kr(1000, 20, 10)) }.play;

//aliasing suddenly appears for very high frequencies
{ BlitB3Saw.ar(MouseX.kr(10,10000,'exponential'),MouseY.kr(0.01,0.99)) }.play;

//comparison
{ Saw.ar(1000) }.play;
{ BlitB3Saw.ar(1000) }.play;

{ Mix(Saw.ar({rrand(10,1000)}!100,mul:0.01)) }.play;
//definitely more efficient second method
{ Mix(BlitB3Saw.ar({rrand(10,1000)}!100,mul:0.01)) }.play;

{ BlitB3Square.ar(XLine.kr(1000, 20, 10)) }.play;

{ BlitB3Square.ar(MouseX.kr(20,1000,'exponential'),MouseY.kr(0.001,0.999)) }.play;

//comparison
//blit version is cheaper, but aliases once pushed over 4000 or so at 44100 SR
{ Pulse.ar(4000, 0.5) }.play;
{ BlitB3Square.ar(4000) }.play;


//spot the difference in CPU usage. A!!!
{ Mix.fill(100, {Pan2.ar(0.1*BlitB3Square.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps), 1.0.rand2) }) }.play;

{ Mix.fill(100, {Pan2.ar(0.1*Pulse.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps, 0.5), 1.0.rand2) }) }.play;

{ BlitB3Tri.ar(XLine.kr(1000, 20, 10)) }.play;

//unfortunately, aliasing returns at higher frequencies (over 5000Hz or so) with a vengence
{ BlitB3Tri.ar(MouseX.kr(20,8000,'exponential').poll,0.99,MouseY.kr(0.001,0.99)) }.play;

//more efficient, some aliasing from 3000, but not so scary over 5000. Duller sound (less high harmonics included for lower fundamentals)
{ LFTri.ar(MouseX.kr(20,8000,'exponential').poll) }.play;


//comparison
//LFTri version cheaper, and less aliasing!
x = { LFTri.ar(4000) }.play;
x = { BlitB3Tri.ar(4000) }.play;


//see also comparison in BlitB3 help file