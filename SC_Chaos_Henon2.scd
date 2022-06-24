Henon2

henon map 2D chaotic generator

y = b * x(n)
x(n+2) = 1 - ax(n+1)^2 + y


{ Henon2DC.ar(SampleRate.ir/4, SampleRate.ir/2, MouseX.kr(1,1.4), MouseY.kr(0,0.3)) * 0.2 }.play(s);

(
{ Henon2DC.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)

{ SinOsc.ar(Henon2DC.ar(20, 40, MouseX.kr(1,1.4), MouseY.kr(0,0.3))*800+900)*0.4 }.play(s);

///=======2DL

{ Henon2DL.ar(SampleRate.ir/4, SampleRate.ir, MouseX.kr(1,1.4), MouseY.kr(0,0.3)) * 0.2 }.play(s);

(
{ Henon2DL.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)

{ SinOsc.ar(Henon2DL.ar(20, 40, MouseX.kr(1,1.4), MouseY.kr(0,0.3))*800+900)*0.4 }.play(s);


====2DN
{ Henon2DN.ar(SampleRate.ir/4, SampleRate.ir, MouseX.kr(1,1.4), MouseY.kr(0,0.3)) * 0.2 }.play(s);

(
{ Henon2DN.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)

{ SinOsc.ar(Henon2DN.ar(20, 40, MouseX.kr(1,1.4), MouseY.kr(0,0.3))*800+900)*0.4 }.play(s);

