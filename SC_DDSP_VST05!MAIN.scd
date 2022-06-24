

VSTPlugin.search;

SynthDef(\vsti, { |out| Out.ar(out, VSTPlugin.ar(nil, 2)) }).add;

// ------------
// e) Creating a VST instrument is simple:

(// This needs the \vsti SynthDef above!
Ndef(\inst, \vstDef -> \vsti).play;
~inst = VSTPluginNodeProxyController(Ndef(\inst)).open("DDSPSynth.vst3", editor: true, action: _.program_(1));
Ndef(\inst).play;)



// Now play some notes with a Pbind of type \vst_midi
(
Pdef(\seq, Pbind(
    \type, \vst_midi,
    \vst, ~inst,
    \midinote, Pseq(#[0, 2, 4, 7], inf) + Pwhite(-12, 12).stutter(Pwhite(4, 16)) + 60,
    \dur, Prand(#[0.125, 0.25, 0.5], inf),
    \legato, Pexprand(0.5, 1.0, inf),
    \amp, Pexprand(0.5, 1.0, inf)
)).play;
)


TempoClock.default.tempo = 0.1
TempoClock.default.tempo = 0.3
TempoClock.default.tempo = 9
TempoClock.default.tempo = 1

// Change Instrument

~inst.editor;


// Pause/resume/end the Pbind.
Pdef(\seq).stop;
Pdef(\seq).play;



// ------------
// a) Filter white noise through a VST plugin

~vsti.browse;

(
Ndef(\test, \vst -> { VSTPlugin.ar(WhiteNoise.ar(0.1) ! 2, 2) }).play;

~fx = VSTPluginNodeProxyController(Ndef(\test)).open("DDSPEffect.vst3", editor: true, action: _.set('Noise', 0.6, \Harmonics, 1));
)

~fx.editor; // open the VST plugin editor

// Sun with mouse
(
Ndef(\test, \vst -> { VSTPlugin.ar(Pan2.ar(SinOsc.ar(MouseY.kr(44,88),0,0.5),0.0)) }).play;

~fx = VSTPluginNodeProxyController(Ndef(\test)).open("DDSPEffect.vst3", editor: true, action: _.set('Noise', 0.6, \Harmonics, 1));
)



// automate parameters with a Pbind of type \vst_set
(
Pdef(\auto, Pbind(
    \type, \vst_set,
    \vst, ~fx, // VSTPluginNodeProxyController
    \params, [\Noise, \Harmonics],
    \Noise, Pwhite(0.1, 0.9),
	\Harmonics, Pwhite(0.1, 0.9),
    //\Pitch_Shift, Pseq([0.1, 0.2, 0.5, 0.9], inf),
    \dur, Prand([0.25, 0.5, 1], inf)
)).play;
)

TempoClock.default.tempo = 0.2

Pdef(\auto).stop;
Pdef(\auto).play;

// ------------
// b) For more flexibility, let's split it into seperate sources; the first source is filtered by the second source
(
Ndef(\test)[0] = { WhiteNoise.ar(0.1) ! 2 };
Ndef(\test)[1] = \vstFilter -> { |in| VSTPlugin.ar(in, 2) };
Ndef(\test).play;

// We want to control the source at index 1!
~fx = VSTPluginNodeProxyController(Ndef(\test), 1).open("DDSPEffect.vst3", editor: true);
)

// ------------
// c) Let's go one step further and use seperate NodeProxies
(
Ndef(\white, { WhiteNoise.ar(0.1) ! 2 });
Ndef(\fx, \vst -> { VSTPlugin.ar(\in.ar(0 ! 2), 2) });
// Route \white to \fx. (Don't use '<>>' or '<<>'!)
Ndef(\fx).set(\in, Ndef(\white));
Ndef(\fx).play;

~fx = VSTPluginNodeProxyController(Ndef(\fx)).open("ValhallaVintageVerb.vst3", editor: true);
)

// Now it's possible to change the routing on the fly:
(
Ndef(\pink, { PinkNoise.ar(0.1) ! 2 });
Ndef(\fx).set(\in, Ndef(\pink));
)

// ------------


VSTPlugin.search;

// d) If you look at the last example, you might notice that the VSTPlugin function will always be the same, so it makes sense to use a SynthDef instead! Most of the time the following SynthDefs should be sufficient:

(
// mono insert FX
SynthDef(\vst_fx_mono, { |out| Out.ar(out, VSTPlugin.ar(\in.ar(0), 1)) }).add;

// stereo insert FX
SynthDef(\vst_fx_stereo, { |out| Out.ar(out, VSTPlugin.ar(\in.ar(0 ! 2), 2)) }).add;

// VST instrument (stereo)
SynthDef(\vsti, { |out| Out.ar(out, VSTPlugin.ar(nil, 2)) }).add;
)

// Now let's rewrite c) by using the \vstDef role:
(
Ndef(\white, { WhiteNoise.ar(0.1) ! 2 });
Ndef(\fx, \vstDef -> \vst_fx_stereo);
// Route \white to \fx. (Don't use '<>>' or '<<>'!)
Ndef(\fx).set(\in, Ndef(\white));
Ndef(\fx).play;

~fx = VSTPluginNodeProxyController(Ndef(\fx)).open("ValhallaVintageVerb.vst3", editor: true);
)

