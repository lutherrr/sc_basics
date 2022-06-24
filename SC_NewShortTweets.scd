(
SynthDef.new(\player, { |out, bufnum, t_trig = 1, gate = 1, rate = 1.0, volume_l = 1.0, volume_r = 1.0|
	var sig;
	sig = PlayBuf.ar(numChannels: 2, bufnum: bufnum, trigger: t_trig, rate: BufRateScale.ir(bufnum) * Lag.kr(in: rate, lagTime: ~lag_time), loop: 1, doneAction: Done.freeSelf);
    sig = sig * EnvGen.kr(Env.asr(0, 1.0, 0), gate, doneAction: Done.freeSelf);
	Out.ar(0, [sig[0] * Lag.kr(in: volume_l, lagTime: ~lag_time), sig[1] * Lag.kr(in: volume_r, lagTime: ~lag_time)]);
}).add;
)

player.play;

/* by  matt rogalsky *uwaga!/
{Splay.ar(Array.fill(100, { Pulse.ar(LFNoise2.kr(1,2500,10000)) + BPF.ar(Dust.ar(rrand(0.001,0.009)),LFNoise2.kr(0.01,50,5000),0.01,500) }))}.play;


/* by  taylan cihan */
play{Mix.fill(8,{a=LFDNoise1.kr(18);b=a.range(1e-4,0.1);AllpassC.ar(CombC.ar(FBSineC.ar(a.abs*2e4,a,a,a),b,b,b**a),b,b,a).distort*0.2}!2)}


/* by  scott wilson **uwaga!/
{GVerb.ar(Formant.ar(Duty.kr({Drand([0.1,0.17],inf)},0,["SCBerlin10!","Vielen Dank,Andre!"].collect({|t|Dseq(t.ascii/2,inf)})))/4).sum}.play


/* by  micromoog * UWAGA GENDY ale CIEKAWE/
4.do({{PanB2.ar(Gendy1.ar(1,1,1,1,rrand(150,250),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})//#supercollider

* UWAGA GENDY ale CIEKAWE/
4.do({{PanB2.ar(Gendy1.ar(1,1,1,1,rrand(50,250),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})

/* UWAGA GENDY ale CIEKAWE/HIGH
4.do({{PanB2.ar(Gendy1.ar(1,1,1,1,rrand(50,950),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})

/* UWAGA GENDY ale CIEKAWE/noise!gendy2
4.do({{PanB2.ar(Gendy3.ar(1,1,1,1,rrand(50,250),500,0.1)*LFNoise2.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})

/* UWAGA GENDY ale CIEKAWE/noise!gendy3
4.do({{PanB2.ar(Gendy3.ar(1,1,1,1,rrand(50,350),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})

/* UWAGA GENDY ale CIEKAWE/noise!uwaga OSC but mono jakby
4.do({{Osc.ar(Gendy3.ar(1,1,1,1,rrand(50,250),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})

4.do({{Osc.ar(Gendy3.ar(1,1,1,1,rrand(50,250),500,0.1)*LFNoise2.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})



/* UWAGA GENDY ale CIEKAWE/noise!uwaga OSC but mono jakby
4.do({{SinOsc.ar(Gendy3.ar(1,1,1,1,rrand(50,950),500,0.1)*LFNoise1.kr(1,0.25,0.75),LFNoise1.kr(1))}.play})





/* by  micromoog * Drone/
play{a=VarSaw.ar(SinOsc.ar(1/20,7/3,80,80),0,LFNoise1.kr(1,1/2,1/2))*Line.ar(0,1)!2;CombN.ar(a,2,2,20,1,a).softclip}//#supercollider

/* by  micromoog */
play{BPF.ar(VarSaw.ar(LFNoise1.kr(3,40,200),0,0.25)+PinkNoise.ar(0.1),LFNoise2.kr(12,700,1000),0.3)!2};//#supercollider


/* by  mstep * BASS/
{LeakDC.ar((GVerb.ar(GrainIn.ar(2,LFSaw.ar(LFSaw.ar(10)),Trig.ar(SinOsc.ar(4),1)*200,SinOsc.ar([60, 70]),0,-1),15)).tanh*0.2) }.play


/* by  Monocular Sludgebath the 7th * Uwaga Glissando High/
{Mix.fill(99,{|i| var a=LFNoise2.kr(i*[0.001,0.01]); a*RLPF.ar(Saw.ar(40+(i*10).round(5.73),0.02),(a*2e3).max(100),(i+1)*0.001)})}.play

/* by  Monocular Sludgebath the 7th * BUM/
{b=99;GVerb.ar(Mix.fill(b,{|i|a=Saw.ar([b.rand+i,LFNoise0.ar(i*0.5.rand,b,rrand(b,2e3))]);RLPF.ar(Saw.ar(a,a)*0.05,(1000*a).max(b))}))}.play

/* by  Monocular Sludgebath the 7th */
{a=99; Mix.fill(a,{|i| e=EnvGen.ar(Env({1.0.rand}!a,{rrand(1,7)}!98,i.neg,97,0));e*Blip.ar(LFNoise2.ar(7*e,7,e*[a,1e3]+8),e*a%7,0.1)})}.play


/* by  juan alzate romero *RandomGenerator/
play{a=LFNoise0;b=FBSineC.ar(a.kr(4,2e4,2e4),a.kr(10,16,17),1,1.005,0.7)!2;Latch.ar(b,Impulse.ar(a.kr(0.5,5e3,4e3)))*a.kr(5,0.4,0.5)}

/* by  juan alzate romero */
play{Resonz.ar(Crackle.ar!2,Duty.kr(Dseq([1,1,4,2,2]/8,inf),0,Dseq([99,Dwhite(99,9e3,1)],inf)),TExpRand.kr(0.001,1,Impulse.kr(8)))*4}

/* by  lfsaw * loud NIE/
{Splay.ar({RHPF.ar(Saw.ar(Rand(0.5,9),LFSaw.ar(BrownNoise.ar(1299,500))),LFNoise2.ar(f=LFNoise2.ar(9,9,1),999,0))*((f)**10).clip2}!9)}.play;


/* by  scott wilson */
{Formant.ar(Duty.kr({Drand([0.01,0.3],inf)},0,["SCBerlin10!","Vielen Dank,Andre!"].collect({|t|Dseq(t.ascii/Drand([2,9]),inf)})))*0.4}.play

/* by  scott wilson */
{f=Duty.kr({Drand([0.1,0.13],inf)},0,["SCBerlin10!","Vielen Dank,Andre!"].collect({|t|Dseq(t.ascii/2,inf)}));Formant.ar(f,f*19,f*50)/4}.play


/* by  andre bartetzki */
{FSinOsc.ar([11,11.3],0,100).sqrt.thresh(LFNoise0.ar(1.3,70)).scaleneg(Pulse.ar([7,8]*1000)).distort.ring4(LFNoise2.ar([0.3,0.3]))}.play



/* by  julian rohrhuber *Cut Cut/
Ndef(\y, { a = {{ Drand([Dshuf({0.0001.rand}!rrand(2,11),SinOsc.kr(0.1)*40), 0.05], inf) }}; TDuty.ar(a!2!8,0,0.1).sum  }).play;


/* by  tweety on a power cord * BIRDS/
{SinOsc.ar(SinOsc.ar([0.1, 0.2],0.5,{LFNoise2.kr(25, 0.5, 2.5)}!2)/SampleDur.ir)}.play;


/* by  jonatan liljedahl *Ciekawe Feedback Mic/
play{a=PinkNoise.ar(LFNoise1.ar(9,0.05));9.do{a=LeakDC.ar(CombN.ar(a,0.3,{0.3.rand+0.03}!2,7))};LPF.ar(tanh(LPF.ar(a+a.mean,777)),7777)}


/* by  jonatan liljedahl */Ciekawe Drone ROSNIE UWAGA!!!/
n=LFNoise1;Ndef('x',{a=SinOsc.ar(65,Ndef('x').ar*n.ar(0.1,3),n.ar(3,6)).tanh;9.do{a=AllpassL.ar(a,0.3,{0.2.rand+0.1}!2,5)};a.tanh}).play

/* by  jonatan liljedahl UWAGAGAGAGGA*!!!CIEKAWE UWAGA!!!!/
play{v=Dust2.ar(4!2);7.do{|n|v=LeakDC.ar(CombL.ar(v,0.2,n*0.001+0.03+LFNoise1.kr(10,0.001),3))};v.clip2(1)};


/* by  marcus wrangoe * Klang!/
play{x=6666;b=SinOsc;d=Dust;t=Trig.ar(d.ar(x),b.ar(0.001));f=t*b.ar(x+b.ar*t);Limiter.ar(GVerb.ar(GrainIn.ar(2,t,f,f,b.ar(x)),9,9)*0.2,0.6)}

/* by  josh parmenter *UWAGAGAGGAGAGA!!!/
{r={|y,z|50.collect{Rand(y,z)}};Pluck.ar(Crackle.ar*0.01,Dust.kr(r.(9,12)),0.01,SinOsc.kr(1/r.(50,20),r.(0,6),4e-4,5e-4),3,0.01).sum}.play;


/* by  josh parmenter *UWAGAGAGGAGAGA!!!glosniej WAZNE /
{r={|y,z|50.collect{Rand(y,z)}};Pluck.ar(Crackle.ar*0.3,Dust.kr(r.(9,12)),0.01,SinOsc.kr(1/r.(10,5),r.(0,6),4e-4,5e-4),3,0.01).sum}.play;

/* by  aucotsi */
play{c=LFPulse.kr(0.5);b=SinOsc.kr(0.0034);a=Line.kr(0.1,2pi,37);FreeVerb.ar(Blip.ar(a*340!2*Impulse.kr(b*34/pi),c*TIRand.kr(0,113,c),c))}

/* by  aucotsi * UWAGA/
play{b=SinOsc.kr(5);a=Line.kr(0.1,2pi,37);FreeVerb.ar(SinOsc.ar(a*341!2*Impulse.kr(b*680/pi),LFPulse.kr(2,0,pi/2),LFPulse.kr(3,0,1/pi*b)))}

/* by  josh parmenter *UWAGA/
3.do({{b=Decay2.kr(Dust.kr(0.1),5,7);Pan2.ar(HPF.ar(LPF.ar(WhiteNoise.ar(b+0.4),b*1500+200),b*100+100)*5,1.0.rand2)}.play})//surf's up

/* by  aucotsi */
play{c=LFPulse.kr(50);a=Line.kr(0.1,2pi,37000);b=SinOsc.kr(a/pi);FreeVerb.ar(Blip.ar(a*340!2*Impulse.kr(b*340/pi),c*TIRand.kr(0,999,c),c))}



/* by  marcus wrangoe */
play{Klank.ar(`[[99,98,953,923],nil,[1,1,1,1]],GVerb.ar(CombC.ar(Gendy1.ar(6,6,3,Dust.ar([99,98],1),20,400),1,0.01,0.02),9,9,mul:0.005))}

/* by  aucotsi */
play{#a,b,c=[LFSaw,TRand,SinOsc];a.ar(c.kr(5),b.kr(-2pi,2pi),b.kr(0.1,1.0,c.kr(340)))*c.ar(680!2*c.kr(b.kr(87,393,c.kr(7))),0,c.kr(pi/13))}


/* by  julian rohrhuber */
Ppar({|i| Pbind(\dur, 0.01, \note, sin(i+1*0.002.rand*Pseries()+2.0.rand)*40.rand-10) } ! 5).play;


/* by  stefan nussbaumer */
play{e=Drand((3..65),inf);d={|i|p=Impulse.ar(i+1*2)}!2;GVerb.ar(Blip.ar(Demand.kr(A2K.kr(p),0,e),TExpRand.ar(2e4,20,d*10)),100,0.02,0.02)};

/* by  nathaniel virgo */
x=Ndef(\x,Pbind(\freq,Pseq(a=(3..5);a/.x a*.x[40,80],8)));Ndef(\,{Limiter ar:GVerb.ar(PitchShift.ar(Ndef ar:\,1,2,0,0.1),30,9)/4+x.ar}).play;

/* by  jonatan liljedahl *SPRAWDZ/
play{sum({|i|GrainSin.ar(1,Impulse.ar(LFTri.kr(0.05*i+[0.2,0.201]).range(1,30)),0.02, 200*i+50)}!9).tanh};


/* by  jonatan liljedahl */
play{sum({|i|GrainSin.ar(1,Impulse.ar(LFNoise1.kr(0.5!2).range(1,30)),0.025, 200*i+100)}!7).tanh}

/* by  jonatan liljedahl */
play{a=ar(PinkNoise,5e-4);ar(GVerb,({ar(Ringz,a*LFNoise1.kr(0.2),exprand(60,8000),3)}!40).sum,50,99).tanh}

/* by  jonatan liljedahl */
play{GVerb.ar(GVerb.ar(Impulse.ar([8,6,4]/100,[0,0.2,0.6])*8,[2,3,1.5],90,drylevel:0).sum.sin.sum*0.5,62,24).tanh}


/* by  chad mckinney *UWAGA/
play{b=LocalBuf(8192,4);d=Dust.kr(9)+Dust2.kr([4,4]);r=PlayBuf.ar(2,b,TExpRand.kr(0.01,19,d),d,0,1)/4;FFT(b,d+(d*r));Out.ar(0,r.clip2(1))};


/* by  redfrik */
play{a=SinOscFB;sum({|i|a.ar(a.ar(a.ar(a.ar(i+1,1/9,999),1/9,a.ar(1/9,1,1/9)),a.ar(0.1,3),i+2*999),a.ar(1/9,1/9),1/9)}!9)!2}//#SuperCollider

/* by  redfrik */
play{b=LocalBuf(9e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(12,3e4,4e4)),9e4);BufWr.ar(Saw.ar([8,9]),b,i);BufRd.ar(2,b,i)/2}//#SuperCollider

/* by  juan alzate romero *!!!!/
play{d=Duty;f=d.kr(1/[1,2,3],0,Dseq([0,3,7,12,8]+36,inf));GVerb.ar(Blip.ar(f.midicps*[1,2,3],LFNoise1.kr(1,8,8)).sum,99,4)} // #sc


/* by  juan alzate romero *!!!/
Buffer.allocConsecutive(8,s,1024,1,{|b,i|b.sine1Msg(1/(1..((i+1)*6)))},0);{f=[50,75,99];VOsc3.ar(LFNoise1.kr(1/4,3,4),*f).lag(3e-3)!2}.play


/* by  juan alzate romero */
play{l=LFCub;Splay.ar(l.ar(l.kr(9.1,0,100,(200,300..500)),0,(l.kr(9,0,1,l.kr(1/[2,3,5,7],0,0.5,0))>(l.kr(1/2,0,0.4,0.5))).lag/2))} // #sc

/* by  alexandra cardenas */
{Splay.ar({Integrator.ar(LFPulse.ar(rrand(0.1,42.0),0.3,4e-4),0.999,VarSaw.ar(LFDNoise3.kr(2.1).range(100, 3600)),0)}!22,1,0.7,0)}.play


/* by  thor *UWAGA/
play{a=SinOsc.ar(0.15).clip(0,1);(Decay2.ar(LFSaw.ar(13)*a, 0.1)+DelayC.ar(RLPF.ar(PinkNoise.ar(0.3)*a,2300,0.1),3,3))!2}

/* by  redfrik *uwaga/
play{f=LFPar.ar(1/14).round*20+80;Splay.ar(LFPar.ar({|i|[i+1*f,i*f+(i+1/3)]}!4)>BrownNoise.ar(Pulse.ar({|i|i+1}!4,0.35))/3)}//#SuperCollider


/* by  redfrik *Ciekawe Sprawdz!!!/
play{x=CombN.ar(Phasor.ar(0,{|i|i+1/20}!22),0.042,0.042);y=Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,400,500)),x);Splay.ar(y)*0.25}//#SuperCollider
