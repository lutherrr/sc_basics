Standard2DC
standard map 2D chaotic generator
x(n+1) = (x(n) + y(n+1)) % 2pi
y(n+1) = (y(n) + ksin(x(n))) % 2pi

//Examples

//DC

{ Standard2DC.ar(220, 11025, mul:0.3) }.play(s);

// mouse-controlled param
{ Standard2DC.ar(8000, 20000, MouseX.kr(0.9,4), mul:0.3) }.play(s);

// as a frequency control
{ SinOsc.ar(Standard2DC.ar(10, 20, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);


//Dl
{ Standard2DL.ar(220, 11025, mul:0.3) }.play(s);

// mouse-controlled param
{ Standard2DL.ar(11025, 44100, MouseX.kr(0.9,4), mul:0.3) }.play(s);

// as a frequency control
{ SinOsc.ar(Standard2DL.ar(10, 20, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);

//DN
{ Standard2DN.ar(220, 11025, mul:0.3) }.play(s);

// mouse-controlled param
{ Standard2DN.ar(SampleRate.ir/2, SampleRate.ir, MouseX.kr(0.9,4), mul:0.3) }.play(s);

// as a frequency control
{ SinOsc.ar(Standard2DN.ar(10, 20, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);
