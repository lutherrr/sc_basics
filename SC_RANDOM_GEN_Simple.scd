

//Linear congruence random number generator NEW 01
(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(80,0.01,0.99);
var mult= 1.02;
var changechance = 0.0005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New01.wav");

data = Signal.fill(sr*10, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.02, rrand(1.05,1.2),exprand(1.001,1.1), rrand(1.1,3.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.0
});

file.writeData(data);
file.close;
)


//Linear congruence random number generator NEW 03 -> sr*100
(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(80,0.01,0.99);
var mult= 1.02;
var changechance = 0.0005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New03.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.02, rrand(1.05,1.3),exprand(1.001,13.1), rrand(1.1,23.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.0
});

file.writeData(data);
file.close;
)


//Linear congruence random number generator NEW 04 ->sr*1000
(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(80,0.01,0.99);
var mult= 1.02;
var changechance = 0.0005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New04.wav");

data = Signal.fill(sr*500, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.02, rrand(1.05,3.3),exprand(1.001,113.1), rrand(1.1,123.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.0
});

file.writeData(data);
file.close;
)

==================NEW5 C

//Linear congruence random number generator NEW 04 ->sr*100//var changechance =0.000005; !!
(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(800,0.01,0.99);
var mult= 1.02;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05C.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.02, rrand(1.05,3.3),exprand(1.001,13.1), rrand(1.1,23.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.0
});

file.writeData(data);
file.close;
)


==================NEW5  E

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,13000000000000.1)


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(3200,0.001,0.999);
var mult= 2.02;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05E.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.02, rrand(1.05,3.3),exprand(1.001,13000000000000.1), rrand(1.1,2.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.0
});

file.writeData(data);
file.close;
)


==================NEW5  FFF

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(3200,0.001,0.999);
var mult= 2.02;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05FFF.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.0032, rrand(1.05,3.39),exprand(1.001,40000000000003000000000000.1), rrand(1.01,2.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)


==================NEW5  GGG

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,90030000000000040000000003000000000030.133)
sr*300


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(3200,0.001,0.999);
var mult= 2.02;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05GGG.wav");

data = Signal.fill(sr*300, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.0032, rrand(1.05,3.39),exprand(1.001,90030000000000040000000003000000000030.133), rrand(1.01,3.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.193
});

file.writeData(data);
file.close;
)

==================NEW5  III

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)
last = (last*mult)%2.0;


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(3200,0.00031,0.777999);
var mult= 3.0288;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05III.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,333.39),exprand(1.001,3000000000000003000000000000.1), rrand(1.01,289.9)].choose;

	});

	last = (last*mult)%2.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)


==================NEW5  JJJ

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)
last = (last*mult)%2.0;


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(3200,0.00031,0.777999);
var mult= 3.0288;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05JJJ.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,333.39),exprand(1.001,3000000000000003000000000000.1), rrand(1.01,289.9)].choose;

	});

	last = (last*mult)%2.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)


==================NEW5  MMM

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)
last = (last*mult)%2.0;


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(99200,0.00031,0.777999);
var mult= 3.0288;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05MMM.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,333.39),exprand(1.001,3000000000000003000000000000.1), rrand(1.01,289.9)].choose;

	});

	last = (last*mult)%2.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)



==================NEW5  PPP

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)
last = (last*mult)%2.0;


(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(99200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.0005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05PPP.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});


{ Splay.ar(SinOsc.ar({ExpRand(50, 5e3)} ! 128)) }.play;



file.writeData(data);
file.close;
)

==================NEW5  SSS UWAGA!!!

//Linear congruence random number generator NEW 05  ->sr*100//var changechance =0.000005; !!var mult= 2.02; 3*next-1.0
exprand(1.001,40000000000003000000000000.1)
last = (last*mult)%2.0;

(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.00005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/lisek/Desktop/New05SSS.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});


{ Splay.ar(SinOsc.ar({ExpRand(50, 5e3)} ! 128)) }.play;



file.writeData(data);
file.close;
)


==================NEW5  TTT

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.000005;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05TTT.wav");

data = Signal.fill(sr*500, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)


==================NEW5  UUU

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.000093;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05UUU.wav");

data = Signal.fill(sr*500, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)


==================NEW5  WWW

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.00093;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05WWW.wav");

data = Signal.fill(sr*500, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)

==================NEW5  XXX

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.0073;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05XXX.wav");

data = Signal.fill(sr*300, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)

==================NEW5  YYY

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.063;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05YYY.wav");

data = Signal.fill(sr*200, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)



==================NEW5  ZZZ

//Linear congruence random number generator NEW 05
->
sr*500
var changechance = 0.000005;


(
var file,data;
var sr=44100;
var last = 0.23154617451;
var options = Array.rand(199200,0.00031,0.777999);
var mult= 1.0288;
var changechance = 0.93;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/New05ZZZ.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [237.0032, rrand(1.05,1.99),exprand(1.001, 72e3), rrand(1.01,1.09878)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)

========================newnew999
(
var file,data;
var sr=44100;
var last = 0.13154617451;
var options = Array.rand(6783200,0.00001,0.9999999);
var mult= 2.02;
var changechance = 0.00006;

file = SoundFile.new.headerFormat_("WAV").sampleFormat_("int16").numChannels_(1).sampleRate_(sr);

file.openWrite("/Users/Test/Desktop/NewNEW1005555.wav");

data = Signal.fill(sr*100, {|i|

	var next = last;

	if(changechance.coin,{

		mult= [1.0032, rrand(1.05,3.39), exprand(100.0, 8000.0), rrand(1.01,2.9)].choose;

	});

	last = (last*mult)%1.0;
	if(abs(last)<0.0000001) {last = options.choose};

	2*next-1.1
});

file.writeData(data);
file.close;
)



