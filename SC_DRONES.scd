

(
//redFrik 2011
s.waitForBoot{
        Spec.add(\freq1, #[20, 10000, \exp, 0, 100]);
        Spec.add(\freq2, #[20, 10000, \exp, 0, 200]);
        Spec.add(\freq3, #[20, 10000, \exp, 0, 300]);
        Spec.add(\fmod1, #[0.001, 100, \exp, 0, 0.11]);
        Spec.add(\fmod2, #[0.001, 100, \exp, 0, 0.22]);
        Spec.add(\fmod3, #[0.001, 100, \exp, 0, 0.33]);
        Spec.add(\fmoda1, #[0, 100, \lin, 0, 1]);
        Spec.add(\fmoda2, #[0, 100, \lin, 0, 1]);
        Spec.add(\fmoda3, #[0, 100, \lin, 0, 1]);
        Spec.add(\pmod1, #[0.001, 100, \exp, 0, 0.1]);
        Spec.add(\pmod2, #[0.001, 100, \exp, 0, 0.2]);
        Spec.add(\pmod3, #[0.001, 100, \exp, 0, 0.3]);
        Spec.add(\amod1, #[0.001, 100, \exp, 0, 0.01]);
        Spec.add(\amod2, #[0.001, 100, \exp, 0, 0.02]);
        Spec.add(\amod3, #[0.001, 100, \exp, 0, 0.03]);
        Spec.add(\amoda1, #[0, 10, \lin, 0, 0.05]);
        Spec.add(\amoda2, #[0, 10, \lin, 0, 0.05]);
        Spec.add(\amoda3, #[0, 10, \lin, 0, 0.05]);
        Spec.add(\smod, #[0.001, 100, \exp, 0, 0.13]);
        Spec.add(\smoda, #[0, 100, \lin, 0, 5]);
        Spec.add(\smodm, #[0, 100, \lin, 0, 6]);
        Spec.add(\smodaa, #[0, 100, \lin, 0, 8]);
        Spec.add(\smodmm, #[0, 100, \lin, 0, 50]);
        Spec.add(\cmod, #[0.001, 100, \exp, 0, 1.2]);
        Spec.add(\cmoda, #[0, 10, \lin, 0, 0.6]);
        Spec.add(\room, #[0, 300, \lin, 1, 20]);
        Spec.add(\reverb, #[0, 30, \lin, 0, 5]);
        Spec.add(\damp, #[0, 1, \lin, 0, 1]);
        Spec.add(\input, #[0, 1, \lin, 0, 0.5]);
        Spec.add(\spread, #[0, 100, \lin, 0, 25]);
        Spec.add(\dry, #[0, 1, \lin, 0, 0]);
        Spec.add(\early, #[0, 1, \lin, 0, 1]);
        Spec.add(\tail, #[0, 1, \lin, 0, 1]);
        Ndef(\droneSines).play;
        Ndef(\droneSines, {|freq1= 100, freq2= 200, freq3= 300, fmod1= 0.11, fmod2= 0.22, fmod3= 0.33, fmoda1= 1, fmoda2= 1, fmoda3= 1, pmod1= 0.1, pmod2= 0.2, pmod3= 0.3, amod1= 0.01, amod2= 0.02, amod3= 0.03, amoda1= 0.05, amoda2= 0.05, amoda3= 0.05, smod= 0.13, smoda= 5, smodm= 6, smodaa= 8, smodmm= 50, cmod= 1.2, cmoda= 0.6, room= 20, reverb= 5, damp= 1, input= 0.5, spread= 25, dry= 0, early= 1, tail= 1, amp= 0.7|
                Limiter.ar(LeakDC.ar(GVerb.ar(Splay.ar(SinOsc.ar([freq1, freq2, freq3]+SinOsc.ar([fmod1, fmod2, fmod3], 0, [fmoda1, fmoda2, fmoda3]), SinOsc.ar([pmod1, pmod2, pmod3], 0, 2pi), SinOsc.ar([amod1, amod2, amod3], 0, [amoda1, amoda2, amoda3])), SinOsc.ar(SinOsc.ar(SinOsc.ar(smod, 0, smoda, smodm), 0, smodaa, smodmm), 0, 1, 1), amp, SinOsc.ar(cmod, 0, cmoda)), room, reverb, damp, input, spread, dry, early, tail)));
        });
        Ndef(\droneSines).edit;
        s.meter;
};
)


-------
//Ndef(\droneSines).clear;
Ndef(\droneSines).stop;



//--save a preset
Ndef(\droneSines).nodeMap.writeArchive("pset1.txt")

//--recall a preset
Ndef(\droneSines).nodeMap= Object.readArchive("pset1.txt")

//--scramble settings
(
Ndef(\droneSines).set(\amp, 0.05);
Ndef(\droneSines).controlKeys.do{|k|
        if(k!=\amp, {
                Ndef(\droneSines).set(k, k.asSpec.map(1.0.rand));
        });};
)
