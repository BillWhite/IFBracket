include <constructive-compiled.scad>
include <ruler.scad>

$fn = $preview ? 30 : 120;
fnCornerValue = $preview ? 30 : 30;

KnobH = 15;
KnobD = 11.1;
ButtonDim = [6.9, 5.3, 3.6];

// This is the size of the device itself. 
DevW = 290;
DevD = 106;
DevH = 43;
Device = [DevW, DevD, DevH];

// This is the delta between the size of the outside
// of the cover and the size the device. It's
// a significantly larger than the device, and uniform in all
// three dimensions.
OPadW = 7;
OPadD = 7;
OPadH = 7;
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
StrapW = 0.8*DevH;
StrapD = 0.7*DevD;
StrapH = (OPadH - IPadH)/2;
// The front has a lip. This is the depth of the lip.
ZPadW =  1;
ZPadD = 20;
ZPadH =  1;
ZPad = [ZPadW, ZPadD, ZPadH];

BlockW = 4;
BlockD = 2;
BlockH = DevH;
Block  = [BlockW, BlockD, BlockH];
LBlockW = 43 - BlockW/2;
RBlockW = 44.6 - BlockW/2;
SPad = 5;

DCW=9;
DCD=0.5;
DCH=11;
DC=[DCW, DCD, DCH];
DCPosW=10;
DCPosH=27;
DCPosD=0;

USBW=12;
USBD=.5;
USBH=11.3;
USB=[USBW, USBD, USBH];
USBPosW=27;
USBPosD=0;
USBPosH=25;
USBPos=[USBPosW, USBPosD, USBPosH];

GainW  = 25;
Gain1L = 125;
Gain2L = Gain1L + GainW;
Gain3L = Gain1L + 2*GainW;
Gain4L = Gain1L + 3*GainW;

GainSelPos = [2.3, 11.6];
PadSelPos  = [15.1, 11.6];
GainKnobPos = [15, 28.8];

MixL = Gain4L + GainW;
PhonePos=[48.2, 12.3];
MixKnobPos=[19.6, 12.3];
MainOutKnobPos=[19.6, 31.3];
SMButtonPos=[2.8, 11.6];
MonABPos=[31, 11.6];
HPJackPos=[48.2, 31.3];
HPJackOD=13;
HPJackID=8;
HPJackOuterHoleDepth=3;
HPJackInnerHoleDepth=10;

InputW=28.5;
InputD=25;
Input1L=21;
Input2L=Input1L + 1*InputW;
Input3L=Input1L + 2*InputW;
Input4L=Input1L + 3*InputW;
XLRD=25;
XLRH=2;
function delta(t) = [t, t, t];

module xruler(xlength=DevW) {
    g() {
        ruler(length=xlength);
    }
}

