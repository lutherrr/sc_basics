TGrains2
buffer granulator with linear att/dec
//Triggers generate grains from a buffer. Each grain has a linear and is panned between two channels of multiple outputs.

//Examples

s.sendMsg(\b_allocRead, 10, "/Users/lisek/Desktop/sound_PIANO/piano_AI_TN8wBPAU.wav");
​
(
{
    var b = 10, trate, dur, clk;
    trate = MouseY.kr(2,200,1);
    dur = 4 / trate;
    clk = Dust.kr(trate);
    TGrains2.ar(2, clk, 10, 1.0, LFNoise2.kr(0.5).range(0, BufDur.kr(b)), dur, 0, TRand.kr(0.1, 0.2, clk), MouseX.kr(0.003, 0.01), 0.007, 4);
}.play;
)
​
(
{
    var b = 10, trate, dur, clk, pos, pan;
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    TGrains2.ar(2, clk, b, 1, pos, dur, pan, 0.1, dur * 0.3, dur * 0.5);
}.play;
)

//====TG3
//buffer granulator with user envelope
s.sendMsg(\b_allocRead, 10, "/Users/lisek/Desktop/sound_PIANO/piano_AI_TN8wBPAU.wav");
c=Buffer.alloc(s, s.sampleRate * 0.2, 1)
// buffer for rise/decay shape - multiple of sr helps prevent clicks, i think.

(
var y, h;
y=Signal.hanningWindow(s.sampleRate * 0.4); // twice the size of our buffer, 'cause we only use 1/2
h=Array.fill(s.sampleRate * 0.2, {|i| y[i]});
c.loadCollection(h);
)

(
{
    var b = 10, trate, dur, clk;
    trate = MouseY.kr(2,200,1);
    dur = 4 / trate;
    clk = Dust.kr(trate);
    TGrains3.ar(2, clk, 10, 1.0, LFNoise2.kr(0.5).range(0, BufDur.kr(b)) + TRand.kr(0, 0.02, clk), dur, 0, 0.1, MouseX.kr(0.003, 0.01), 0.007, c.bufnum, 4);
}.play;
)

(
var y, h;
y=Signal.hammingWindow(s.sampleRate * 0.4);
h=Array.fill(s.sampleRate * 0.2, {|i| y[i]});
c.loadCollection(h);
)

(
{
    var b = 10, trate, dur, clk, pos, pan;
    trate = MouseY.kr(8,220,1);
    dur = 2/trate;
    clk = Impulse.kr(trate);
    pos = MouseX.kr(0, BufDur.kr(b)) + TRand.kr(0, 0.02, clk);
    pan = WhiteNoise.kr(0.6);
    TGrains3.ar(2, clk, b, 1, pos, dur, pan, 0.1, dur*0.1, dur*0.3, c.bufnum, 4);
}.play;
)