WaveTerrain : UGen : AbstractFunction : ObjectExtensionExtension
wave terrain synthesis
Specify a surface z(x,y) via a buffer and scan it from the x and y inputs.

//Examples


//create buffer. I want the equation z = 2*(((x/100)**2) + ((abs(sin(10*y))/50)**(1/3)))-1
//over a 100 by 50 area

//2d to 1d conversion follows index= y*rowlength+ x
(
var width= 100; //= num cols
var height=50; //=num rows, though indexing bottom to top; i.e., standard Cartesian co-ordinates

a=Array.fill(width*height,{arg i;
var xnow, ynow, x, y;

xnow= i%width;
ynow= (i-xnow).div(width);

x=xnow/width;
y=ynow/height;

2*(((x)**2) + ((abs(sin(10*y)))**(1/3)))-1

});


b=Buffer.sendCollection(s, a, 1);
)


//test scanning; you can't move fast enough... scan controls should also be audio rate!
{WaveTerrain.ar(b.bufnum,MouseX.kr(0.0,1.0), MouseY.kr(0.0,1.0),100,50)}.play


//LFNoise adds some drift to explore the landscape more
{WaveTerrain.ar(b.bufnum,SinOsc.ar(MouseX.kr(1,200,'exponential')).abs + LFNoise2.ar(2),SinOsc.ar(MouseY.kr(1,300,'exponential'),pi*0.5).abs,100,50)}.play





//change surface equation
(
var width= 100; //= num cols
var height=50; //=num rows, though indexing bottom to top; i.e., standard Cartesian co-ordinates

a=Array.fill(width*height,{arg i;
var xnow, ynow, x, y;

xnow= i%width;
ynow= (i-xnow).div(width);

x=xnow/width;
y=ynow/height;

(((cos(5*x+1.7))**3) - ((abs(sin(23*y)))**(1/3)))

});

b.sendCollection(a);
)





//change surface equation
(
var width= 100; //= num cols
var height=50; //=num rows, though indexing bottom to top; i.e., standard Cartesian co-ordinates

a=Array.fill(width*height,{arg i;
var xnow, ynow, x, y;

xnow= i%width;
ynow= (i-xnow).div(width);

x=xnow/width;
y=ynow/height;

(((1.3*(cos(rrand(1,2)*x+1.7))**2) - ((abs(sin(rrand(1.2,4.9)*y)))**(1/2)))).max(-1.0).min(1.0)

});

b.sendCollection(a);
)