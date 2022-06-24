GlitchBPF

//code that utilizes the glitch.
//warning!  extremely loud.
//note: might not sound the same on all soundcards
(
{GlitchBPF.ar(
    ClipNoise.ar(1.dup),
    0.5,
    SinOsc.kr(1, 10)
)}.play;
)

//code that utilizes the glitch. A!
(
s.waitForBoot{
    SynthDef(\birdy, {|out= 0, amp= 0.1, freq= 1000, atk= 0.01, rel= 0.05, cur= -4, gate= 1|
        var env= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
        var src= SinOsc.ar(0.11, GlitchBRF.ar(SinOsc.ar(SinOsc.ar(0.12).exprange(1, freq), 2pi), 1/SinOsc.ar(0.13).range(1, #[99, 100])));
        Out.ar(out, Limiter.ar(LeakDC.ar(src*amp)));
    }).add;
    s.sync;
    Synth(\birdy, [\amp, 0.15]);
};
)


//code that utilizes the glitch.
//warning!  extremely loud. LOUD!!
//note: might not sound the same on all soundcards
(
{GlitchHPF.ar(
    BrownNoise.ar(1.dup),
    0.5,
    Saw.kr(1, 10)
)}.play;
)


//code that utilizes the glitch.
//warning!  extremely loud.
//note: might not sound the same on all soundcards
(
{GlitchRHPF.ar(
    BrownNoise.ar(1.dup),
    0.3,
    Saw.kr(1, 200)
)}.play;
)

//A!!
(
{GlitchRHPF.ar(
    BrownNoise.ar(1.dup),
    0.3,
    Saw.kr(1, 20000)
)}.play;
)




//=============based on BRF
BRF
2nd order Butterworth band reject filter.
//A second order band reject filter.

{ BRF.ar(Saw.ar(200,0.1), FSinOsc.kr(XLine.kr(0.7,300,20),0,3800,4000), 0.3) }.play;
​
{ BRF.ar(Saw.ar(200,0.5), MouseX.kr(100, 10000, 1), 0.3) }.play;
​
​
    // BRF on control signals:
(
{     var vib = BRF.kr(SinOsc.kr([1, 3, 10], 0, [1, 0.5, 0.25]).sum, MouseX.kr(1, 10, 1), 0.3);
    SinOsc.ar(vib * 200 + 600) * 0.2 }.play;
)
