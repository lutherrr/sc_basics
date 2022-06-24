WalshHadamard
decomposition into square waves, and reconstruction

//examples

{WalshHadamard.ar(SoundIn.ar, MouseX.kr(0,64))}.play

{WalshHadamard.ar(Pan2.ar(Gendy4.ar(1, 1, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, 32,100, 0.3,0.05, 6, 6, 0.2), 0.0), MouseX.kr(0,64))}.play


//compare
c = {Pan2.ar(Gendy4.ar(1, 1, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, 32,100, 0.3,0.05, 6, 6, 0.2), 0.0)}.play;
c.release;

{WalshHadamard.ar(Pan2.ar(Gendy4.ar(1, 1, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, 32,100, 0.3,0.05, 6, 6, 0.2), 0.0), MouseX.kr(0,64))}.play;