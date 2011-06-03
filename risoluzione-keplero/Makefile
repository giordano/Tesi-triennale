SORGENTE = keplero.c
EXE	 = keplero

.PHONY: exe distclean check-syntax

exe: $(EXE)

$(EXE): $(SORGENTE)
	gcc -lm -Wall -pedantic -o $(EXE) $(SORGENTE)

distclean:
	rm -f $(EXE) *~

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o nul -Wall -pedantic -S ${CHK_SOURCES}
