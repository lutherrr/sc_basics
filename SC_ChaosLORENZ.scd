Lorenz2DC
lorenz 2D chaotic generator
x' = s(y - x)
y' = x(r - z) - y
z' = xy - bz

The time step amount h determines the rate at which the ODE is evaluated. Higher values will increase the rate, but cause more instability. This generator uses a different algorithm than the LorenzN/L/C ugen included with current distributions. The resulting sound is somewhat different, and it also means that h becomes unstable around 0.02.

{ Lorenz2DC.ar(8800, 16000) }.play(s);

// randomly modulate params
(
{ Lorenz2DC.ar(
    110, 22050,
    LFNoise2.kr(1, 2, 10),
    20,
    LFNoise2.kr(1, 1.5, 2),
    0.01
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(Lorenz2DC.kr(40, 80, h:0.01)*800+900)*0.4 }.play(s);

//====2DL

{ Lorenz2DL.ar(11025, 44100) }.play(s);

// randomly modulate params
(
{ Lorenz2DL.ar(
    11025, 44100,
    LFNoise0.kr(1, 2, 10),
    20,
    LFNoise0.kr(1, 1.5, 2),
    0.02
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(Lorenz2DL.ar(40, 80, h:0.02)*800+900)*0.4 }.play(s);



//==2DN

{ Lorenz2DN.ar(11025, 44100) }.play(s);

//stereo

{ [Lorenz2DN.ar(11025, 44100), Lorenz2DN.ar(11025, 44100) ] }.play;

// randomly modulate params
(
{ Lorenz2DN.ar(
    11025, 44100,
    LFNoise0.kr(1, 2, 10),
    20,
    LFNoise0.kr(1, 1.5, 2),
    0.02
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(Lorenz2DN.ar(40, 80, h:0.02)*800+900)*0.4 }.play(s);

// as a frequency control STEREO
{ [SinOsc.ar(Lorenz2DN.ar(40, 80, h:0.02)*800+900)*0.4, SinOsc.ar(Lorenz2DN.ar(40, 80, h:0.02)*800+900)*0.4 ] }.play;



//====LORENZ TRI
// one channel
{ LorenzTrig.ar(11025, 44100) }.play(s);

// two channels
{ [LorenzTrig.ar(11025, 44100), LorenzTrig.ar(11025, 44100) ] }.play;

// randomly modulate params
(
{ LorenzTrig.ar(
    11025, 44100,
    LFNoise0.kr(1, 2, 10),
    20,
    LFNoise0.kr(1, 1.5, 2),
    0.02
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(Decay.ar(LorenzTrig.ar(1, 8, h:0.02))*800+900)*0.4 }.play(s);
