===s.boot;
b = Buffer.read(s,"/Users/lisek/Desktop/SOUNDS/writetest.wav");


(
SynthDef("help-localMax", { arg out=0;
    var in, chain;
    in = Mix.arFill(3, { LFSaw.ar(exprand(100, 500), 0, 0.1); });
    chain = FFT(LocalBuf(2048), in);
    chain = PV_LocalMax(chain, MouseX.kr(0, 50));
    Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s);
)

(
SynthDef("help-localMax2", { arg out=0, soundBufnum=2;
    var in, chain;
    in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_LocalMax(chain, MouseX.kr(0, 100));
    Out.ar(out, 0.1 * IFFT(chain).dup);
}).play(s, [\soundBufnum, b]);
)