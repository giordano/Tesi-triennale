SHELL		= /bin/sh
SORGENTE	= newton.c
EXE		= newton
DISTCLEAN_FILE	= $(EXE) newton.dat

.PHONY: exe distclean check-syntax

exe: $(EXE)

$(EXE): $(SORGENTE)
	gcc -lm -Wall -pedantic -o $(EXE) $(SORGENTE)

distclean:
	rm -f $(DISTCLEAN_FILE)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o nul -Wall -pedantic -S $(CHK_SOURCES)
