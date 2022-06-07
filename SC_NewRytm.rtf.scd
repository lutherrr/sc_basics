






play{({|k|x={|f,m,j|SinOsc.ar(f+(m*4*j),m,
LFNoise1.ar(j+1/f*4)/2)};y=x.(0.1,0,8);
9.do({|i|y=x.(i*k*[4,8],y,i)});y}!8).sum/4}

p={|f,a=5|GVerb.ar(LFPulse.ar(f)*a)+f};
play{tanh(HPF.ar(p.(99-p.(1/2,20)*(1+p.(2,1/5))+p.(4+p.(1/2)),0.5),80, XLine.kr(4e-4,1/8,61,1,0,2)))};










n={|r,f,d=1|2**LFNoise0.kr(1!d,r)*f};{p=n.(4,1e3);(CombN.ar(Ringz.ar(LFPulse.ar(1,0,0.01),n.(2,p,80),0.6).sum,8/5,8/5,60)*4e-4!2)}.play;





play{({|k|x={|f,m,j|SinOsc.ar(f+(m*4*j),m,LFNoise1.ar(j+1/f*4)/2)};y=x.(0.1,0,8);9.do({|i|y=x.(i*k*[4,8],y,i)});y}!8).sum/4};

p={|f,a=5|GVerb.ar(LFPulse.ar(f)*a)+f};play{tanh(HPF.ar(p.(99-p.(1/2,20)*(1+p.(2,1/5))+p.(4+p.(1/2)),0.5),80,XLine.kr(4e-4,1/8,61,1,0,2)))};




(
SynthDef(\phase,{|gate=1,freq=10|
    var sen,env;
     sen=SinOsc.ar(SinOsc.kr(10,0,10,120),SinOsc.ar(11,0,12,13),TRand.kr(0.1,0.5,Impulse.kr(2)));
          sen=sen.round(0.12);
              env=EnvGen.kr(Env.asr(0,1,0),gate,doneAction:2);
             Out.ar(0,sen*env)
             }).send(s)
             )

g=Synth(\phase);






(
Pdef(\oppp,Pbind(\instrument,\uno,
	\dur,0.1,
	\legato,0.071225,
	\sel2,Pseq([Pseq([2,1],8),Pseq([Pn(2,2)],2),Pseq([Pn(4,2)],2)],inf),
	\rel,Pseq([0.18,0.34,0.13,0.12],inf),
	\selFreq2,Pseq([112,134],inf),
	\freq,Pseq([Pn(16,12)],inf),
	\amp,0.8,
	\amp2,Pseq([212,12,139,228].midicps,inf),
	\freq2,Pseq([100,110,129,140].midicps,inf),
	\combMix,0,
	\combFreq,Pseq([2,4,2,8],inf),
	\distMix,0,
	\distFreq,Pseq([0.02,0.01,0.3,2,4],inf)
	))
	)
Pdef(\oppp).quant_(0).play;
Pdef(\oppp).stop;
(
Pdef(\oppp,Pbind(\instrument,\uno,
	\dur,Prand([1.4/16,1.4/8,1.4/16],inf),
	\legato,0.1225,
	\sel2,Pseq([Pseq([2,1],8),Pseq([Pn(2,2)],2),Pseq([Pn(4,2)],2)],inf),
	\rel,Pseq([0.1,0.3,0.2],inf),
	\selFreq2,Pseq([12,2],inf),
	\freq,Pseq([Pn(56,3),Pn(18330,4),Pn(9022,8)],inf),
	\amp,0.14,
	\amp2,Pseq([192,122,190,189].midicps,inf),
	\freq2,Pseq([18,55].midicps,inf),
	\combMix,0,
	\combFreq,2
	))
	)
	s.latency=0
Pdef(\oppp).stop;
Pdef(\oppp).quant_(0).play;
(
Pdef(\oppp,Pbind(\instrument,\uno,
	\dur,0.1,
	\legato,0.21225,
	\sel,2,
	\rel,Pseq([0.1,0.3,0.4,0.2,0.4],inf),
	\selFreq2,Pseq([3,1,4,6,10],inf),
	\scale,Scale.locrian,
	\degree,Pseq([Pn(2,7),Pn(2,8),1,1,1,5,6,5],inf),
	\octave,Pseq([4.2,4.6,5.6],inf),
	\amp,0.2,
	\sel2,2,
	\amp2,Pseq([Pseries(1,1,100).midicps,Pn(130,30)],inf),
	\freq2,30.midicps
	))
	)
(
Pdef(\oppp,Pbind(\instrument,\uno,
	\dur,1.4/8,
	\amp,Pseq([Pn(0.947,8),Pn(0,2)],inf),
	\legato,0.2,
	\rel,0.17,
	\sel,Pseq([5],inf),
	\freq,Pseq([0.3,1.3,0.9],inf),
	\selFreq2,Pseq([2,4,1,1],inf),
	\distMix,0,
	\distFreq,Pseq([60.012,10,50,80],inf),
	\distDeep,0.13,
	\combMix,0,
	\combFreq,Pseq([2,4,8,4,2],inf),
	\ringMix,0,
	\ringFreq,8
	))
	)




(
	SynthDef("os2", {| gate=1, rate=1, beat=1.4,posc=2000|
		var sig, env,altura, seq, ritmo, seqr,buf,seqbuf,seqrvol,ritmovol;

			seqbuf=Dseq([0,2], inf);
			 buf=Demand.ar(Impulse.ar(beat),0,seqbuf);
			  seqr=Drand([2,1,1,2], inf);
			   ritmo=Demand.ar(Impulse.ar(beat),0,seqr);
			     seqrvol=Dseq([1], inf);
				ritmovol=Demand.ar(Impulse.ar(beat),0,seqrvol);
				  sig=Pan2.ar(PlayBuf.ar(1,buf,rate,Impulse.ar(beat*ritmo),posc),0);
				    sig=sig+RLPF.ar(sig,500,0.8).trunc(0.1);
				         sig=sig+HPF.ar(sig,6000,0.9);
				      sig=sig*ritmovol;
					  env=EnvGen.ar(Env.adsr(0,0,1,0), gate, doneAction:2);
					    Out.ar(0, sig*env*0.41);
					  }).send(s)
);
(
a=Prand([90,900,9000,15000],inf).asStream;
Tdef(\poal,{
	inf.do{
	    b.set(\posc,a.next);
	    //b.set(\rate,[1.2,0.9].choose);
	    0.2.wait
	    }}
	    )
	    )
	    Tdef(\poal).play
	    Tdef(\poal).stop






(
SynthDef(\uno,{|gate=1|
      var sen,env;
       sen= Klank.ar(`[[810, 171, 3453, 1773], nil, [0.1, 0.11, 0.1, 0.5]], Impulse.ar(2.5, 0, 1))*LFPulse.kr(12);
         sen=CombC.ar(sen.round(0.030),0.42,0.104,0.62)*SinOsc.kr(13,SinOsc.ar(2,0,0.4,0.5),0.4);
         env=EnvGen.kr(Env.asr(0,1,0),gate,doneAction:2);
           Out.ar(0,sen*env)
           }).send(s)
           )

           z=Synth(\uno)




	s.boot
p=ProxySpace.push(s)
~out.play
~out=~sen


(
~sen={LocalOut.ar(x=DelayN.ar(HPF.ar(LFNoise0.ar(LFNoise0.kr(1,0.61,1.952))**14.31+
       LocalIn.ar(2).excess(0.12).fold2(0.0009),10.6),0.003,Pulse.ar(0.12!2).range(1e-2,0.02)));Slope.ar(x.trunc(0.31))}
	)
(
~sen={LocalOut.ar(x=DelayL.ar(HPF.ar(LFNoise0.ar(LFNoise0.kr(3,4,12))**0.1+LocalIn.ar(2).round.round(0.02),6e3),
       2.03,LFNoise0.ar(2!2).range(1e-4,0.02)));x.trunc}
       )

~sen={LocalOut.ar(x=CombC.ar(Pulse.ar(1)+LocalIn.ar(2).fold2(0.100193).round(0.2)),0.9,LFPulse.kr(10.2));x.fold2(0.71)}

(
~sen={o=LocalOut.ar(x=DelayL.ar(HPF.ar(LFNoise0.ar(LFNoise0.kr(5,10,13))**0.01+LocalIn.ar(2).round.round(0.09),
	LFNoise0.kr(3,7200,8200)),0.03,LFNoise0.ar(12!2).range(1e-2,0.02)));Slope.ar(x.trunc);}
	)


(
~sen={o=LocalOut.ar(x=DelayN.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(5,1,4))**0.9+LocalIn.ar(2).round.sum(0.9),
	LFNoise0.kr(LFNoise1.kr(2,3,4),720,820)),0.3,LFNoise0.ar(1!2).range(1e-2,0.02)));Slope.ar(x.trunc);}
	)

//////////////

(
~sen={LocalOut.ar(x=DelayN.ar(HPF.ar(LFNoise0.ar(LFNoise0.kr(1,10,73))**40.31+
       LocalIn.ar(2).wrap2(0.012).fold2(0.009),10.6),0.03,LFNoise0.ar(0.2!2).range(1e-2,0.02)));x.trunc}
	)
(
~sen={o=LocalOut.ar(x=DelayN.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**2.9+LocalIn.ar(2).round.sum(0.9),
	LFNoise0.kr(3,7,30)),0.3,LFNoise0.ar(1!2).range(1e-2,0.02)));Slope.ar(x.fold2(0.2));}
	)


(
~sen={o=LocalOut.ar(x=DelayN.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**2.9+LocalIn.ar(2).round.sum(0.9),
	LFNoise0.kr(3,7,110)),0.3,LFNoise0.ar(1!2).range(1e-2,0.02)));Slope.ar(x.wrap2(0.12));}
	)

(
~sen={o=LocalOut.ar(x=DelayC.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(0.19),
	LFNoise0.kr(3,1,25)),0.9,LFNoise1.ar(1!2).range(0.02,0.52112)));Slope.ar(x.difsqr(0.042));}
	)

(
~sen={o=LocalOut.ar(x=DelayC.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(0.19),
	LFNoise0.kr(3,1,215)),0.9,LFNoise1.ar(1!2).range(0.02,0.52112)));Slope.ar(x.scaleneg(0.0042));}
	)

(
~sen={o=LocalOut.ar(x=DelayC.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(0.9),
	LFNoise0.kr(3,1,35)),0.9,LFNoise1.ar(1!2).range(0.02,0.52112)));Slope.ar(x.thresh(0.000142));}
	)

(
~sen={o=LocalOut.ar(x=DelayC.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(0.19),
	LFNoise0.kr(3,1,145)),0.009,LFNoise1.ar(1!2).range(0.02,0.12112)));Slope.ar(x.amclip(0.042));}
	)

(
~sen={o=LocalOut.ar(x=DelayN.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**2.9+LocalIn.ar(2).round.sum(0.9),
	LFNoise0.kr(3,7,60)),0.3,LFNoise0.ar(1!2).range(1e-2,0.02)));Slope.ar(x.fold2(0.142));}
	)

~sen={LocalOut.ar(x=CombC.ar(Pulse.ar(1)+LocalIn.ar(2).fold2(0.100193).round(0.2)),0.9,LFPulse.kr(10.2));x.fold2(0.71)}

(
~sen={o=LocalOut.ar(x=DelayC.ar(HPF.ar(LFClipNoise.ar(LFNoise0.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(10.9),
	LFNoise0.kr(2,1,40)),0.3,LFNoise0.ar(1!2).range(1e-2,0.02)));Slope.ar(x.fold2(0.42));}
	)

(
~sen={o=LocalOut.ar(x=DelayN.ar(BPF.ar(LFClipNoise.ar(LFNoise1.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(10.9),
	Dust.kr(2,1,33)),0.3,LFNoise1.ar(1!2).range(1e-2,0.02)));Slope.ar(x.round(0.00312));}
	)
(
~sen={o=LocalOut.ar(x=DelayN.ar(BPF.ar(LFClipNoise.ar(LFNoise1.kr(15,1,9))**0.9+LocalIn.ar(2).round.sum(11.9),
	Dust.kr(2,1,23)),0.3,LFNoise1.ar(0.3!2).range(1e-2,0.02)));Slope.ar(x.round(0.007));}
	)

(
~sen={o=LocalOut.ar(x=DelayN.ar(HPF.ar(LFNoise0.ar(LFNoise1.kr(1,1,9))**0.009+LocalIn.ar(2).round.sum(121.9),
	Dust.kr(1,1,23)),0.5,LFNoise1.ar(0.3!2).range(1e-1,0.02)));Slope.ar(x.trunc(0.17));}
	)

(
~sen={o=LocalOut.ar(x=DelayL.ar(BPF.ar(LFNoise0.ar(1)**0.01+LocalIn.ar(2).round.round(0.09),LFNoise0.kr(8,80,12790)),
	0.03,SinOsc.ar(1!2).range(1e-2,0.02)));x.trunc;}
	)

/////bajos
~sen={LocalOut.ar(x=AllpassL.ar(Pulse.ar(1)+LocalIn.ar(2).(0.93).clip2(0.01)),0.9,LFSaw.kr(1.2));x.wrap2(0.831)}
~sen={LocalOut.ar(x=CombC.ar(Pulse.ar(1)+LocalIn.ar(2).fold2(0.100193).round(0.2)),0.9,LFPulse.kr(10.2));x.fold2(0.71)}
~sen={LocalOut.ar(x=CombN.ar(Pulse.ar(1)+LocalIn.ar(2).fold2(0.0093).round(0.02)),3.9,LFPulse.kr(0.2));x.wrap2(0.31)}

(
~sen={o=LocalOut.ar(x=DelayL.ar(HPF.ar(Pulse.ar(1)**5.1+LocalIn.ar(2).clip2(0.2).round(0.09),6410),
	0.03,LFNoise0.ar(1!2).range(1e-2,0.02)));x.trunc;}
	)

(
~sen={LocalOut.ar(x=DelayN.ar(HPF.ar(LFNoise0.ar(LFNoise0.kr(1,10,73))**40.31+
   LocalIn.ar(2).wrap2(0.012).fold2(0.009),10.6),0.03,LFNoise0.ar(0.2!2).range(1e-2,0.02)));x.trunc(0.61)}
	)


(
~sen={o=LocalOut.ar(x=DelayC.ar(BPF.ar(LFNoise1.ar(2)**0.71+LocalIn.ar(2).clip2(0.09),LFNoise0.kr(8,42,420)),
0.33,Crackle.ar(3!2).range(0.12,0.0120)));x.trunc(0.59);}