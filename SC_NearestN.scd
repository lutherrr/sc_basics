NearestN

Find the nearest-neighbours in a set of points


This UGen takes an input point (such as a 2D or 3D location) and searches for the nearest few points in a dataset (by Euclidean distance).

(
s.waitForBoot{
(
x = 15.collect{|i| [1.0.rand, 1.0.rand, i]};
~treedata = NearestN.makeBufferData(KDTree(x, lastIsLabel: true));
~size = 800;
~treebuf = Buffer.sendCollection(s, ~treedata.flat, 5);
~foundbus = Bus.control(s, 3);
~mousebus = Bus.control(s, 2);
// lang-side cache of values which we'll poll from the server:
~mousepos = [0.5,0.5];
~nearests = [0,1,2];
);

(
w = Window.new("points of proximity", Rect(100, 100, ~size, ~size)).front;
w.drawHook = {
    var thesize, y;
    Pen.color = Color.white;
    Pen.fillRect(Rect(0, 0, ~size, ~size));
    x.do{|ax, index|
        y = 1 - ax[1]; // y is flipped for drawing
        Pen.color = Color.blue.alpha_(0.6);
        switch(~nearests.indexOf(index),
            0, { Pen.fillOval(Rect(ax[0] * ~size - 10, y * ~size - 10, 20, 20)) },
            1, { Pen.fillOval(Rect(ax[0] * ~size - 8, y * ~size - 8, 16, 16))   },
            2, { Pen.fillOval(Rect(ax[0] * ~size - 5, y * ~size - 5, 10, 10))   }
        );
        Pen.color = Color.black;
        Pen.fillOval(Rect(ax[0] * ~size - 2, y * ~size - 2, 4, 4));
        Pen.stringAtPoint(index.asString, ax[0] @ y * ~size, Font.default, Color.black);
    };
    Pen.color = Color.green.alpha_(0.5);
    Pen.fillOval(Rect(~mousepos[0] * ~size - 7, (1.0-~mousepos[1]) * ~size - 7, 14, 14));
};
);

s.sync;

(
~synth = {
    var mouse = Latch.kr([MouseX.kr, MouseY.kr], Impulse.kr(10));
    var found = NearestN.kr(~treebuf, mouse, num:3);
    //found.poll(1);
    var findices = found[2,5..]; // original array index, stored as 'labels'
    var fdistsq = found[1,4..]; // distances
    Out.kr(~foundbus, findices);
    Out.kr(~mousebus, mouse);
    Out.ar(0, SinOsc.ar((findices * 2 + 60).midicps, 0, fdistsq.explin(1e-6, 1, 0.5, 0)).sum);
}.play;

~updater = Task{loop{
    ~foundbus.getn(3, {|data| ~nearests = data.asInt});
    ~mousebus.getn(2, {|data| ~mousepos = data});
    s.sync;
    defer{w.refresh};
    0.1.wait;
}}.play
)

}

)