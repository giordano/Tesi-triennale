SHELL		= /bin/sh
SOURCE		= keplero.c
EXE		= keplero
HEADER		= libreria.h
OBJECT_SOURCE	= libreria.c
OBJECT		= $(patsubst %.c,%.o,$(OBJECT_SOURCE))
CFLAGS		= -Wall -pedantic
LIBRARIES	= -lm -lgsl -lgslcblas
DISTCLEAN_FILES	= $(EXE) $(OBJECT) *.dat *~

.PHONY: exe distclean check-syntax

exe: $(EXE)

$(EXE): $(SOURCE) $(HEADER) $(OBJECT)
	gcc $(CFLAGS) $(LIBRARIES) -o $(EXE) $(SOURCE) $(OBJECT)

$(OBJECT): $(OBJECT_SOURCE) $(HEADER)
	gcc -c $(CFLAGS) $(LIBRARIES) $(OBJECT_SOURCE)

distclean:
	rm -f $(DISTCLEAN_FILES)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o /dev/null $(CFLAGS) -S $(CHK_SOURCES)
