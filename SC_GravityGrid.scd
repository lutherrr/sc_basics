GravityGrid
dynamical system simulation (Newtonian gravitational force)

//Eight fixed masses around a boundary apply Newtonian gravitational force dynamics to a central moving mass which cannot escape the [-1, 1] grid in x or y. The position of the moving mass is sonified as an oscillator by its distance from the centre.

This is a relatively expensive oscillator to run.

Note: This original GravityGrid contains an erroneous folding function, and gravity which is more attractive as the distance increases! Which however, adds interesting distortions to the sound. See GravityGrid2 for a cleaned up version. This one is retained for backwards compatibility.


//GravityGrid comes out with some interesting noisy sounds- WARNING, loud, aliasing! You'll probably want to filter the outputs, maybe with RLPF, Slew et al.


{Pan2.ar(0.05*GravityGrid.ar(Impulse.kr(2),MouseX.kr(0.1,10,'exponential'),LFNoise0.kr(2,0.8),LFNoise0.kr(2,0.8)),0.0)}.play


{Pan2.ar(0.5*GravityGrid.ar(Impulse.kr(1),SinOsc.kr(0.5,0.0,0.8,1.0),LFSaw.kr(50),LFNoise0.kr(10,0.8)),0.0)}.play

//rhythmic violence
{0.1*GravityGrid.ar(Impulse.kr(LFNoise0.kr([0.25,0.231],90,100)),[100.2,10.5], LFNoise0.kr(10,0.8),LFNoise0.kr(10,0.8))}.play


//noisy
{Pan2.ar(Resonz.ar(GravityGrid.ar(Impulse.kr(50),0.01,LFNoise0.kr(1,4),LFNoise0.kr(1,4)),1000,0.1),0.0)}.play

//48k spectrum looping
{Pan2.ar(Resonz.ar(GravityGrid.ar(Impulse.kr(5),0.01,LFNoise0.kr(1,4),LFNoise0.kr(1,4)),1000,0.1),0.0)}.play


b = Buffer.alloc(s, 9, 1); //weights buffer

b.setn(0,Array.rand(9,0.1,0.9)); //set weights

{Pan2.ar(0.1*GravityGrid.ar(Impulse.kr(1),MouseX.kr(0.1,1,'exponential'),LFNoise0.kr(1,0.8),LFNoise0.kr(1,0.8), b.bufnum),0.0)}.play

b.setn(0,Array.rand(9,0.1,0.9)); //change weights to new random values

b.setn(0,[0.1,1,0.1,2,0.1,3,0.1,4,0.1]); //change weights to new specific values


{0.1*Resonz.ar(GravityGrid.ar(Impulse.kr(LFNoise0.kr([0.2,0.3],70,80)),[11.2,12.5], LFNoise0.kr(5.4,0.4),LFNoise0.kr(10,0.8), b.bufnum),SinOsc.ar(0.03,0,300,500),SinOsc.ar(0.03,0,0.3,0.4))}.play

b.setn(0,[0.1,0,0.3,4,0.1,4,0.3,0,0.1]);

b.setn(0,[4.1,0,6.3,4,0.1,4,0.3,0,7.1]);


{0.05*GravityGrid.ar(Impulse.kr([2,4.1]),1, SinOsc.kr(1,pi,0.9), SinOsc.kr(1.9,0,0.9),b.bufnum)}.play


//violent
{Pan2.ar(0.1*GravityGrid.ar(Impulse.ar(0),MouseX.kr(0.01,10,'exponential')))}.play





========== GravityGrid2
//Fixed masses apply Newtonian gravitational force dynamics to a central moving mass which cannot escape the [-1, 1] grid in x or y. The position of the moving mass is sonified as an oscillator by its distance from the centre.
//This is a relatively expensive oscillator to run.


b = Buffer.alloc(s, 1+(25*3), 1); //mass buffer big enough for up to 25 masses

b.setn(0,[5]++(Array.fill(5,{[1.0.rand2,1.0.rand2,rrand(0.1,1.0)]}).flatten)); //set weights

{Pan2.ar(GravityGrid2.ar(Impulse.kr(1),MouseX.kr(0.1,1,'exponential'),LFNoise0.kr(1,0.8),LFNoise0.kr(1,0.8), b.bufnum),0.0)}.play

(
var n;

n=rrand(1,20); //random number of masses

b.setn(0,[n]++(Array.fill(n,{[1.0.rand2,1.0.rand2,rrand(0.1,1.0)]}).flatten)); //change weights to new random values
)


{Pan2.ar(GravityGrid2.ar(Impulse.kr(MouseY.kr(1,1000,'exponential')),MouseX.kr(0.1,1,'exponential'),LFNoise0.kr(1,0.8),LFNoise0.kr(1,0.8), b.bufnum),0.0)}.play



//lower gravity
(
var n;

n=rrand(1,20); //random number of masses

b.setn(0,[n]++(Array.fill(n,{[1.0.rand2,1.0.rand2,0.01*rrand(0.1,1.0)]}).flatten)); //change weights to new random values
)


{Pan2.ar(GravityGrid2.ar(Impulse.kr(0),MouseX.kr(0.1,10,'exponential'),LFNoise0.kr(1,0.8),LFNoise0.kr(1,0.8), b.bufnum),0.0)}.play


(
//deliberate corners
b.setn(0,[4]++(Array.fill(4,{arg i; [if(i<2,1,-1),if(i%2==0,1,-1),0.1*rrand(0.1,1.0)]}).flatten)); //set weights
)


(
//deliberate corners further away
b.setn(0,[4]++(Array.fill(4,{arg i; [if(i<2,rrand(1,2.3),-1),if(i%2==0,1,rrand(-1.1,-1.5)),0.1*rrand(0.1,1.0)]}).flatten)); //set weights
)



//very fun and noisy!
{Pan2.ar(GravityGrid2.ar(Impulse.kr(0),MouseX.kr(1,1000,'exponential'),LFNoise0.kr(1,0.8),LFNoise0.kr(1,0.8), b.bufnum),0.0)}.play


//if something fun turns up in the four mass version
b.getn(0,13,{arg in; in.postln;})

//here's one I made earlier
b.setn(0, [ 4, 1, 1, 0.029076481238008, 1, -1, 0.061766054481268, -1, 1, 0.096376851201057, -1, -1, 0.09320655465126 ])

//and another A!!!
b.setn(0, [ 4, 1.4228951931, 1, 0.080506414175034, 1.3617297410965, -1.3782749176025, 0.027821443974972, -1, 1, 0.038790885359049, -1, -1.3663036823273, 0.047782249748707 ])




//higher gravity but larger placement area outside box which constrains the moving particle
(
var n;

n=rrand(1,20); //random number of masses

b.setn(0,[n]++(Array.fill(n,{[5.0.rand2,5.0.rand2,exprand(0.1,100.0)]}).flatten)); //change weights to new random values
)




//noise piece
{Resonz.ar(GravityGrid2.ar(Impulse.kr(LFNoise0.kr([0.2,0.3],7,8)),MouseX.kr(0.1,10)*[11.2,12.5], LFNoise0.kr(5.4,0.4),LFNoise0.kr(10,0.8), b.bufnum),SinOsc.ar(0.03,0,2000,3000),SinOsc.ar(0.03,0,0.3,0.4))}.play