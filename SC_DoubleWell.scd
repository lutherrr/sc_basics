//DoubleWell Oscillator
//Runge-Kutta ODE solver implementation of the chaotic Forced Double Well Oscillator (see Strogatz, Steven H. (1994) Nonlinear Dynamics and Chaos. Addison-Wesley, Reading, MA. pp441-7).

// D2x +delta*Dx-x+x^3 = F*cos(w*t)

// All inputs can have .kr rate UGens plugged in.

// note for me: add a t rate control? or arbitary oscillator input rather than Fcos(wt)


//Can be very noisy, high pitched and aliases badly: e.g., great fun, but watch out for your ears, filter, try out odd param settings. I've turned all the amplitudes down in the following


//defaults, high pitched! WARNING
{Out.ar(0,Pan2.ar(0.1*DoubleWell.ar(Impulse.kr(0),MouseX.kr(0.01,1,'exponential'),MouseY.kr(0.01,1,'exponential'),0.9,0.0001,0.25,LFNoise0.kr(1,0.4,0.5),LFNoise0.kr(1,0.4,0.5)),0.0))}.play;


//2 per second
(
{Out.ar(0,Pan2.ar(

CombN.ar(
Resonz.ar(DoubleWell.ar(Impulse.kr(2),MouseX.kr(0.01,1,'exponential'),MouseY.kr(0.01,1,'exponential'),3.9,MouseX.kr(0.0001,0.01,'exponential'),0.25,LFNoise0.kr(1,0.4,0.5),LFNoise0.kr(1,10.4,10.5)),500,0.1),
0.05,0.05,2
),0.0))}.play
)


//plotting check of first samples
{DoubleWell.ar(1,0.025,0.025,0.4,1,0.25,-0.5,-0.2)}.plot(0.01, minval:-1, maxval:1);

//=========

//Can be very noisy, high pitched and aliases badly- ie great fun, but watch out for your ears, filter, try out odd param settings. I've turned all the amplitudes down in the following


//defaults, high pitched! WARNING
{Out.ar(0,Pan2.ar(0.1*DoubleWell.ar(Impulse.kr(0),MouseX.kr(0.01,1,'exponential'),MouseY.kr(0.01,1,'exponential'),0.9,0.0001,0.25,LFNoise0.kr(1,0.4,0.5),LFNoise0.kr(1,0.4,0.5)),0.0))}.play;


//2 per second
(
{Out.ar(0,Pan2.ar(

CombN.ar(
Resonz.ar(DoubleWell2.ar(Impulse.kr(2),MouseX.kr(0.01,0.1,'exponential'),MouseY.kr(0.01,0.1,'exponential'),3.9,MouseX.kr(0.0001,0.01,'exponential'),0.25,LFNoise0.kr(1,0.4,0.5),LFNoise0.kr(1,10.4,10.5)),1000,0.1),
0.05,0.05,2
)
,0.0))}.play
)



//plotting check of first samples
{DoubleWell2.ar(0,0.1,0.1,0.4,1,0.25,0,0.0)}.plot(0.05, minval:-1, maxval:1);

//gradually changing force
{DoubleWell2.ar(0,0.1,0.1,Line.kr(0.01,0.8,10),1,0.25,0,0.0)}.play;


//controlling force- guitar feedback!
{DoubleWell2.ar(0,0.1,0.1,MouseX.kr(0.0,10.0),1,MouseY.kr(0.0,1.0),0,0.0)}.play;

//triggering
{DoubleWell2.ar(Impulse.kr(MouseY.kr(1,10, 'exponential')),0.1,0.1,MouseX.kr(0.0,10.0),1,MouseY.kr(0.0,1.0),LFNoise0.kr(2.3,0.2,0.8),LFNoise1.kr(2.37,0.2,0.8))}.play;


//overload patch. A!!!
{DoubleWell2.ar(Dust.kr(LFNoise0.kr(0.5,0.2,0.4)),0.1,0.1,MouseX.kr(0.0,50.0),MouseY.kr(0.0,1.0),0.25, LFNoise0.kr(2.3,0.4,0.5),LFNoise1.kr(2.37,0.4,0.2))}.play;

//====

//bass synth
{Out.ar(0,Pan2.ar(DoubleWell3.ar(f:SinOsc.ar(MouseX.kr(0,200),0,MouseY.kr(0.5,4.0))),0.0))}.play;

//plotting check of first samples
{DoubleWell3.ar}.plot(0.05, minval:-1, maxval:1)

//gradually changing
{Pan2.ar(DoubleWell3.ar(0,0.05,LFSaw.ar(Line.kr(10,1000,10)),Line.kr(0.0,0.3,20)),0.0)}.play;

//controlled - midscreen amplitude jump
{Pan2.ar(DoubleWell3.ar(0,0.05,LFSaw.ar(MouseX.kr(10,1000)),MouseY.kr(0.0,0.5)),0.0)}.play;



//triggering
{DoubleWell3.ar(Impulse.kr(MouseY.kr(0.01,100, 'exponential')),0.1,LFCub.ar(MouseX.kr(10,1000, 'exponential')),MouseY.kr(0.0,1.0),LFNoise0.kr(2.3,0.2,0.8),LFNoise1.kr(2.37,0.2,0.8))}.play;


//AudioIn as forcing
{Pan2.ar(DoubleWell3.ar(0,0.05,LPF.ar(AudioIn.ar(1),100,MouseX.kr(0,1000)),MouseY.kr(0.0,0.5)),0.0)}.play;