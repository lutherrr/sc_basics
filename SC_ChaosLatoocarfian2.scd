Latoocarfian2DC : Latoocarfian2DN : UGen : AbstractFunction : ObjectExtensionExtension
latoocarfian 2D chaotic generator

x(n+1) = sin(by(n)) + c*sin(bx(n))
y(n+1) = sin(ay(n)) + d*sin(ax(n))
x values determine frequencies; y values determine amplitudes. Stable ranges for a & b tend to be between -3 to + 3. c & d between 0.5 and 1.5. There are combinations within these ranges that are unstable, so be prepared to tweak this oscillator.

//Examples

(
{ Latoocarfian2DC.ar(
    SampleRate.ir/8,
    SampleRate.ir/2,
    LFNoise2.kr(2.dup, 1.5, 1.5),
    d:LFNoise2.kr(2.dup, 0.5, 1.5),
    mul:0.2
) }.play(s);
)

==DL

{ Latoocarfian2DL.ar(MouseX.kr(20, SampleRate.ir * 0.5), MouseX.kr(40, SampleRate.ir), mul:0.2) }.play(s);
​
​A!!!

(
{ Latoocarfian2DL.ar(
    SampleRate.ir/4,
    SampleRate.ir,
    LFNoise2.kr(2.dup, 1.5, 1.5),
    d:LFNoise2.kr(2.dup, 0.5, 1.5),
    mul:0.2
) }.play(s);
)


===DN

{ Latoocarfian2DN.ar(MouseX.kr(20, SampleRate.ir * 0.5), MouseX.kr(40, SampleRate.ir), mul:0.2) }.play(s);


(
{ Latoocarfian2DN.ar(
    SampleRate.ir/4,
    SampleRate.ir,
    LFNoise2.kr(2.dup, 1.5, 1.5),
    d:LFNoise2.kr(2.dup, 0.5, 1.5),
    mul:0.2
) }.play(s);
)
