include <config.scad>
include <mockup.scad>
include <ruler.scad>

module Assembly() {
    translate([-(DevW/2+OPadW), DevD/2+OPadD, DevH/2+OPadH]) sphere(2);
    difference() {
        OutSide();
        // Subtract the left from the right.
        // cube([200, DevD+20, DevH+20], center=true);
        // Subtract the left Back Hole.
        //translate([-DevW/2+43/2, -DevD/2-OPadD/2, 0])
        //cube([43, 10, DevH], center=true);
    }
    // mockup();
};

module OutSide() {
    union() {
        difference() {
            cube(Device + OPad, center=true);
            translate([0, -2, 0]) {
                cube(Device + IPad, center=true);
            }
            cube(Device + ZPad, center=true);
        }
    }
}

Assembly();
