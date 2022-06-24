Gendy1
An implementation of the dynamic stochastic synthesis generator conceived by Iannis Xenakis and described in Formalized Music (1992, Stuyvesant, NY: Pendragon Press) chapter 9 (pp 246-254) and chapters 13 and 14 (pp 289-322).


//The distributions are hard-coded in C but there is an option to have new amplitude or time breakpoints sampled from a continuous controller input.

Technical notes
X's plan as described in chapter 13 allows the 12 segments in the period to be successively modified with each new period. Yet the period is allowed to vary as the sum of the segment durations, as figure 1 demonstrates. We can setup some memory of n (conventionally 12) points, or even simply vary successively a single point's ordinate and duration. There are thus various schemes available to us. In one, fix period T and only move the (ti, Ei) within the period. In another, have a memory of 12 segments but allow continuous modification of the inter point intervals and the amplitudes. In yet another, just have one point and random walk its amplitude and duration based on the probability distribution. In this implementation I allow the user to initialise a certain number of memory points which is up to them. To restrict the period to be unchanging, you must set rate variation to zero (dscale=0).

Choice of probability distribution for the next perturbation of the amplitude of a control point.

The distributions are (adapted from the GENDYN program in Formalized Music):

0:	LINEAR.
1:	CAUCHY.
2:	LOGIST.
3:	HYPERBCOS.
4:	ARCSINE.
5:	EXPON.
6:	SINUS.

//More: http://doc.sccode.org/Classes/Gendy1.html

WARNING: if you have lots of CPs and you have fast frequencies, the CPU cost goes up a lot because a new CP move happens every sample!

// defaults
{Pan2.ar(Gendy1.ar)}.play

// wandering bass/ powerline
{ Pan2.ar(Gendy1.ar(1, 1, 1.0, 1.0, 30, 100, 0.3, 0.05, 5)) }.play

// play me
{ Pan2.ar(RLPF.ar(Gendy1.ar(2, 3, minfreq:20, maxfreq:MouseX.kr(100,1000), durscale:0.0, initCPs:40), 500, 0.3, 0.2), 0.0)}.play

// scream! - careful with your ears for this one!
(
{
    var mx, my;

    mx = MouseX.kr(220, 440);
    my = MouseY.kr(0.0, 1.0);

    Pan2.ar(Gendy1.ar(2,3,1,1,minfreq:mx, maxfreq:8*mx, ampscale:my, durscale:my, initCPs:7, mul:0.3), 0.0)
}.play
)


// 1 CP = random noise effect
{ Pan2.ar(Gendy1.ar(initCPs:1)) }.play

// 2 CPs = suudenly an oscillator (though a fast modulating one here)
{ Pan2.ar(Gendy1.ar(initCPs:2)) }.play


//used as an LFO
(
{
    Pan2.ar(
        SinOsc.ar(
            Gendy1.kr(2, 4,
                SinOsc.kr(0.1, 0, 0.49, 0.51),
                SinOsc.kr(0.13, 0, 0.49, 0.51),
                3.4, 3.5,
                SinOsc.kr(0.17, 0, 0.49, 0.51),
                SinOsc.kr(0.19, 0, 0.49, 0.51),
                10, 10, 50, 350),
        0, 0.3),
    0.0)
}.play
)

// wasp
{ Pan2.ar(Gendy1.ar(0, 0, SinOsc.kr(0.1, 0, 0.1, 0.9), 1.0, 50, 1000, 1, 0.005, 12, 12, 0.2), 0.0)}.play


// modulate distributions
// change of pitch as distributions change the duration structure and spectrum
{ Pan2.ar(Gendy1.ar(MouseX.kr(0, 7), MouseY.kr(0, 7), mul:0.2), 0.0) }.play


// modulate num of CPs
{ Pan2.ar(Gendy1.ar(knum:MouseX.kr(1, 13), mul:0.2), 0.0) }.play

// Gendy into Gendy ... with cartoon side effects
    (
        {
            Pan2.ar(Gendy1.ar(
                maxfreq:Gendy1.kr(5, 4, 0.3, 0.7, 0.1, MouseY.kr(0.1, 10), 1.0, 1.0, 5, 5, 500, 600),
                knum:MouseX.kr(1, 13), mul:0.2), 0.0)
        }.play
    )

// use SINUS to track any oscillator and take CP positions from it, use adparam and ddparam as the inputs to sample
{ Pan2.ar(Gendy1.ar(6, 6, LFPulse.kr(100, 0, 0.4, 1.0), SinOsc.kr(30, 0, 0.5), mul:0.2), 0.0) }.play


//try out near the corners especially
    (
        {
            Pan2.ar(Gendy1.ar(6,6,LFPulse.kr(MouseX.kr(0,200), 0, 0.4, 1.0),
            SinOsc.kr(MouseY.kr(0,200), 0, 0.5),mul:0.2), 0.0)
        }.play
    )

// texture
    (
        {
            Mix.fill(10, {
                var freq = rrand(130,160.3);
                Pan2.ar(SinOsc.ar(Gendy1.ar(6.rand, 6.rand, SinOsc.kr(0.1, 0, 0.49, 0.51),
                    SinOsc.kr(0.13, 0, 0.49, 0.51), freq, freq, SinOsc.kr(0.17, 0, 0.49, 0.51),
                    SinOsc.kr(0.19, 0, 0.49, 0.51), 12, 12, 200, 400), 0, 0.1), 1.0.rand2)
            })
        }.play
    )

// wahhhhhhhh- try durscale 10.0 and 0.0 too
    (
        {
            Pan2.ar(
                CombN.ar(
                    Resonz.ar(
                        Gendy1.ar(2, 3, minfreq:1, maxfreq: MouseX.kr(10, 700), durscale:0.1, initCPs:10),
                        MouseY.kr(50, 1000), 0.1),
                    0.1, 0.1, 5, 0.6
                ),
                0.0)
        }.play
    )

// overkill
    (
        {
            var n = 10;
            Mix.fill(n, {
                var freq, numcps;

                freq = rrand(130, 160.3);
                numcps = rrand(2, 20);
                Pan2.ar(
                    Gendy1.ar(
                        6.rand, 6.rand, 1.0.rand, 1.0.rand, freq, freq, 1.0.rand, 1.0.rand, numcps,
                        SinOsc.kr(exprand(0.02, 0.2), 0, numcps/2, numcps/2), 0.5 / (n.sqrt)
                    ),
                    1.0.rand2
                )
            })
        }.play
    )

// another traffic moment
    (
        {
            var n;
            n =10;

            Resonz.ar(
                Mix.fill(n, {
                    var freq, numcps;

                    freq = rrand(50,560.3);
                    numcps = rrand(2,20);
                    Pan2.ar(Gendy1.ar(6.rand, 6.rand, 1.0.rand, 1.0.rand, freq, freq, 1.0.rand, 1.0.rand, numcps,
                        SinOsc.kr(exprand(0.02, 0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt)), 1.0.rand2)
                }),
                MouseX.kr(100,2000),
                MouseY.kr(0.01,1.0)
            )
        }.play
    )

    (
        {
            var n = 15;


            Resonz.ar(
                Mix.fill(n,{
                    var freq, numcps;

                    freq = rrand(330, 460.3);
                    numcps = rrand(2, 20);
                    Pan2.ar(
                        Gendy1.ar(
                            6.rand, 6.rand, 1.0.rand, 1.0.rand, freq,
                            MouseX.kr(freq, 2*freq), 1.0.rand, 1.0.rand, numcps,
                            SinOsc.kr(exprand(0.02, 0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt)
                        ),
                        1.0.rand2
                    )
                }),
                MouseX.kr(100, 2000), MouseY.kr(0.01, 1.0)
            )

        }.play;
    )


// ============++GENDY 2
//See Gendy1 help file for background. This variant of GENDYN is closer to that presented in Hoffmann, Peter. (2000) The New GENDYN Program. Computer Music Journal 24:2, pp 31-38.

//NOTE: Random walk is of the amplitude and time delta, not the amp and time directly. The amplitude step random walk uses a Lehmer style number generator whose parameters are accessible.

//LOUD! defaults like a rougher Gendy1
{Pan2.ar(Gendy2.ar)}.play

//advantages of messing with the random number generation- causes periodicities
{Pan2.ar(Gendy2.ar(a:MouseX.kr(0.0,1.0),c:MouseY.kr(0.0,1.0)))}.play

(
{Pan2.ar(
Normalizer.ar(
RLPF.ar(
RLPF.ar(Gendy2.ar(a:SinOsc.kr(0.4,0,0.05,0.05),c:SinOsc.kr(0.3,0,0.1,0.5)),
MouseX.kr(10,10000,'exponential'),0.05),
MouseY.kr(10,10000,'exponential'),0.05)
,0.9)
,Lag.kr(LFNoise0.kr(1),0.5))}.play
)



{Pan2.ar(Gendy2.ar(3,5,1.0,1.0,50,1000,MouseX.kr(0.05,1),MouseY.kr(0.05,1),15, 0.05,0.51,mul:0.5))}.play


//play me
{Pan2.ar(RLPF.ar(Gendy2.ar(1,3,minfreq:20,maxfreq:MouseX.kr(100,1000),durscale:0.0,initCPs:4),500,0.3, 0.2),0.0)}.play


//1 CP = random noise effect
{Pan2.ar(Gendy2.ar(initCPs:1))}.play

//2 CPs = suddenly an oscillator (though a fast modulating one here)
{Pan2.ar(Gendy2.ar(initCPs:2))}.play


//used as an LFO
(
{Pan2.ar(SinOsc.ar(Gendy2.kr(2,1,SinOsc.kr(0.1,0,0.49,0.51),SinOsc.kr(0.13,0,0.49,0.51),
3.4,3.5, SinOsc.kr(0.17,0,0.49,0.51), SinOsc.kr(0.19,0,0.49,0.51),10,10,mul:50, add:350), 0, 0.3), 0.0)}.play
)

//very angry wasp
{Pan2.ar(Gendy2.ar(0, 0, SinOsc.kr(0.1, 0, 0.1, 0.9),1.0, 50,1000, 1,0.005, 12, 12, 0.2,0.2,0.2), 0.0)}.play


//modulate distributions
//change of pitch as distributions change the duration structure and spectrum
{Pan2.ar(Gendy2.ar(MouseX.kr(0,7),MouseY.kr(0,7),mul:0.2), 0.0)}.play


//modulate num of CPs
{Pan2.ar(Gendy2.ar(knum:MouseX.kr(1,13),mul:0.2), 0.0)}.play


(//Gendy1 into Gendy2...with cartoon side effects
{Pan2.ar(Gendy2.ar(maxfreq:Gendy1.kr(5,4,0.3, 0.7, 0.1, MouseY.kr(0.1,10),
    1.0, 1.0, 5,5, 500, 600), knum:MouseX.kr(1,13),mul:0.2), 0.0)}.play
)

//use SINUS to track any oscillator and take CP positions from it, use adparam and ddparam as the inputs to sample
{Pan2.ar(Gendy2.ar(6,6,LFPulse.kr(100, 0, 0.4, 1.0), SinOsc.kr(30, 0, 0.5),mul:0.2), 0.0)}.play


(//try out near the corners especially
{Pan2.ar(Gendy2.ar(6,6,LFPulse.kr(MouseX.kr(0,200), 0, 0.4, 1.0),
    SinOsc.kr(MouseY.kr(0,200), 0, 0.5),mul:0.2), 0.0)}.play
)

//texture- the howling wind?
(
{
    Mix.fill(10,{
    var freq;

    freq= rrand(130,160.3);
    Pan2.ar(SinOsc.ar(Gendy2.ar(6.rand,6.rand,SinOsc.kr(0.1,0,0.49,0.51),SinOsc.kr(0.13,0,0.49,0.51),
        freq ,freq, SinOsc.kr(0.17,0,0.49,0.51), SinOsc.kr(0.19,0,0.49,0.51),
        12, 12, 0.4.rand, 0.4.rand, 200, 400), 0, 0.1), 1.0.rand2)
    });
}.play
)

//CAREFUL! mouse to far right causes explosion of sound
(
{Pan2.ar(
CombN.ar(
Resonz.ar(
Gendy2.ar(2,3,minfreq:1, maxfreq:MouseX.kr(10,700), initCPs:100),
MouseY.kr(50,1000), 0.1)
,0.1,0.1,5, 0.16
)
, 0.0)}.play
)

//storm
(
{
    var n;
    n=15;

    0.5*Mix.fill(n,{
    var freq, numcps;

    freq= rrand(130,160.3);
    numcps= rrand(2,20);
    Pan2.ar(Gendy2.ar(6.rand,6.rand,10.0.rand,10.0.rand,freq,freq*exprand(1.0,2.0),
        10.0.rand, 10.0.rand, numcps, SinOsc.kr(exprand(0.02,0.2), 0, numcps/2, numcps/2),
        10.0.rand, 10.0.rand, 0.5/(n.sqrt)), 1.0.rand2)
    });
}.play
)

//another traffic moment
(
{
    var n;
    n=10;

    Resonz.ar(
    Mix.fill(n,{
    var freq, numcps;

    freq= rrand(50,560.3);
    numcps= rrand(2,20);
    Pan2.ar(Gendy2.ar(6.rand,6.rand,1.0.rand,1.0.rand,freq ,freq,
        1.0.rand, 1.0.rand, numcps, SinOsc.kr(exprand(0.02,0.2), 0,
        numcps/2, numcps/2), 0.5/(n.sqrt)), 1.0.rand2)
    })
    ,MouseX.kr(100,2000), MouseY.kr(0.01,1.0), 0.3)
    ;
    }.play
)