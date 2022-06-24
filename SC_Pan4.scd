// You'll only hear the front two channels on a stereo setup.

{ Pan4.ar(PinkNoise.ar, FSinOsc.kr(2), FSinOsc.kr(1.2), 0.3) }.play;


{ Pan4.ar(PinkNoise.ar, -1,  0, 0.3) }.play; // left pair
{ Pan4.ar(PinkNoise.ar,  1,  0, 0.3) }.play; // right pair
{ Pan4.ar(PinkNoise.ar,  0, -1, 0.05) }.play; // back pair
{ Pan4.ar(PinkNoise.ar,  0,  1, 0.3) }.play; // front pair

{ Pan4.ar(PinkNoise.ar,  0,  0, 0.3) }.play; // center