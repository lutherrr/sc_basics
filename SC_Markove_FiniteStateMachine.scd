//Pfsm
//Finite State Machine
//Every state consists of an item and an array of integer indices of possible next states. The initial state is chosen at random from the array of entry states. That chosen state's item is returned, and the next state is chosen from its array of possible next states. When the end state is chosen, the stream ends.

(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)


(
a = Pfsm([
        #[0,1],
        67, #[0, 0, 3],
        72, #[2],
        73, #[0, 2],
        Pseq([74, 75, 76, 77]), #[2, 3, 3],
        nil, nil
    ], inf).asStream;
Routine({
    loop({
        Synth(\help_sinegrain, [\freq, a.next.midicps]);
        0.1.wait;
    })
}).play;
)

(
Pfsm([
    #[5, 6, 7], // entry states

    //e1 (== state 0)
    Pbind( \dur, Pseq([ 1/8, 3/8 ]), \midinote, Pseq([ 86, 75 ]) ),
    //#[1],    // as given in CMJ
    // my de-boredom-ated version..
    #[1, 1, 1, 1, 1, 1, 1, 8],
    //e2 (== state 1)
    Pbind( \dur, 1/2, \midinote, Pseq([ 69 ]) ),
    #[0, 1],
    //e3 (== state 2)
    Pbind( \dur, 1/3, \midinote, Pseq([ 55, 60, 66 ]) ),
    #[0, 1, 2, 2, 2, 2, 3, 3, 3, 3],
    //e4 (== state 3)
    Pbind( \dur, 1/4, \midinote, Pseq([ 81, 80, 77, 76 ]) ),
    #[1, 4, 4, 4, 4],
    //e5 (== state 4)
    Pbind( \dur, Pseq([1, 2/3, 2/3, 2/3, 1]), \midinote, Pseq([ \, 70, 70, 70, \ ]) ),
    #[2, 3],
    //e6 (== state 5)
    Pbind( \dur, 1/4, \midinote, Pseq([ 59, 61 ]) ),
    #[0, 2, 4, 5, 5, 5, 5, 5, 5, 5],
    //e7 (== state 6)
    Pbind( \dur, 1/4, \midinote, Pseq([ 87, 88 ], 2) ),
    #[4, 4, 4, 4, 6, 6, 6, 7, 7, 7],
    //e8 (== state 7)
    Pbind( \dur, 1, \midinote, Pseq([ 56 ]) ),
    #[1, 3, 6, 6, 6],
    // terminal state
    nil, nil
]).play;
)


//Dfsm : DUGen : UGen : AbstractFunction : ObjectExtensionExtension
//demand rate finite state machine
//Similar to Pfsm, Dfsm implements a markov chain. Each state has a number of next states out of which one is randomly chosen.

s.boot;

// random jumps
(
{
    var a, b, trig = Impulse.kr(MouseX.kr(4, 100, 1));
    a = Dfsm([[1], 1.5, [0, 1], 2.5, [0, 1]]);
    b = Demand.kr(trig, 0, a).poll(trig);
    SinOsc.ar(b * 200 + 300) * 0.1
}.play
);

// 2.5 may come after 1.5, but not the other way round.
(
{
    var a, b, trig = Impulse.kr(MouseX.kr(4, 100, 1));
    a = Dfsm([[0], 1.5, [0, 0, 1], 2.5, [1, 2], 0.5, [0]]);
    b = Demand.kr(trig, 0, a).poll(trig);
    SinOsc.ar(b * 200 + 300) * 0.1
}.play
);



// embed demand ugens, embed 2 of each, end with series of 4, 5, 3.
(
{
    var a, n = 2, trig = Impulse.kr(MouseX.kr(4, 100, 1));
    a = Dfsm([
        [0], // entry states
        Dseq([-2, -3], inf), [1],
        Dseq([1, 2, 1.5], inf), [0, 0, 0, 1, 2],
        Dseq([4, 5, 3], inf) // exit state
    ], n);
    b = Demand.kr(trig, 0, a).poll(trig);
    SinOsc.ar(b * 200 + 700) * 0.1
}.play
);


// direct audification. A!
(
{
    var a, b, pseudorandomness;
    pseudorandomness = Dswitch1((0..1000).scramble / 1000, Dwhite(0, 1, inf)
        * MouseY.kr(1, 1000, 1));
    a = {
        var next = { { #[0, 1, 2, 3].choose } ! rrand(2, 5) };
        var n = 2;
        var d = Dfsm([
            next.value,
            Dseq([0, 0, 1], inf), next.value,
            Dseq([-1, 0].clipExtend(10.rand + 2), inf), next.value,
            Dseq([1, 0, -1, 0].clipExtend(10.rand + 4), inf), next.value,
            Dwhite(0, 1, inf), next.value,
            0
        ],
        MouseX.kr(1, 1115, 1),
        pseudorandomness
        );
        Pan2.ar(Duty.ar(SampleDur.ir, 0, d), LFNoise1.kr(1))
    } ! 5;
    a.sum * 0.1;
}.play
);