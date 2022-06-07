

Probability distributions

A probability distribution gives a relative weight to each available option in the space of possible outcomes; this is the probability density function (pdf). For a discrete set of possible outcomes, there is an explicit probability mass for each; for a continuous set (e.g., any number from the range 0.0 to 1.0) a mass can be associated with any interval. The sum of the probability density is normalized to 1.

From a probability density function we can create a cumulative distribution function (cdf) which allows us to  calculate which output we get on a particular occasion (particular roll of the dice).




//Helper functions for investigating pdfs and cdfs


(


//normalize total sum of an array to 1.0


~normalize = {|array|   array/(array.sum)}; //note, not safe if array is empty or otherwise sums to zero
//(could also use normalizeSum, just showing this explicitly)



//create array of cumulative values, assuming input is normalized (sums to 1.0)


~cumulative = {|array|


var num = array.size;
var accumulate = 0.0;
var cumul;

cumul = array.collect{|val, i|  var old= accumulate; accumulate = accumulate+val; old};

cumul
};



//use cumulative distribution to find an output value for an input
//assumes array is a cumulative distribution function, and array size is at least 1


~draw= {|input, array|


var nextindex;

nextindex= array.indexOfGreaterThan(input); //also see indexInBetween if want linearly interpolated index





//get nil if input greater than anything in array


if (nextindex.isNil,{nextindex= array.size;});

nextindex= nextindex-1; //get index before; we 'went past' and have to go one back to find the slot our input falls in

//nextindex should never be less than 0

nextindex/(array.size); //get position proportional within array length
}

)




Plotting approximations to different probability distributions:




//1. Uniform distribution, equal chance for any equal subsection of the range:



p= ~normalize.value(Array.fill(1000,1.0));

p.plot2(minval:0.0, maxval:2.0/1000)  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values; driven by uniform random number, could also just provide increasing uniform numbers from 0.0 to 1.0 (and then wouldn't need the sort)
//we do this a thousand times to simulate 'rolling the dice' many times; the distribution only really shows itself over many trials (and can do it more times for better approximations)





Array.fill(1000,{ 1.0.rand }).sort.plot2 //create values directly




//2. Linear distribution, probability density drops linearly, so more likely to get lower values:



p= ~normalize.value(Array.fill(1000,{|i| 1000-i}));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values

Array.fill(1000,{ 1.0.linrand }).sort.plot2 //create values directly




//3. Negative exponential distribution, probability density drops exponentially, so much more likely to get lower values:






//there is a parameter here for the rate of fall off of the distribution


~alpha= 10.0;

p= ~normalize.value(Array.fill(1000,{|i| exp((i.neg/1000)*~alpha) }));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values




//go back and try ~alpha= 100.0; note the quantisation caused by only working with arrays of limited size as we create a discrete approximation to the ideal continuous distribution






//4. Normal distribution (Gaussian)





//two parameters, mean ('centre') and standard deviation ('spread'); here we take sensible values to plot the distribution easily



~mu= 0.5; //mean
~sigma=  0.17; //standard deviation; most of probability mass within 3 standard deviations, so this makes the Gaussian fit the 0.0 to 1.0 range easily for our plotting; try changing these parameters later to see the effect.



//normalization constant calculated automatically, though there is a mathematical expression for it


p= ~normalize.value(Array.fill(1000,{|i|  exp((((i/1000)-~mu)/~sigma).squared.neg)}));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values

Array.fill(1000,{  0.5.gauss(0.17).max(0.0).min(1.0)  }).sort.plot2 //create values directly, clamping within +-3 standard deviations








//5. Arbitrary distribution





//let's make up our own function



p= ~normalize.value(Array.fill(1000,{|i|  var prop= (i/1000.0); if(prop<0.2,{(0.2-prop)**(0.3)},{(prop-0.2)**2}) }));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values




//example in use; 20 notes drawn using the custom distribution (0.0 to 1.0 range output rescaled to MIDI notes 48 to 72)


(
	{
		50.do{
			Synth(\acsound,[\freq, 48+(24*~draw.value(1.0.rand, c))]);
			//could quantise the notes to discrete pitches, e.g., with .round(1.0)

			0.25.wait;
		}
	}.fork;
)



A!!!


(
	{
		50.do{
			Synth(\acsound,[\freq, 248+(1044*~draw.value(1.0.rand, c))]);
			//could quantise the notes to discrete pitches, e.g., with .round(1.0)

			0.25.wait;
		}
	}.fork;
)



A!!!!!!!


(
	{
		1000.do{
			Synth(\acsound,[\freq, 48+(3044*~draw.value(1.0.rand, c))]);
			//could quantise the notes to discrete pitches, e.g., with .round(1.0)

			rrand(0.01,0.24).wait;
		}
	}.fork;
)



A!!!!!!!


p= ~normalize.value(Array.fill(1000,{|i| 1000-i}));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf

(
	{
		1000.do{
			Synth(\acsound,[\freq, 48+(3044*~draw.value(1.0.rand, c))]);
			//could quantise the notes to discrete pitches, e.g., with .round(1.0)

			rrand(0.01,0.24).wait;
		}
	}.fork;
)


AAAA

~mu= 0.5; //mean
~sigma=  0.17; //standard deviation; most of probability mass within 3 standard deviations, so this makes the Gaussian fit the 0.0 to 1.0 range easily for our plotting; try changing these parameters later to see the effect.



//normalization constant calculated automatically, though there is a mathematical expression for it


p= ~normalize.value(Array.fill(1000,{|i|  exp((((i/1000)-~mu)/~sigma).squared.neg)}));

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)}).sort.plot2 //choose values

Array.fill(1000,{  0.5.gauss(0.17).max(0.0).min(1.0)  }).sort.plot2 //create values directly, clamping within +-3 standard deviations



(
	{
		1000.do{
			Synth(\acsound,[\freq, 48+(244*~draw.value(1.0.rand, c))]);
			//could quantise the notes to discrete pitches, e.g., with .round(1.0)

			rrand(0.01,0.24).wait;
		}
	}.fork;
)

----------------



There are many other interesting distributions you might investigate, see for example:
Charles Ames. A catalog of statistical distributions: Techniques for transforming random, determinate and chaotic sequences. Leonardo Music Journal, 1(1):551991.
Denis Lorrain. A panoply of stochastic 'cannons'. Computer Music Journal, 41(1):531980.


In practice, we often work with a relatively small discrete set of options. It is easy to create a custom probability distribution over a set:

[0,1,2,3,4,5].wchoose([0.2,0.3,0.1,0.1,0.05,0.25]) //make sure weights add to 1.0, or use normalizeSum




//examination using our machinery for pdf, cdf, and draws:


p= ~normalize.value([0.2,0.3,0.1,0.1,0.05,0.25]);

p.plot2  //pdf

c= ~cumulative.value(p);

c.plot2	//cdf



Array.fill(1000,{ ~draw.value(1.0.rand, c)*6}).sort.plot2 //choose values; multiply by 6 to get back integer indices

================



--+--random array


(
Pbind(
	\dur,0.225,
	\midinote, Pseq([Array.rand(20, 40.7,122.4)].choose ,inf),
	\amp, Prand([0.125, 0.2, 0.25],inf)
).play(quant:1.0)
)
=======
A1
(
Pbind(
	\dur,rrand(0.125,0.225),
	\midinote, Pfunc(15*{ rrand(2.0,4.0) },inf),
	\amp, Pfunc({ 4.rand })
*0.2).play(quant:1.0)
)

A2
(
Pbind(
	\dur,rrand(0.125,0.225),
	\freq, Pseq([Array.rand(26,32.0,124.0)].choose ,inf),
	\amp, Pfunc({ 3.rand })
).play(quant:1.0)
)


== A3!now
(
Pbind(
	\dur,0.25,
	\freq, Pfunc({ rrand(50,200)},inf),
	\amp, Pfunc({ 4.rand })
*0.2).play(quant:1.0)
)


========
Array.rand(20, 0.7,2.4);



[ 1.4102102637291, 1.2253129959106, 1.1853059053421, 2.1517772555351, 0.95074297189713, 1.2606810927391, 2.2465686917305, 2.2790756940842, 1.7183935880661, 1.1514030098915 ]


(
Pbind(
	\dur,rrand(0.125,0.225),
	\midinote, Pseq([ 2.0323868513107, 0.91765718460083, 1.9139981746674, 1.685328066349, 2.0944345831871, 1.2574933171272, 0.81890585422516, 2.1306471467018, 2.3025797128677, 1.0170067548752, 1.6755695819855, 0.91722694635391, 1.589040017128, 1.3073709607124, 1.2198429107666, 0.96586332321167, 1.3887617826462, 2.3836031198502, 1.7883840084076, 1.6410546660423 ]*15,inf),
	\amp, Pfunc({ 4.rand })
*0.2).play(quant:1.0)
)


==streams


(
	s = Server.local;
	SynthDef(\help_SPE2, { arg i_out=0, sustain=1, freq;
		var out;
		out = RLPF.ar(
			LFSaw.ar( freq ),
			LFNoise1.kr(1, 36, 110).midicps,
			0.1
		) * EnvGen.kr( Env.perc, levelScale: 0.3,
							timeScale: sustain, doneAction: 2 );
		//out = [out, DelayN.ar(out, 0.04, 0.04) ];
		4.do({ out = AllpassN.ar(out, 0.05, [0.05.rand, 0.05.rand], 4) });
		Out.ar( i_out, out );
	}).send(s);
)


(
// streams as a sequence of pitches
	var pattern, streams, dur, durDiff;
	dur = 1/7;
	durDiff = 3;
	pattern = Prout.new({
		loop({
			if (0.5.coin, {
				#[ 24,31,36,43,48,55 ].do({ arg fifth; fifth.yield });
			});
			rrand(2,5).do({
				// varying arpeggio
				60.yield;
				#[63,65].choose.yield;
				67.yield;
				#[70,72,74].choose.yield;
			});
			// random high melody
			rrand(3,9).do({  #[74,75,77,79,81].choose.yield });
		});
	});
	streams = [
		(pattern - Pfunc.new({ #[12, 7, 7, 0].choose })).midicps.asStream,
		pattern.midicps.asStream
	];
	Routine({
		loop({
			Synth( \help_SPE2, [ \freq, streams.at(0).next, \sustain, dur * durDiff  ] );
			durDiff.do({
				Synth( \help_SPE2, [ \freq, streams.at(1).next, \sustain, dur  ] );
				dur.wait;
			});
		})
	}).play
)







