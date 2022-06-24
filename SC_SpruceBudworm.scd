SpruceBudworm
Spruce bud worm model equations
//One of a number found in A Brief History of Oscillators and Hair Styles of European Men AASU Math/CS Colloquium, April 2002.

//Euler ODE solver implementation of a model of foliage and budworm density in Canadian forests ( a logistic model + predation).

x' = k1 x (1-x) - mu*y y' = k2 *y * (1 - (y/alpha*x)) - (rho * (y**2/(beta**2 * x**2 + y**2)))

//All inputs can have .kr rate UGens plugged in.
//Nonlinear oscillators can blow up, treat with caution.

//Examples

//listen to x and y output with defaults
{Out.ar(0,0.5*SpruceBudworm.ar(0.0))}.play


//be careful with rate range, can blow-up easily here, or just not sound
{Out.ar(0,0.5*SpruceBudworm.ar(0.0,MouseX.kr(0.09,0.1)))}.play


{Out.ar(0,0.5*SpruceBudworm.ar(0.0,,MouseX.kr(0.09,0.1),MouseY.kr(25.0,28.0)))}.play


{Out.ar(0,0.5*SpruceBudworm.ar(Impulse.kr(MouseY.kr(1,50,'exponential')),0.1))}.play



{Out.ar(0,Pan2.ar(0.5*(SpruceBudworm.ar(Impulse.kr(MouseX.kr(1,50)),0.1,24.8,0.5,initx:MouseY.kr(0.2,1.2))[0])))}.play


{10.0*(SpruceBudworm.ar(Impulse.kr(Line.kr(1,200,0.1)),0.1,19.8,0.5,initx:0.6)[0]-1.0)}.plot(0.1)


{10.0*(SpruceBudworm.ar(Impulse.kr(MouseX.kr(1,200)),0.1,19.8,0.5,initx:0.6)[0]-1.0)}.play


{10.0*(SpruceBudworm.ar(Impulse.kr(MouseX.kr(1,200)),0.1,MouseY.kr(19,28),0.5,initx:0.6)[0]-1.0)}.play