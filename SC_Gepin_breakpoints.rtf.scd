

Gepin
Gepin.ar(freq,freeze,array)
waveform constructed by interpolating breakpoints in periods


freq		frequency of the wave form
freeze	if  > 0 the waveform does not update, otherwise it updates
array 	[ 	amplitude1, distance1
			amplitude2, distance2
			amplitude3, distance3
			.... ]





// slow

(
{ Gepin.ar([400,517],0,
	[
		LFDNoise3.ar(4.4),	LFDNoise3.ar(1.4).range(100,1000),
		LFDNoise3.ar(1.4),	LFDNoise3.ar(0.4).range(100,1000),
		LFDNoise3.ar(0.75),	LFDNoise3.ar(2.1).range(100,1000),
		LFDNoise3.ar(5.4), LFDNoise3.ar(0.2).range(100,1000)
	] )}.play
)

// A!!! noisy
(
{ Gepin.ar(LFDNoise3.ar([0.2,0.4]).range(490,710),0,
	[
		LFDNoise3.ar(140.3),LFDNoise3.ar(79.542).range(100,1000),
		LFDNoise3.ar(60.3),LFDNoise3.ar(223.54).range(100,1000),
		LFDNoise3.ar(830.3),LFDNoise3.ar(23.5423).range(100,1000),
		LFDNoise3.ar(90.3),LFDNoise3.ar(553.54).range(100,1000),
		LFDNoise3.ar(140.3),LFDNoise3.ar(134.54).range(100,1000),
		LFDNoise3.ar(10.3),LFDNoise3.ar(654.84).range(100,1000),
		LFDNoise3.ar(30.3),LFDNoise3.ar(34.94).range(100,1000),
		LFDNoise3.ar(650.3),LFDNoise3.ar(4.45).range(100,1000),
		LFDNoise3.ar(10.3),LFDNoise3.ar(54.84).range(100,1000),
		LFDNoise3.ar(30.3),LFDNoise3.ar(34.94).range(100,1000),
		LFDNoise3.ar(50.3),LFDNoise3.ar(4.45).range(100,1000)
	] )}.play
)

// A!!! with freezing
(
{ Gepin.ar(LFDNoise3.ar([483.2,184.4]).range(190,1010),LFNoise0.ar(6).(-1.0,0.2),
	[
		LFDNoise3.ar(140.3),LFDNoise3.ar(79.542).range(100,1000),
		LFDNoise3.ar(60.3),LFDNoise3.ar(223.54).range(100,1000),
		LFDNoise3.ar(830.3),LFDNoise3.ar(23.5423).range(100,1000),
		LFDNoise3.ar(90.3),LFDNoise3.ar(553.54).range(100,1000),
		LFDNoise3.ar(140.3),LFDNoise3.ar(134.54).range(100,1000),
		LFDNoise3.ar(10.3),LFDNoise3.ar(654.84).range(100,1000),
		LFDNoise3.ar(30.3),LFDNoise3.ar(34.94).range(100,1000),
		LFDNoise3.ar(650.3),LFDNoise3.ar(4.45).range(100,1000)
	] )}.play
)

// A!!! frozen, step noise
(
{ Gepin.ar(LFNoise0.ar([1300.4,1300.6]).exprange(150,1010),LFNoise0.ar(LFDNoise3.ar([2.5,2.5]).exprange(2,600)).(-1.0,0.2),
	[
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000),
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000),
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000),
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000),
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000),
		LFNoise0.ar(130),LFNoise0.ar(40).range(100,1000)
	] )}.play
)

