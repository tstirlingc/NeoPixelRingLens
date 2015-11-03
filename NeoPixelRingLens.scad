diameter = 50;
thickness = 0.5;
delta = 1.0;
high = thickness+delta;
centerEyeD=5;
centerEyeH = 7.0;
ring1StartD=10;
ring1W=1;
ring1H = 5;
ring2StartD=15;
ring2W=1;
ring2H = 3;
radialThick = 2.5;
radialThickH = 2;
numRadialThick = 3;
radialThickOffset = 30;
radialThin = 1.5;
radialThinH = 2;
numRadialThin = 3;
radialThinOffset = 90;

littleSQBackStartD = 28;
littleSQBackW = 10;
littleSQBackH = 5.0;
littleSQdX = 3;
littleSQdY = 2;
numLittleSQ = 40;

outerRing1D = 19;
outerRing1W = 0.5;
outerRing1H = 2.0;
outerRing2D = 21;
outerRing2W = 0.5;
outerRing2H = 3;
outerRing3D = 23;
outerRing3W = 0.5;
outerRing3H = 4;

radialDY = 0.5;
numRadials = 20;

numCutOuts = 10;

masterFN = 100;

module lens() {
    cylinder(d=diameter,h=thickness,$fn=masterFN);
    cylinder(d=centerEyeD,h=centerEyeH,$fn=masterFN); 
}

module centerRings() {
    toroid(ring1StartD,ring1StartD+2*ring1W,ring1H);
    toroid(ring2StartD,ring2StartD+2*ring2W,ring2H);
    radialBars();
}

module radialBars() {
    for (i=[0:numRadialThick]) {
        bigBar(radialThickOffset+i*360/numRadialThick);
    }
    for (i=[0:numRadialThin]) {
        smallBar(radialThinOffset+i*360/numRadialThin);
    }
}

module toroid(smallD,bigD,h) {
  difference() {
      cylinder(d=bigD,h=h,$fn=masterFN);
      cylinder(d=smallD,h=h,$fn=masterFN);
  }
}
module bigBar(angle) {
  //length = ring2StartD/2+ring2W;
  length = littleSQBackStartD/2;
  rotate(a=angle) {
  translate([0,-radialThick/2,0]) { cube([length,radialThick,radialThickH]); }
  }
}
module smallBar(angle) {
    //length = ring2StartD/2+ring2W;
    length = littleSQBackStartD/2;
    rotate(a=angle) {
        translate([0,-radialThin/2,0]) { cube([length,radialThin,radialThinH]); }
    }
}

module littleSquares() {
    space = (littleSQBackW-2*littleSQdX)/3;
    difference() {
    toroid(littleSQBackStartD,littleSQBackStartD+2*littleSQBackW,littleSQBackH);
    for (i=[0:numLittleSQ]) {
         rotate(i*360/numLittleSQ) {
             translate([littleSQBackStartD/2+space,-littleSQdY/2,0]) {
                cube([littleSQdX,littleSQdY,littleSQBackH]);
                }
             translate([littleSQBackStartD/2+2*space+littleSQdX,-littleSQdY/2,0]) {
                 cube([littleSQdX,littleSQdY,littleSQBackH]);
             }
            }
        }
    }
}

module littleRadials() {
    dX = outerRing3D/2+outerRing3W - outerRing1D/2;
    for (i=[0:numRadials]) {
        rotate(i*360/numRadials) {
            translate([outerRing1D/2,-radialDY/2,0]) {
                cube([dX,radialDY,high]);
                }
            }
    }
}

//module cutOuts() {
//  for (i=[0:numCutOuts]) {
//    rotate(i*360/numCutOuts) {
//        translate([24,-1,0]) {
//            cube([1,2,thickness]);
//        }
//    }
//  }
//}

module outerRings() {
toroid(outerRing1D,outerRing1D+2*outerRing1W,outerRing1H);
toroid(outerRing2D,outerRing2D+2*outerRing2W,outerRing2H);
toroid(outerRing3D,outerRing3D+2*outerRing3W,outerRing3H);
}

difference() {
lens();
//cutOuts();
}
centerRings();
littleSquares();
outerRings();
//littleRadials();