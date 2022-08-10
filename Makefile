SOURCES=LT_Bracket LB_Bracket RT_Bracket RB_Bracket Strap
CLEANOBJS=$(patsubst %,%.d,$(SOURCES)) \
          $(patsubst %,%.stl,$(SOURCES)) \
          README.html

all: $(patsubst %,%.stl,$(SOURCES))

%.stl: %.scad
	openscad -o $@ $< -d $*.d

clean:
	rm -f $(CLEANOBJS)

-include LT_Bracket.d
-include LB_Bracket.d
-include RT_Bracket.d
-include RB_Bracket.d
-include IFBracket.d
