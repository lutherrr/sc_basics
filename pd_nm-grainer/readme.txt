a granular synthesis patch by Nick Mariette (nmariette@myrealbox.com)

main patch name: nm-grainer.pd

uses: 
* an adaptation of not-quite-poly (nqpoly~.pd) from pix.test.at
* an adaptation of 29.sampler.loop.smooth.pd help patch for hamming window
* zexy lib, for mavg (however the patch will mostly function without zexy lib)

how-to-use?
mostly self explanatory - play with the coloured sliders and buttons for vastly variable effects....

known limitations:
1. suffers from the minimum 64 sample control signal block size - giving it a harsher sound when playing sequential grains due to the unreliable timing of grain playback.  i don't think this can be fixed without making an external.

2. seems to crash pd 0.35 test 23 when closing the patch... however this may be something to do with the draw-on-parent feature that i only just started using.



have fun playing with this, and if you have comments please email me:
nmariette@myrealbox.com