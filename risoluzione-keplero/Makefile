SORGENTE	= keplero.c
EXE		= keplero
DISTCLEAN_FILES	= $(EXE) keplero*.dat *~

.PHONY: exe distclean check-syntax

exe: $(EXE)

$(EXE): $(SORGENTE)
	gcc -lm -Wall -pedantic -o $(EXE) $(SORGENTE)

distclean:
	rm -f $(DISTCLEAN_FILES)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o nul -Wall -pedantic -S $(CHK_SOURCES)
