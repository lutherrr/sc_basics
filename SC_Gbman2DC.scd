//Gbman2DC : Gbman2DN : UGen : AbstractFunction : ObjectExtensionExtension
//gingerbreadman map 2D chaotic generator
//  x(n+1) = 1 - y(n) + |x(n)|
//  y(n+1) = x(n)


{ Gbman2DC.ar(MouseX.kr(20, SampleRate.ir*0.25), MouseX.kr(80, SampleRate.ir), 0.1) }.play(s);
​
{ Gbman2DC.ar(11025, 22050, -0.7, -2.7, 0.1) }.play(s);
​
{ Gbman2DC.ar(2200, 8800, 1.2, 2.0002, 0.1) }.play(s);

//==2DL
{ Gbman2DL.ar(MouseX.kr(20, SampleRate.ir*0.25), MouseX.kr(80, SampleRate.ir), 0.1) }.play(s);

{ Gbman2DL.ar(11025, 22050, -0.7, -2.7, 0.1) }.play(s);

{ Gbman2DL.ar(2200, 8800, 1.2, 2.0002, 0.1) }.play(s);


//===2DN
{ Gbman2DN.ar(MouseX.kr(20, SampleRate.ir*0.25), MouseX.kr(80, SampleRate.ir), 0.1) }.play(s);

{ Gbman2DN.ar(11025, 22050, -0.7, -2.7, 0.1) }.play(s);

{ Gbman2DN.ar(2200, 8800, 1.2, 2.0002, 0.1) }.play(s);
