(

SynthDef(\voicesound4,{|voiced=1 freq= 440 amp=0.1|

var formantfreqs, formantamps, formantbandwidths; //data for formants

var periodicsource, aperiodicsource, source, output;

var vibrato;

var vibratonoise= LFNoise1.kr(10);


formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants

formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants

formantbandwidths=[80,90,120,130,140];  //bandwidths


//with vibrato up to quartertone, rate of vibrato around 6+-1 Hz

//calculate vibrato in midi note (log frequency) domain; final .midicps takes it back to frequency

//line generator delays onset of vibrato like a real singer

vibrato= ((freq.cpsmidi)+(Line.kr(0.0,1.0,2.5)*SinOsc.kr(6+(1.0*vibratonoise),0,0.5))).midicps;


// low pass filter on Impulse to avoid high harmonics making it too bright

periodicsource= LPF.ar(Impulse.ar(vibrato),5000);


//pink noise drops off as frequency increases at -dB per octave,

aperiodicsource= PinkNoise.ar(0.7);


//take now as mixture of periodic and aperiodic

source= (voiced*periodicsource)+((1.0-voiced)*aperiodicsource);


output= Mix(BPF.ar(source, formantfreqs,formantbandwidths/formantfreqs,formantamps))*100*amp;


Out.ar(0,output.dup)

}).add

)


a= Synth(\voicesound4)


//can now set to intermediate mixes of vowel and consonant

a.set(\voiced, 0.8)

/////////

(

SynthDef(\voicesound5,{|voiced=1 freq= 440 amp=0.1|

var formantfreqs, formantamps, formantbandwidths; //data for formants

var periodicsource, aperiodicsource, source, output;

var vibrato;

var vibratonoise= LFNoise1.kr(10);


formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants

formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants

formantbandwidths=[80,90,120,130,140];  //bandwidths


//with vibrato up to quartertone, rate of vibrato around 6+-1 Hz

//calculate vibrato in midi note (log frequency) domain; final .midicps takes it back to frequency

//line generator delays onset of vibrato like a real singer

vibrato= ((freq.cpsmidi)+(Line.kr(0.0,1.0,2.5)*SinOsc.kr(6+(1.0*vibratonoise),0,0.5))).midicps;


// low pass filter to avoid high harmonics making it too bright

periodicsource= LPF.ar(Pulse.ar(vibrato,LFNoise2.kr(LFNoise1.kr(1,0.25,0.5),0.1,0.5)),5000);


//pink noise drops off as frequency increases at -dB per octave,

aperiodicsource= PinkNoise.ar(0.7);


//take now as mixture of periodic and aperiodic

source= (voiced*periodicsource)+((1.0-voiced)*aperiodicsource);


output= Mix(BPF.ar(source, formantfreqs,(formantbandwidths+LFNoise2.kr(LFNoise1.kr(1,0.5,4),10))/formantfreqs,formantamps))*100*amp;


Out.ar(0,output.dup)

}).add

)



a= Synth(\voicesound5)


//can now set to intermediate mixes of vowel and consonant

a.set(\voiced, 0.7)

//

{ Formlet.ar(Impulse.ar(440, 0.5,0.1),MouseX.kr(300,3000,'exponential'), 0.01, MouseY.kr(0.1,1.0,'exponential')) }.play;


used for voice synthesis:


(

SynthDef(\voicesound6,{|voiced=1 freq= 440 amp=0.1 resonancescaling=5|

var formantfreqs, formantamps, formantbandwidths; //data for formants

var periodicsource, aperiodicsource, source, output;

var vibrato;

var vibratonoise= LFNoise1.kr(10);


formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants

formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants

formantbandwidths=[80,90,120,130,140];  //bandwidths


//with vibrato up to quartertone, rate of vibrato around 6+-1 Hz

//calculate vibrato in midi note (log frequency) domain; final .midicps takes it back to frequency

//line generator delays onset of vibrato like a real singer

vibrato= ((freq.cpsmidi)+(Line.kr(0.0,1.0,2.5)*SinOsc.kr(6+(1.0*vibratonoise),0,0.5))).midicps;


// low pass filter on Impulse to avoid high harmonics making it too bright

periodicsource= LPF.ar(Impulse.ar(vibrato),5000);


//pink noise drops off as frequency increases at -dB per octave,

aperiodicsource= PinkNoise.ar(0.7);


//take now as mixture of periodic and aperiodic

source= (voiced*periodicsource)+((1.0-voiced)*aperiodicsource);


//the decaytime of the formlet is the filter's resonant decay time; a small bandwidth corresponds to a long decay (a 'ringing' filter). So I take the reciprocal of the formant bandwidth as an estimate of decaytime here, multiplied by a scaling factor for degree of resonance

output= Mix(Formlet.ar(source, formantfreqs, 0.001, resonancescaling*formantbandwidths.reciprocal, formantamps))*10*amp;


Out.ar(0,output.dup)

}).add

)



a= Synth(\voicesound6)


//can now set to intermediate mixes of vowel and consonant

a.set(\voiced, 0.9)

a.set(\resonancescaling, 20)

a.set(\resonancescaling, 2)


/////

The dual to synthesis is analysis, as already alluded to from our spectral examination of the voice above. There are various voice analysis methods which have been developed in speech telecommunications, which are of use in analyzing the singing voice and other instruments.


A classic technique is vocoding (voice encoding). A set of band pass filters is used in analysis of an original sound (tracking amplitude), and another similar bank of filters are used in resynthesis acting on a (typically simpler) source sound, modulated by the amplitude. In the basic implementation, the filter parameters are fixed in advance and not themselves input signal dependent. The method allows compression for telecommunications if the rate at which amplitudes are taken (window size) is smaller than the size of the filterbank itself.




An example should make this clearer:



(

SynthDef(\vocoder,{|freq=200 voiced=1 amp=4|

var centrefreqs, amps, bandwidths, rq; //data for formants

var analysissignal, synthesissignal, periodicsource, aperiodicsource;

var analysisfilters, synthesisfilters;


centrefreqs= (1..10)*440; //choose centre frequencies

amps= (0.dup(10)).dbamp;

bandwidths= 300.dup(10); //(1..10)*200;  //bandwidths

rq= bandwidths/centrefreqs;	//reciprocal of q; bandwidth/centrefreq


analysissignal= SoundIn.ar; //analyze audio input on machine


periodicsource=Saw.ar(freq);


//pink noise drops off as frequency increases at -dB per octave,

aperiodicsource= PinkNoise.ar(0.7);


//take now as mixture of periodic and aperiodic

synthesissignal= (voiced*periodicsource)+((1.0-voiced)*aperiodicsource);


//do the analysis in the specified bands, finding the amplitude in each band

analysisfilters = Amplitude.kr(BPF.ar(analysissignal, centrefreqs, rq));


//modulate bandwise the resynthesis

synthesisfilters = analysisfilters*BPF.ar(synthesissignal, centrefreqs, rq);


//amp compensates for energy lost by filters

Out.ar(0,(amp*Mix(synthesisfilters)).dup)

}).add

)



a= Synth(\vocoder)


a.set(\freq, 100)


a.set(\voiced, 0.2)


