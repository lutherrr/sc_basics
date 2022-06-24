// Aphex Twin's Avril 14th
// SuperCollider transcription by Nicola Ariutti.
//
// From an music sheet by Micheal Jordan (https://www.sheetsdaily.com/piano/sheets/45931/Aphex_Twin_Avril_14th.html)
// The code is meant to send MIDI data to an external synthetizer like Modartt Pianoteq.
//
// Inspired by the work of Via (https://forum.pdpatchrepo.info/topic/12650/via-aphex-twin-avril14th-puredata-cover)
// I wanted to make my own version of it.
// Enjoy!!!


TempoClock.default.tempo_(75/60);
MIDIIn.connectAll;
m = MIDIOut.newByName("IAC Driver", "Bus 1").latency_(Server.default.latency);

(
Tdef(\damper, {
	(36*2).do{
		0.25.wait;
		m.control(3, 64, 127);
		(2-0.25).wait;
		m.control(3, 64, 0);
	};
	m.control(3, 64, 127);
}).quant_(4);

// A: bar 0-1
~rhA_deg = [2,-2,  0,   0,  -2,  -2,   4,   3,   2,   0];
~rhA_dur = [1, 1,1.5,0.25,1.75, 0.5, 0.5, 0.5, 0.5, 0.5];
~lhA_deg = [0,5,7,9, 2,7,9,11, 3,7,10,11, 1,7,10,9];
~lhA_dur = [0.5].dup(16).flat;

// B: bar: 4-5
~rhB_deg = [[2,9],[-2,5],[0,7],[0,7],[-2,5]];
~rhB_dur = [    1,     1,  1.5, 0.25,  4.25];
~lhB_deg = ~lhA_deg;
~lhB_dur = ~lhA_dur;

// C: bar 8-9
~rhC_deg = [ -5,  -5,  -3, -5, -5,  -5,  -3, -2, -3];
~rhC_dur = [1.5,0.25,1.75,0.5,1.5,0.25,0.25,1.5,0.5];
~lhC_deg = [0,7,5,4, -3,4,5,4, 0,7,5,4, -4,3,4,3];
~lhC_dur = [0.5].dup(16).flat;

// D: bar 16-17
~rhD_deg = [\rest, [-2,5], [-1,6],[0,7],[2,9], [-1,6], /**/ \rest, [-2,5], [-1,6],[0,7],[2,9], [-1,6], [-2,5]];
~rhD_dur = [  0.5,    0.5,    0.5,  0.5,  0.5,    1.5, /**/   0.5,    0.5,    0.5,  0.5,  0.5,    0.5,      1];
~lhD_deg = [  1,  8,  9,4,   9,  8,   5, /**/  1,  8,  9,   4,  9,  8,   9];
~lhD_dur = [0.5,0.5,0.5,1,0.25,0.5,0.75, /**/0.5,0.5,0.5,0.75,0.5,0.5,0.75];

// E: bar 18-19
~rhE_deg = [\rest, [-2,5], [-1,6],[0,7],[2,9], [-1,6], /**/ \rest, [-2,5], [-1,6],[0,7],[2,9], [-1,6], [-2,5]];
~rhE_dur = [  0.5,    0.5,    0.5,  0.5,  0.5,    1.5, /**/   0.5,    0.5,    0.5, 0.5,  0.75,    0.5,   0.75];
~lhE_deg = [  1,  8,  9,11,   9,   8,  4,  5, /**/  1,  8,  9,   4,  9,  8, 9];
~lhE_dur = [0.5,0.5,0.5, 1,0.25,0.25,0.5,0.5, /**/0.5,0.5,0.5,0.75,0.5,0.25,1];

// F : bar 24-25
~rhF_deg = [[2,9],[-2,5],[0,7],[0,7],[-2,5],[-2,5],[4,11],[3,10],[2,9],[0,7]];
~rhF_dur = [    1,     1,  1.5, 0.25,  1.75,   0.5,   0.5,   0.5,  0.5,  0.5];
~lhF_deg = ~lhB_deg;
~lhF_dur = ~lhB_dur;

// G : bar 28-31
~rhG_deg = [   2,   1,   2,   2,   4,   5,  4,2,4, /**/   2,   1,   0,   2,   4,   5, -2,2,0];
~rhG_dur = [1.75,0.25,1.75,0.25,0.25,0.25,0.5,2,1, /**/1.75,0.25,1.75,0.25,0.25,0.25,0.5,2,1];
~lhG_deg = [[3,5], [1,3,5], [2,7], [0,5], /**/[-2,0,2,7],[-3,0,2,4],[0,4,7,9],[-4,0,3,5]];
~lhG_dur = [2].dup(8).flat;

// H : bar 32-33
~rhHupper_deg = [\rest,  9,\rest,  9,   9, /**/\rest];
~rhHupper_dur = [ 0.25,1.5,  0.5,1.5,0.25, /**/    4];
~rhH_deg = [   2,   1,   2,   2,/**/[4,11],[5,12],[4,11],  18, 16,[4,11]]; // MOD
~rhH_dur = [1.75,0.25,1.75,0.25,/**/  0.25,  0.25,  0.25,0.75,1.5,     1]; // MOD
~lhH_deg = [-2,5,7,8,0,7,8,11,3,7,9,12,1,7,10,14];
~lhH_dur = [0.5].dup(16).flat;

// I : bar 34-36
~rhIupper_deg = [\rest, 14,12,   8,5, \rest];
~rhIupper_dur = [0.25,0.75, 1,1.25,0.75, 8];
~rhI_deg = [[2,9],[1,8],[0,7],[2,9],/**/[4,11],[5,12],[-2,5],  9,[4,11],[4,11],[4,11]];
~rhI_dur = [ 1.75, 0.25, 1.75, 0.25,/**/  0.25,  0.25,     1,1.5,  0.25,  0.25,  4.5];
~lhI_deg = [9,7,5,3,2,7,9,11,/**/1,7,9,12,0,7,14,9];
~lhI_dur = [0.5].dup(15).flat ++ 4.5;

~rhupper_deg = [\rest] ++ ~rhHupper_deg ++ ~rhIupper_deg;
~rhupper_dur = [32*4]  ++ ~rhHupper_dur ++ ~rhIupper_dur;
~rh_deg = ~rhA_deg.dup(2).flat ++ ~rhB_deg ++ ~rhB_deg ++ ~rhC_deg.dup(4).flat ++ ~rhD_deg ++ ~rhE_deg ++ ~rhA_deg.dup(2).flat ++ ~rhF_deg ++ ~rhF_deg ++ ~rhG_deg ++ ~rhH_deg ++ ~rhI_deg;
~rh_dur = ~rhA_dur.dup(2).flat ++ ~rhB_dur.dup(2).flat ++ ~rhC_dur.dup(4).flat ++ ~rhD_dur ++ ~rhE_dur ++ ~rhA_dur.dup(2).flat ++ ~rhF_dur.dup(2).flat ++ ~rhG_dur ++ ~rhH_dur ++ ~rhI_dur;
~lh_deg = ~lhA_deg.dup(2).flat ++ ~lhB_deg.dup(2).flat ++ ~lhC_deg.dup(4).flat ++ ~lhD_deg ++ ~lhE_deg ++ ~lhA_deg.dup(2).flat ++ ~lhF_deg.dup(2).flat ++ ~lhG_deg ++ ~lhH_deg ++ ~lhI_deg;
~lh_dur = ~lhA_dur.dup(2).flat ++ ~lhB_dur.dup(2).flat ++ ~lhC_dur.dup(4).flat ++ ~lhD_dur ++ ~lhE_dur ++ ~lhA_dur.dup(2).flat ++ ~lhF_dur.dup(2).flat ++ ~lhG_dur ++ ~lhH_dur ++ ~lhI_dur;
)

(
Pbindef(\righthandupper,
    \type, \midi,
    \midicmd, \noteOn,
	\midiout, MIDIOut(0),
	\root, -4,
    \chan, 3, // MIDI channel 4
    \scale, Scale.major,
	\octave, 6,
	\degree, Pseq(~rhupper_deg,1).trace,
	\dur,    Pseq(~rhupper_dur, 1),
	\amp, Pgauss(0.5, 0.05, inf),
	\strum, Pwhite(-0.03, 0.03, inf),
	\lag, 0.02 + Pwhite(0.0, 0.03, inf),
	\legato, 0.8
).quant_(4);

Pbindef(\righthand,
    \type, \midi,
    \midicmd, \noteOn,
	\midiout, MIDIOut(0),
	\root, -4,
    \chan, 3, // MIDI channel 4
    \scale, Scale.major,
	\octave, 6,
	\degree, Pseq(~rh_deg,1).trace,
	\dur,    Pseq(~rh_dur, 1),
	\amp, Pgauss(0.5, 0.05, inf),
	\strum, Pwhite(-0.03, 0.03, inf),
	\lag, 0.02 + Pwhite(0.0, 0.03, inf),
	\legato, 0.8
).quant_(4);

Pbindef(\lefthand,
    \type, \midi,
    \midicmd, \noteOn,
	\midiout, MIDIOut(0),
	\root, -4,
    \chan, 3, // MIDI channel 4
    \scale, Scale.major,
	\octave, 4,
	\degree, Pseq(~lh_deg,1).trace,
	\dur,    Pseq(~lh_dur, 1),
	\amp, Pgauss(0.3, 0.05, inf) * Pseq([1.1,Pn(0.7,3)],inf),
	\strum, Pwhite(-0.03, 0.03, inf),
	\lag, Pwhite(0.0, 0.03, inf),
	\legato, 0.9
).quant_(4);
);

// play the song
(
Pbindef(\righthandupper).reset.play;
Pbindef(\righthand).reset.play;
Pbindef(\lefthand).reset.play;
Tdef(\damper).reset.play;
)


// stop it
(
Pbindef(\righthandupper).stop;
Pbindef(\righthand).stop;
Pbindef(\lefthand).stop;
Tdef(\damper).stop;
m.control(3, 64, 0);
)