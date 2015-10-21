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
radialThick = 1.5;
numRadialThick = 3;
radialThickOffset = 30;
radialThin = 0.5;
numRadialThin = 3;
radialThinOffset = 90;

littleSQBackStartD = 30;
littleSQBackW = 8;
littleSQBackH = 5.0;
littleSQdX = 2.5;
littleSQdY = 1;
numLittleSQ = 50;

outerRing1D = 20;
outerRing1W = 0.5;
outerRing1H = 2.0;
outerRing2D = 23;
outerRing2W = 0.5;
outerRing2H = 2.5;
outerRing3D = 26;
outerRing3W = 0.5;
outerRing3H = 3.0;

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
  length = ring2StartD/2+ring2W;
  rotate(a=angle) {
  translate([0,-radialThick/2,0]) { cube([length,radialThick,high]); }
  }
}
module smallBar(angle) {
    length = ring2StartD/2+ring2W;
    rotate(a=angle) {
        translate([0,-radialThin/2,0]) { cube([length,radialThin,high]); }
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
littleRadials();