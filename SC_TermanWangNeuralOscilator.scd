//TermanWang : UGen : AbstractFunction : ObjectExtensionExtension
//Neural Oscillator
//Source: SLUGens.sc
//See also: FitzHughNagumo
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://composerprogrammer.com/index.html

//Description
//Naive Euler ODE solver implementation of a neural oscillator model by Terman and Wang (see Brown, G.J., and Wang, D. 2006. "Neural and Perceptual Modeling." In Wang, D., and Brown, G. J., eds. Computational Auditory Scene Analysis: Principles, Algorithms, and Applications. Hoboken, NJ: John Wiley and Sons/IEEE Press, p.355).

//Dx = ratex * ( 3*x - x^3 (+ 2) - y + input )

//Dy = ratey * (eta ( alpha* (1 + tanh(x/beta)) - y ))

//All parameters can have .kr rate UGens plugged in. The +2 is left out and can be added back in as part of the input. eta can also be left out as part of yrate.
//


//EXAMPLE difficult to find active parameters, forced to try resetting!

{Out.ar(0,Pan2.ar(0.5*TermanWang.ar(2.0,Impulse.kr(MouseX.kr(1,1000)),0.1,0.01,1.0,1.0,1.0,MouseX.kr(0.4,1.2), MouseY.kr(2.0,4.0)),0.0))}.play;


{Out.ar(0,Pan2.ar(0.5*TermanWang.ar(LFNoise1.ar(LFNoise0.kr(0.5,500,500),1.0,3.0),Impulse.kr(MouseX.kr(1,10000, 'exponential')),0.01,0.01,1.0,1.0,1.0,MouseX.kr(0.4,1.2), MouseY.kr(2.0,4.0)),0.0))}.play;

/A!

{Out.ar(0,Pan2.ar(FreeVerb.ar(0.5*TermanWang.ar(2.0+ SinOsc.ar(MouseX.kr(10,10000,'exponential'),0,MouseY.kr(0.1,100.0,'exponential')),Impulse.kr(MouseX.kr(1,10000, 'exponential')),0.01,0.01,1.0,1.0,1.0,MouseX.kr(0.4,1.2), MouseY.kr(2.0,4.0)),0.5)))}.play;