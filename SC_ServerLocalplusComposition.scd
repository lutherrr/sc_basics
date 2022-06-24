// MODERAT - SPECTRAL REMIX

(
s.options.memSize= 8192*20;
s.reboot;
)

(
s.waitForBoot {
	SynthDef(\lead, {arg freq, out = 0, amp = 1, atk= 20, rel= 20, dur = 1;
		var osc = Saw.ar([freq, freq+rrand(-4, 4)]);
		var env = EnvGen.kr(Env([0, 1, 1, 0], [atk, dur - atk - rel, rel], [4,-4]));
		Out.ar(out, Pan2.ar(osc) * env * amp);
	}).add;

	SynthDef(\bass, {arg freq, out = 0, amp = 1, atk= 20, rel= 20, dur = 1;
		var osc = Pulse.ar([freq, freq+rrand(-4, 4)]);
		var env = EnvGen.kr(Env([0, 1, 1, 0], [atk, dur - atk - rel, rel], [4,-4]));
		Out.ar(out, Pan2.ar(osc) * env * amp);
	}).add;
};
~originalLead = (
	instrument: \lead,
	root: 2, octave: 5,
	scale: Scale.chromatic,
	degree: Pseq([
		Pseq([2,3,7], 6),
		Pseq([2,3,9], 2),
		Pseq([2,3,10], 8),
		Pseq([0,3,7], 4),
		Pseq([0,3,9], 2),
		Pseq([2,3,7], 2),
		Pseq([2,3,10], 8),
	], 1),
	dur: 25,
	amp: 1
);

~originalBass = (
	instrument: \lead,
	root: 2, octave: 3,
	scale: Scale.chromatic,
	degree: Pseq([
		Pseq([3,3,3], 8),
		Pseq([7,7,7], 8),
		Pseq([0,0,0], 8),
		Pseq([2,2,2], 8)
	], 1),
	dur: 25,
	amp: 1
);

~leadPbind = Pbind(*~originalLead.asKeyValuePairs);
~bassPbind = Pbind(*~originalBass.asKeyValuePairs);
)





(
TempoClock.default.tempo = 104/60;
Pdef(\player, Ppar([Pn(~leadPbind), Pn(~bassPbind)])).play
)

// MODERAT - A NEW ERROR - VARIATION ON THE THEME #1

(
TempoClock.default.tempo = 104/60;
Pdef(\player, Ppar([
	Pbind(\scale, Scale.melodicMinor) <> Pn(~leadPbind),
	Pbind(\scale, Scale.melodicMinor) <> Pn(~bassPbind),
])).play
)

// MODERAT - A NEW ERROR - VARIATION ON THE THEME #2

(
TempoClock.default.tempo = 104/60;

Pdef(\player, Ppar([
	Pbind(\scale, Scale.ionian) <> Pn(~leadPbind),
	Pbind(\scale, Scale.ionian) <> Pn(~bassPbind),
])).play
)
(
TempoClock.default.tempo = 104/60;
Pdef(\player, Ppar([Pn(~leadPbind), Pn(~bassPbind)])).play;
)

(
Pdef(\player, Ppar([
	Pbind(\scale, Scale.melodicMinor) <> Pn(~leadPbind),
	Pbind(\scale, Scale.melodicMinor) <> Pn(~bassPbind),
])).play;
)

(
Pdef(\player, Ppar([
	Pbind(\scale, Scale.ionian) <> Pn(~leadPbind),
	Pbind(\scale, Scale.ionian) <> Pn(~bassPbind),
])).play;
)

Server.local.makeWindow