SHELL		= /bin/sh
KEPLERO		= keplero
KEPLERO_SOURCE	= $(KEPLERO).c
ECLISSI		= eclissi
ECLISSI_SOURCE	= $(ECLISSI).c
EXES		= $(KEPLERO) $(ECLISSI)
HEADER		= libreria.h
OBJECT_SOURCE	= libreria.c
OBJECT		= $(patsubst %.c,%.o,$(OBJECT_SOURCE))
CFLAGS		= -Wall -pedantic
LIBRARIES	= -lm -lgsl -lgslcblas
DISTCLEAN_FILES	= $(EXES) $(OBJECT) *.dat *~

.PHONY: all distclean check-syntax

all: $(EXES)

$(KEPLERO): $(KEPLERO_SOURCE) $(HEADER) $(OBJECT)
	gcc $(CFLAGS) $(LIBRARIES) -o $(KEPLERO) $(KEPLERO_SOURCE) $(OBJECT)

$(ECLISSI): $(ECLISSI_SOURCE) $(HEADER) $(OBJECT)
	gcc $(CFLAGS) $(LIBRARIES) -o $(ECLISSI) $(ECLISSI_SOURCE) $(OBJECT)

$(OBJECT): $(OBJECT_SOURCE) $(HEADER)
	gcc -c $(CFLAGS) $(LIBRARIES) $(OBJECT_SOURCE)

distclean:
	rm -f $(DISTCLEAN_FILES)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o /dev/null $(CFLAGS) -S $(CHK_SOURCES)
