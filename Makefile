FC ?= gfortran
STRIP ?= strip
FFLAGS ?= -g -O2
EMILI_FFLAGS = -ffixed-form -ffixed-line-length-132 -fdefault-integer-8 -std=legacy

EM4SRC = em4.f alphasort.f sort.f ionize4.f abundance4.f line_pick4.f openall4.f ri4.f multicheck4.f matchlist4.f redshift4.f vac2air.f idi4.f
EM4OBJ = $(EM4SRC:.f=.o)

EMREADSRC = emread.f emreadpick.f vac2air.f
EMREADOBJ = $(EMREADSRC:.f=.o)

all: em4 emread

em4: $(EM4OBJ)
	$(FC) $(FFLAGS) $(EMILI_FFLAGS) -o em4 $(EM4OBJ)
	$(STRIP) em4

emread: $(EMREADOBJ)
	$(FC) $(FFLAGS) $(EMILI_FFLAGS) -o emread $(EMREADOBJ)
	$(STRIP) emread

%.o: %.f
	$(FC) $(FFLAGS) $(EMILI_FFLAGS) -c $<

clean:
	rm -f $(EM4OBJ) $(EMREADOBJ) em4 emread

.PHONY: all clean
