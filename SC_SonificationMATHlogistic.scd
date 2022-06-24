Sonification of mathematics


Given the wonderful resources of mathematics, it's very tempting to translate mathematical structures into musical output. But be warned that the transformation does not often make perceptual sense, and can be very contrived. On the other hand, it may lead you to stimulating output you wouldn't otherwise have conceived.



//logistic map function used to generate pitch values

(
var currentvalue= 1.0.rand;
var logisticmap, r;
r=3.74;
logisticmap= {|previous=60|
	((1.0-previous)*previous*r).postln;
};
{
	150.do{
			currentvalue = logisticmap.(currentvalue);
			//must convert from the value in the range 0.0 to 1.0 to a musically useful pitch value
			//quartertones here
			Synth(\acsound,[\freq, (60+((currentvalue*12).round(0.5))).midicps]);
			0.125.wait;
			};
}.fork;
)



The example here demonstrates how the logistic map acts as a generator of values at the required rate for musical events set required, much as a UGen is a (usually much faster running) generator of sample values at audio rate. Analogous networks of number generation and modification (synthesis and processing) can be formed in algorithmic composition to determine musical parameter values for event streams.






We'll continue this next year in advanced computer music by discussing mappings and musical modeling in general. For example, we haven't touched here on data-driven modeling where a corpus is automatically analyzed to create a generative model. You may still approach such things intuitively, by formulating rules via your own personal analyses of musical style.  