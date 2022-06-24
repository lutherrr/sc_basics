//SuperCollider Music Information Retrieval (SCMIR) library
//https://www.youtube.com/watch?v=jxo4StjV0Cg

EXAMPLES::

code::
//[0] onset trigger
//[1] corrected to minima time of last onset
//[2] most recent slope measurement
//[3] average slope calculation
//[4] raw detection function
//[5] raw peakpick function

b = Buffer.read(s,"/Users/lisek/Desktop/sound_PIANO/piano_AI_TN8wBPAU.wav");
//minimal example
(
{
//var source = SoundIn.ar;
var source = PlayBuf.ar(1,b,loop:1);
var slopeanalysis = AttackSlope.kr(source,peakpicksize:20,sumthreshold:40);

//slopeanalysis.poll;

K2A.ar(slopeanalysis);

//old now [4,5,1]
//K2A.ar([slopeanalysis[0],100*slopeanalysis[1],slopeanalysis[2]])

//K2A.ar([slopeanalysis[0],100*slopeanalysis[1],slopeanalysis[2]])


}.plot(10.0,minval:0.0,maxval:1.0)
)

//


b = Buffer.read(s,"/Users/lisek/Desktop/sound_PIANO/piano_AI_TN8wBPAU.wav");

//minimal example
(
{
	//var source = SoundIn.ar;

	var source = PlayBuf.ar(1,b,loop:1);

	var analysis =
	BeatStatistics.kr(FFT(LocalBuf(1024),source));

	analysis.poll(100);

	source
}.play;
)

//Spectral Entropy

Examples::

code::

(
{

var in, fft, entropy;

//in = SinOsc.ar(MouseX.kr(100,1000),0,0.1);
//in = Mix(SinOsc.ar([440,MouseX.kr(440,880)],0,0.1));
in= SoundIn.ar;

fft = FFT(LocalBuf(2048), in);

entropy=SpectralEntropy.kr(fft,2048,1);	//one output band (so full spectrum's entropy)

entropy.poll;

Out.ar(0,Pan2.ar(0.1*Blip.ar(100,10*(entropy.sqrt))));
}.play
)

