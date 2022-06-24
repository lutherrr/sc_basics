(
SynthDef(\acsound,{|freq=440,amp=0.1,dur= 0.2,cutoff=2000|
var sound, filter;
sound= Saw.ar(freq, amp)*EnvGen.kr(Env([0,1,1,0],[0.01,0.05,(dur.max(0.07))-0.06]),doneAction:2);
filter= LPF.ar(sound,Line.kr(cutoff,300,dur));
Out.ar(0,filter.dup(2))
}).add;
)






/1st order Markov system example

(
var markovmatrix;
var currentstate=3.rand; //start in one of three states
markovmatrix= [
[0.7,0.2,0.1],
[0.0,0.5,0.5],
[0.3,0.4,0.3]
];

{
	120.do{
			Synth(\acsound,[\freq, [48,60,64].at(currentstate).midicps]);
			//which probability distribution to use depends on what state we're in right now
			currentstate = [0,1,2].wchoose(markovmatrix[currentstate]);
			0.25.wait;
			};
}.fork;
)



For fixed and variable order Markovian modeling see also the MathLib and ContextSnake Quarks.

////SEARCHSearch


//Search is a fundamental operation in computer algorithms. Musical parameterisations lead to combinatorially explosive search spaces, and issues of computational tractability. Heuristics are rules of thumb to cut down the amount of brute search by pruning the search tree.


//Charles Ames differentiates: comparative search: an exhaustive search through all options. Can find an optimal solution, but usually too computationally intensive constrained search: finds a `good' solution by approximate methods, i.e., heuristics.


//An early strategy (used back in 1955 by Hiller and Isaacson's) was generate and test. Random numbers are generated until they pass a test. The passed number becomes the latest choice, and a new selection is then made. Alternatively, we might restrict generations to only acceptable options in the first place (by heuristics).


///More complicated strategies include back tracking (jumping back to an earlier decision point when a path has led to an impasse) and dynamic programming (greedy selection of the best option according to a cost function at any point, to comparison of multiple paths taking into account all steps but keeping down the proliferation of possible paths by only following best scoring paths to any given branching point).


//You should see that any machinery from AI (whether GOFAI symbolic or connectionist) may be imported to problems of musical search.



//generate and test

(

var currentvalue= rrand(60,72);
var generateandtest;

generateandtest= {|previous=60|
	var number=rrand(24,127);
	var keeplooking;

	//keep searching until a number passes the tests

	while({
		keeplooking= false; //can only fail

		//note we could replace this test with just generating number in the allowable range to start with

		if (abs(number-previous)>12) {
			keeplooking= true;
		};


		//avoid certain intervals
		if (#[-5,-3,4,7,11].includes(number-previous)) {
			keeplooking= true;
		};

		((number.asString)++(if(keeplooking," rejected","accepted"))).postln;
		keeplooking
	},{

	//no need to do anything here, all done in while test function
	number=rrand(24,127);
	});
	number
};


{
	120.do{

			currentvalue = generateandtest.(currentvalue);
			Synth(\acsound,[\freq, currentvalue.midicps]);

			0.1.wait;
			};
}.fork;
)




