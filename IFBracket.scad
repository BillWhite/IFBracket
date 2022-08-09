$fn = 120;
// This is the size of the box itself. 
DevW = 290;
DevD = 106;
DevH = 43;
Device = [DevW, DevD, DevH];

// This is the size of the outside of the cover. It's
// a bit larger than the device, and uniform in all
// three dimensions.
OPadW = 10;
OPadD = 10;
OPadH = 10;
OPad = [OPadW, OPadD, OPadH];

// This is the size of the space where the device sits.
// It's slightly larger than the device, and also
// uniform in all three dimensions.
IPadW = 5;
IPadD = 5;
IPadH = 5;
IPad = [IPadW, IPadD, IPadH];

// This is the height of the straps. It must be in the range
//     OPadH > StrapH > OPadH-IPadH
StrapW = 20;
StrapD = .7*DevD;
StrapH = (OPadH - IPadH)/2;
// The front has a lip. This is the depth of the lip.
ZPadW =  3;
ZPadD = 20;
ZPadH =  3;
ZPad = [ZPadW, ZPadD, ZPadH];

SPad = 5;

function delta(t) = [t, t, t];

module Strap(offset=[0, 0, 0],
             rotation=[0, 0, 0],
             ssize=[StrapW, StrapD, StrapH],
             tolerance=-0.5) {
    translate(offset) {
        rotate(rotation) {
            cube(ssize + delta(tolerance), center=true);
        }
    }
}

module Cover() {
    difference() {
        difference() { 
            // First, make the device outer shell.
            cube(size=Device + 2 * OPad, 
                 center = true);
            // Now, subtract the inner space.
            // This will leave the space in which
            // the device will rest. After this the
            // device space will still be covered up
            // by the outer shell.
            cube(size=Device + 2 * IPad, 
                 center=true);
            // Now, cut holes in the front and back.
            cube(size=Device + 2 * ZPad, 
                   center=true);
        }
        // Make holes for the straps. There is one for
        // each of the sides, top and bottom.
        Strap(offset=[0, 0, DevH/2+OPadH-IPadH+StrapH-1],
              tolerance=1.05);
        Strap(offset=[0, 0, -(DevH/2+OPadH-IPadH+StrapH-1)],
              tolerance=1.05);
        Strap(offset=[DevW/2+IPadW+StrapH-1, 0, 0],
              rotation=[0, 90, 0],
              tolerance=1.05);
        Strap(offset=[-(DevW/2+IPadW+StrapH-1), 0, 0],
              rotation=[0, 90, 0],
              tolerance=1.05);
    };
};

// A tab is a cube with a hole in it. It gets
// stuck to the outside of the bracket to hold
// the bracket to the bench.
TabW = 20;
TabD = 20;
TabH = 5;
Tab = [TabW, TabD, TabH];

module Gusset(radius = 0.1 * TabW,
              length = TabW,
              rotation=[0, 0, 0],
              offset=[0, 0, 0]) {
    translate(offset) {
        rotate(rotation) {
            difference() {
                cube([2 * radius, length, 2 * radius]);
                translate([radius, 1.5 * length, radius]) {
                    rotate([90, 0, 0]) {
                        cylinder(h = 2 * length, r = radius);
                    };
                };
                translate([radius, -0.1*length, -0.1]) {
                    cube([radius + 0.1, 
                          1.2*length, 
                          radius + 0.1]);
                }
                translate([-0.1, -0.1*length, radius]) {
                    cube([radius + 0.1, 
                          1.2*length, 
                          radius + 0.1]);
                }
                translate([radius, -0.1*length, radius]) {
                    cube([radius + 0.1, 
                          1.2*length, 
                          radius + 0.1]);
                }
            }
        }
    }
}
              
module Mount(rotation=[0, 0, 0], 
             holesize=.15, 
             offset=[0,0,0],
             gussetRadius = .3*TabW) {
    translate(offset) {
        rotate(rotation) {
            difference() {
                union() {
                    cube(Tab, center=true);
                    Gusset(rotation=[0, 90, 0],
                           radius=.5 * TabW,
                           length=TabW,
                           offset=[-TabW/2, -TabW/2, -TabH/2]);
                }
                cylinder(h=1.1*TabH, 
                     r=holesize * TabW, 
                     center=true);
            }
        }
    }
}

module Assembly() {
    Cover();
    // Add the Tabs.
    Mount(rotation = [0, 0, 0],
          offset = [DevW/2 + OPadW + TabW/2, 
                    DevD/2 - 10, 
                    DevH/2 + OPadH - TabH/2]);
    Mount(rotation = [0, 0, 0],
          offset = [DevW/2 + OPadW + TabW/2, 
                    DevD/2 - 40, 
                    DevH/2 + OPadH - TabH/2]);
    Mount(rotation = [0, 0, 180],
          offset = [-(DevW/2 + OPadW + TabW/2), 
                    DevD/2 - 10, 
                    DevH/2 + OPadH - TabH/2]);
    Mount(rotation = [0, 0, 180],
          offset = [-(DevW/2 + OPadW + TabW/2), 
                    DevD/2 - 40, 
                    DevH/2 + OPadH - TabH/2]);
};

module Bottom() {
    difference() {
        Assembly();
        translate([-(DevW + 2*OPadW), -(DevD + 2*OPadD), 0]) {
            cube(2*(Device + OPad));
        }
    }
}

module Top() {
        difference() {
            Assembly();
            translate([(DevW+OPadH), -(DevD + OPadD), 0]) {
                rotate([0, 180, 0]) {
                    cube(2*(Device + OPad));
                }
            }
    }
}

INFINITY = 1000;
module InfinityCube() {
    cube(2*INFINITY, center=true);
}

module LeftCube() {
    translate([-INFINITY, 0, 0]) {
        InfinityCube();
    }
}

module RightCube() {
    translate([INFINITY, 0, 0]) {
      InfinityCube();
    }
}

module TopCube() {
    translate([0, 0, INFINITY]) {
        InfinityCube();
    }
}

module BottomCube() {
    translate([0, 0, -INFINITY]) {
        InfinityCube();
    }
}

module TopRight() {
    difference() {
        Assembly();
        LeftCube();
        BottomCube();
    }
}

module TopLeft() {
    difference() {
        Assembly();
        RightCube();
        BottomCube();
    }
}

module BottomRight() {
    difference() {
        Assembly();
        LeftCube();
        TopCube();
    }
}

module BottomLeft() {
    difference() {
        Assembly();
        RightCube();
        TopCube();
    }
}

// Assembly();
translate([OPadW, 0, OPadH]) TopRight();
translate([-OPadW, 0, OPadH]) TopLeft();

translate([OPadW, 0, -OPadH]) BottomRight();
translate([-OPadW, 0, -OPadH]) BottomLeft();
