MarkovSynth
First order Markov Chain implementation for audio signals

MarkovSynth populates a sample to sample transition probability table with its signal input. Each possible sample value in an 16bit signal has its own transition probability table whose size is defined by the "tableSize" argument at creation time. It waits and populates the table for "waitTime" seconds and then starts synthesizing audio by continuously outputting a random value selected from the probability table of the last synthesized sample. Once the end of table is reached for a single sample, its index wraps back to zero and populating continues in this fashion as long as "isRecording" argument is non-zero. The character of the input is mainly defined by the way its input signal changes. So input signals showing little difference in amplitude and periodicity has a similar quality in output. The output becomes less dynamic.

If the tableSize is 1, the output is usually a reflection of the input. tableSize of 2 makes some funny blips and blops. When tableSize goes higher, older and older transition values are taken into account and the output changes accordingly. You should be careful with the tableSize as it allocates all the memory for the tables beforehand so it may cause troubles.

// Table size of 1 reflects the input.
x = { MarkovSynth.ar(SinOsc.ar(), 1, 2, 1); }.play;
x.free;

// Table size of 2, keep it running for a while.
x = { MarkovSynth.ar(SinOsc.ar(), 1, 2, 2); }.play;
x.free;

// Table size of 2, Modulating the amplitude a wee bit...
x = { MarkovSynth.ar(SinOsc.ar() * LFNoise1.ar(0.1).range(0.9, 1), 1, 2, 2); }.play;
x.free;

// Table size of 3, on a periodic signal. A probabilistic explosion...
x = { MarkovSynth.ar(SinOsc.ar(), 1, 2, 3); }.play;
x.free;

// Table size of 10, on a periodic signal. Another probabilistic explosion...
// When the transitions of the sine curve is broken, it becomes much noisier
// than tableSize = 3, because there are more samples in the table to try out.
// if you wait enough, output may stabilize at some point again.
x = { MarkovSynth.ar(SinOsc.ar(), 1, 2, 10); }.play;
x.free;

// Modulating the frequency and amplitude by hand.
(
x = { Out.ar([0,1], MarkovSynth.ar(SinOsc.ar(MouseY.kr(10, 1000)) * MouseX.kr(0, 1),
                                   1, 1, 50)); }.play;
)
x.free;

// Feedbacks and modulation!
(
SynthDef("markov", { arg recEnable = 1, waitTime = 1;
                     var fedIn = LocalIn.ar(1) * 0.5;
                     var mark = MarkovSynth.ar(fedIn + (Saw.ar(MouseY.kr(10, 5000)) * MouseX.kr(0, 0.5)), recEnable, waitTime, 5);
                     LocalOut.ar(mark);
                     Out.ar(0, mark.dup); } ).send(s);
)

x = Synth("markov")
x.free;