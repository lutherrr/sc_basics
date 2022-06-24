//An SOM will try to fit a smooth-ish surface to the given data, so as a test case let's create a single sine-wave undulation in a Buffer, and see if a one-dimensional SOM can fit nicely to that sinewave. (For higher dimension examples see SOMTrain_2D_example, SOMTrain_3D_example)

s.boot;
~numnodes = 20;
~traindur = 10000;
// First create the data
~dataspace = Buffer.alloc(s, s.sampleRate); // Let's have 1 second of data
~dataspace.sine1([1], true, false);
~dataspace.plot;
// Allocate space for the SOM, and initialise it
~som = SOMTrain.allocBuf(s, ~numnodes, 1, 2);
// Typically wewouldn't recommend initBufRand, so let's use initBufGridRand:
SOMTrain.initBufGridRand(~som, ~numnodes, 1, [1,0], 1.5);
~som.plot(minval:nil.dup, maxval: nil.dup); // Quick peek at how the SOM nodes are initially positioned
​
// Also, just for demonstration purposes, we're going to write the error values to a buffer so we can see how they evolve
~errorvals = Buffer.alloc(s, ~traindur);
​
// Now train the SOM. To train it with data "randomly sampled" from the data buffer, we just wiggle the phase around and feed [phase, val] to the SOM.
(
x = {
var phase, val, remain, err, loc, trig;
trig = 1;
phase = WhiteNoise.kr.range(0, ~dataspace.numFrames-1);
val = BufRd.kr(1, ~dataspace, phase, 1);
phase.poll(trig, label: "phase");
val.poll(trig, label: "val");
// Note: phase is rescaled to 0--2 range here, so it can be similar range to other dimension
# remain, err, loc = SOMTrain.kr(~som, [phase*2/s.sampleRate, val], ~numnodes, 1, ~traindur, nhood: 0.75, gate: trig);
remain.poll(trig, label: "remain");
err.poll(trig, label: "err");
loc.poll(trig, label: "wrote at frame index");
BufWr.kr(err.sqrt, ~errorvals, ~traindur-remain);
Out.ar(0, Pan2.ar(K2A.ar(val) * 0.01));
}.play
)
​
// Once the training is finished (i.e. once "remain" drops to zero):
x.free;
​
// We should be able to look at the 2D data points represented in the SOM and see if they line up with the sinewave.
​
// This plot is nice if you have OctaveSC installed:
o = OctaveSC.new;
o.init
(
~som.loadToFloatArray(action: {|arr|
o[\xtemp] = arr[0,2..].as(Array).postln;
o[\ytemp] = arr[1,3..].as(Array).postln;
o.("figure; hold off");
o.("plot(xtemp, ytemp, '-@')");
o.("hold on");
o.("spls = [0:0.01:2]; plot(spls, sin(spls*2*pi/2))");
});
);
​
// Otherwise here's a quick 2D plot in pure SC - does it look like the sinewave you started with?
(
~som.loadToFloatArray(action: {|arr| {
w = GUI.window.new("SOM nodes", Rect(200, 800, 600, 600)); // SCWindow
w.view.background = Color.white;
(0,2..arr.size-1).do{|index|
GUI.staticText.new(w, Rect(
arr[index] * 600 / 2,
600 - (arr[index+1] + 1 * 300), 10, 10)).string_("x") // SCStaticText
};
w.front;
}.defer})
)
​
​
// How do the errors look? Should be a very noisy curve gradually decreasing, but won't necessarily stabilise
~errorvals.plot(maxval: nil, minval: nil);
