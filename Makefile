SOURCES=LT_Bracket LB_Bracket RT_Bracket RB_Bracket Strap

all: $(patsubst %,%.stl,$(SOURCES))

%.stl: %.scad
	openscad -o $@ $< -d $*.d

clean:
	rm -f *.d *.stl

-include LT_Bracket.d
-include LB_Bracket.d
-include RT_Bracket.d
-include RB_Bracket.d
-include IFBracket.d
