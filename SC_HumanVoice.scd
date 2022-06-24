//The Human Voice

//Use internal server:

Server.default= s= Server.internal;


//The voice can be considered as a source and filter system where the source is a periodic oscillation at the vocal folds (for vowel like sounds), or aperiodic air turbulence (for consonantal sounds).

//So the simplest models might look like :

(
SynthDef(\voicesound1,{|voiced=1 freq=440 amp=0.1|
var source, filter;
//flag for voiced (periodic) or unvoiced (aperiodic, noise source)
source = if(voiced,Impulse.ar(freq),WhiteNoise.ar(0.2));
filter= BLowPass.ar(BPF.ar(source,2000,0.1, source),4000, 0.25,100); //add a boost to source around 2000 Hz, and also low pass overall
Out.ar(0,amp*filter.dup)
}).add
)

a= Synth(\voicesound1);
a.set(\voiced, 0);


//However, this doesn't yet sound even slightly convincing.

//One necessary complication is in the filtering. Our nose and throat is a complex system, with many independent muscle groups acting to control the position of tongue, lips, air spaces and relative flow into the nose. In order to make more convincing syntheses, we need better filter data. Each phone (distinct sound which the voice can create) has particular physical settings, and associated filtering.

//One way of modeling the filtering is to look at important peaks and troughs in the frequency spectrum of a given sound; we model the spectral envelope. The major peaks are called the formants, and for a vowel or voiced consonant there tend to be up to five major peaks. Formant data varies between voice types, but charts are available (one table of formants is available here: http://ecmc.rochester.edu/onlinedocs/Csound/Appendices/table3.html)


//formant positions:

//soprano 'a' sound, direct additive synthesis, one source per formant

(
SynthDef(\voicesound2,{|voiced=1 freq= 440 amp=0.1|
var formantfreqs, formantamps, formantbandwidths; //data for formants
var output;
formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants
formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants
formantbandwidths=[80,90,120,130,140];  //bandwidths
output= Mix(SinOsc.ar(formantfreqs,0,formantamps))*amp;
Out.ar(0,output.dup)
}).play
)

//soprano 'a' sound, subtractive synthesis, pass source waveform through formant filtering
(
SynthDef(\voicesound3,{|voiced=1 freq= 440 amp=0.1|
var formantfreqs, formantamps, formantbandwidths; //data for formants
var source, output;
formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants
formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants
formantbandwidths=[80,90,120,130,140];  //bandwidths
source = if(voiced,Impulse.ar(freq),WhiteNoise.ar(0.2));
output= Mix(BPF.ar(source, formantfreqs,formantbandwidths/formantfreqs,formantamps))*10*amp;
Out.ar(0,output.dup)
}).add
)

a= Synth(\voicesound3);
a.set(\voiced, 0);

//viewing through the frequency scope, humps in the spectrum are visible; note how the Whitenoise is too noisy, and the impulse sound too pure a chain of harmonics!

FreqScope.new;


//VIBRATO!!! let's tweak things by adding in some more complicated sources with VIBRATO!!!:

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

a= Synth(\voicesound4);



//can now set to intermediate mixes of vowel and consonant

a.set(\voiced, 0.8);



// Vibrato periodic aperiodic etc. For further realism, might modulate subtly the formant data, and experiment with other source waveforms than the impulse


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


a= Synth(\voicesound5);

//can now set to intermediate mixes of vowel and consonant
a.set(\voiced, 0.7);



Let's take a moment to look at the formants in our own voices


{SoundIn.ar}.play;



//To best analyse these over time, hold a stable mouth shape and pitch (sing 'ah' at a comfortable and stable pitch) and look for peaks in the spectrogram (which should stay relatively stable since you are holding stable, give or take some slight noise due to the character of your own voice).

//There are some UGens in SuperCollider which assist in synthesising formants, that is, prominent energy peaks above a fundamental frequency.


[Formlet]

//Formlet is a filter which imposes a resonance at a specified frequency. The filter has a similar response to a classical method of synthesising formant waveforms called Fonction d'onde formantique (FOF) as used in IRCAM's Chant synthesiser from the 1980s (see the Roads Computer Music Tutorial, or http://www-ccrma.stanford.edu/~serafin/320/lab3/FOF_synthesis.html, for example)

//single formant:

{ Formlet.ar(Impulse.ar(440, 0.5,0.1),MouseX.kr(300,3000,'exponential'), 0.01, MouseY.kr(0.1,1.0,'exponential')) }.play;



//used for voice synthesis//A!!! 6:

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

a= Synth(\voicesound6);

//can now set to intermediate mixes of vowel and consonant
a.set(\voiced, 0.9);
a.set(\resonancescaling, 20);
a.set(\resonancescaling, 2);


//It is also possible to get formant like bulges in a sound's spectrum above the fundamental frequency, by using hard sync type oscillators. One variant from the late 1970s is called VOSIM and a simulation UGen is available in the sc3-plugins pack. It is also possible to create hard sync via some UGens like SyncSaw or just by retriggering an envelope used as a waveform. In these settings, the attributes of the source which is getting retriggered with each hard sync signal is critical in determining the spectral content.


//The dual to synthesis is analysis, as already alluded to from our spectral examination of the voice above. There are various voice analysis methods which have been developed in speech telecommunications, which are of use in analyzing the singing voice and other instruments.

//A classic technique is vocoding (voice encoding). A set of band pass filters is used in analysis of an original sound (tracking amplitude), and another similar bank of filters are used in resynthesis acting on a (typically simpler) source sound, modulated by the amplitude. In the basic implementation, the filter parameters are fixed in advance and not themselves input signal dependent. The method allows compression for telecommunications if the rate at which amplitudes are taken (window size) is smaller than the size of the filterbank itself.


//An example should make this clearer:

//Vacoder with MIC!



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

a= Synth(\vocoder);

a.set(\freq, 100)



a.set(\voiced, 0.2)





//you can swap in other sources, filters, make the effects time varying and generally energise the sound.



(also see work by Josh Parmenter in his sc3-plugins packs; Vocoder, Vocode and VocodeBand classes).







Analysis methods must attempt to model the (changing) spectral envelope of a sound, and each must choose a compromise between following all the (noisy) detail in the spectrum, and approximating it (finding formant areas). They are generally useful beyond the voice, in that they are a way of picking up on timbral characteristics of sounds, and designing a filter which has a spectral response like a given sound.



Two classic methods to mention here are:

LPC = Linear Predictive Coding

MFCC = Mel Frequency Cepstral Coefficients



Some SC UGens to explore these:

LPCAnalyzer //in the NCAnalysis sc3-plugins extension; also some LPC resynthesis UGens work by Josh Parmenter in his own sc3-plugins set

MFCC //in core





Note that with vibrato, the spectral envelope stays fixed, and the harmonics of the periodic source change amplitude, mapping out the spectral envelope pattern. So vibrato can assist in hearing out formants associated with a particular vowel sound (Xavier Rodet and Diemo Schwarz. "Spectral envelopes and additive+residual analysis/synthesis". In James Beauchamp, editor. Analysis, Synthesis and Perception of Musical Sounds. Springer, New York, NY, 2007, pages 175–227.)









High quality singing voice synthesis (i.e., Vocaloid) is acheived using large pre-analyzed databases of voice phones and diphones (transitions between two phones). These are strung together as required, a form of "concatenative synthesis". In general, singing voice synthesis remains a challenging problem in computer music.











