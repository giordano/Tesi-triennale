SHELL		= /bin/sh
KEPLERO		= keplero
ECLISSI		= eclissi
EXES		= $(KEPLERO) $(ECLISSI)
HEADER		= libreria.h
OBJECT_SOURCE	= libreria.c
OBJECT		= $(patsubst %.c,%.o,$(OBJECT_SOURCE))
CFLAGS		= -Wall -pedantic
LIBRARIES	= -lm -lgsl -lgslcblas
DISTCLEAN_FILES	= $(EXES) $(OBJECT) *.dat *~

.PHONY: all distclean check-syntax

all: $(EXES)

$(KEPLERO): keplero.c $(HEADER) $(OBJECT)
	gcc $(CFLAGS) $(LIBRARIES) -o $(KEPLERO) keplero.c $(OBJECT)

$(ECLISSI): eclissi.c $(HEADER) $(OBJECT)
	gcc $(CFLAGS) $(LIBRARIES) -o $(ECLISSI) eclissi.c $(OBJECT)

$(OBJECT): $(OBJECT_SOURCE) $(HEADER)
	gcc -c $(CFLAGS) $(LIBRARIES) $(OBJECT_SOURCE)

distclean:
	rm -f $(DISTCLEAN_FILES)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	gcc -o /dev/null $(CFLAGS) -S $(CHK_SOURCES)
