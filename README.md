This is an OpenSCAD project to make a bracket to hang a Behringer
UMC404HD Audio Interface from a bench in my garage.

Note that you will need some OpenSCAD libraries.

1. RoundAnything (https://github.com/Irev-Dev/Round-Anything)
1. constructive (https://github.com/solidboredom/constructive)
1. ruler.scad (Included here, but copied from somebody else.)

You may also need Gnu Make, or something equivalent.

## To print this.
### Using Gnu Make.
To use Gnu make, just type:
´´´
$ make all
´´´
at the command prompt. (Don't type the dollar sign.)

### Without Gnu Make.
Run OpenScad with each of the four files:

- LT_Bracket.scad (for the Left Top quadrant)
- RT_Bracket.scad (for the Right Top quadrant)
- LB_Bracket.scad (for the Left Bottom quadrant)
- RB_Bracket.scad (for the Right Bottom quadrant)
- Strap.scad (for straps to hold the four together.)

For the first four you will get a preview and your part.
Just render and export the .stl file and all will be well.

### Printing and assembly.
You will have five stl files. Print the *_Bracket.stl files,
and print the strap.stl file four times. The top brackets
will have to be rotated so that the logical top is printed
on the bottom, to avoid supports.

To assemble them, glue each of four straps to two bracket pieces.
There are slots in the bracket pieces to hold the straps.

### Cleaning up.
Typing
```
$ make clean
```
deletes all the temporary files - the .stl and .d files.

## Something Else.
There is a mockup of the UMC404HD in mockup.scad. It just
has the front panel, not the back. It's not really that
useful, but I was learning OpenSCAD.

Good luck.

