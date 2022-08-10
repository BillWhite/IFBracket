include <config.scad>
include <RoundAnything/polyround.scad>
include <ruler.scad>

$fn=120;
radiiPoints=[[-DevW/2, -DevH/2, 10],
             [ DevW/2, -DevH/2, 10],
             [ DevW/2,  DevH/2, 10],
             [-DevW/2,  DevH/2, 10]];


function fromLeftTopFront(x=0, y=0, z=0) = [DevW/2-x, DevD/2-y, DevH/2-z];

function fromRightTopFront(x = 0, y = 0, z = 0) = [DevW/2-x, -DevD/2+y, DevH/2-z ];

// The position is the upper, left, back corner
// of the button. It's a three dimensional
// vector with <X, Z>. The Y coordinate is always
// the face of the device.
module button(position = [0, 0, 0]) {
    g() {
        color("black")
            X(position[0] - ButtonDim[0]/2)
            Y(-DevD/2 - ButtonDim[2]/2)
            Z(DevH/2  - position[1]-ButtonDim[1]/2)
            box(ButtonDim[0],
                ButtonDim[1],
                ButtonDim[2]);
    }
}

module jack(location,
            od=HPJackOD,
            id=HPJackID,
            hod=2,
            hid=2) {
    color("silver")
        X(location[0] - od/2)
        Y(-DevD/2-hod/2)
        Z(DevH/2 - location[1])
        turnYZ(90)
        tube(h=hod, d=od, wall=1);
}
// The location is the (W, H) coordinates of the
// center of the knob.
module knob(location, h=KnobH, d=KnobD) {
    g() {
        color(black)
            X(location[0]-d/2)
            Y(-DevD/2 - h/2)
            Z(DevH/2 - location[1])
            turnYZ(90)
            tube(d=d, h=h, solid=true);
    }
}

module inputsection(h=XLRH, d=XLRD) {
    g() {
        %color("green")
            Y(-DevD/2-XLRH)
            turnYZ(90)
            tube(h=h, d=InputD, wall=1);
    }
}

module gainsection() {
    g() {
        button(GainSelPos);
        button(PadSelPos);
        knob(GainKnobPos);
    }
}

module mixsection() {
    g() {
        button(SMButtonPos);
        button(MonABPos);
        knob(MixKnobPos);
        knob(MainOutKnobPos);
        knob(PhonePos);
        jack(HPJackPos);
    }
}

module shell() {
    color("red")
        Y(DevD/2)
        turnYZ(90)
        linear_extrude(height=DevD) {
        polygon(polyRound(radiiPoints, 30));
    };
}

module mockup() {
    g() {
        shell();
        // FrontSide
        // Phone Output Knob
        X(-DevW/2 + MixL) mixsection();
        // 4 Input Controls
        X(-DevW/2 + Gain1L) gainsection();
        X(-DevW/2 + Gain2L) gainsection();
        X(-DevW/2 + Gain3L) gainsection();
        X(-DevW/2 + Gain4L) gainsection();
        // 4 Input Jacks.
        X(-DevW/2 + Input1L) inputsection();
        X(-DevW/2 + Input2L) inputsection();
        X(-DevW/2 + Input3L) inputsection();
        X(-DevW/2 + Input4L) inputsection();
    }
}

if ($preview) {
    assemble() {
        // button();
        // knob();
        // jack();
        mockup();
        // mixsection();
        // gainsection();
        // inputsection();
    }
}
