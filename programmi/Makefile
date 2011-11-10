SHELL		= /bin/sh
CC		= gcc
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
	$(CC) keplero.c $(OBJECT) $(CFLAGS) $(LIBRARIES) -o $(KEPLERO)

$(ECLISSI): eclissi.c $(HEADER) $(OBJECT)
	$(CC) eclissi.c $(OBJECT) $(CFLAGS) $(LIBRARIES) -o $(ECLISSI)

$(OBJECT): $(OBJECT_SOURCE) $(HEADER)
	$(CC) -c $(CFLAGS) $(LIBRARIES) $(OBJECT_SOURCE)

distclean:
	rm -f $(DISTCLEAN_FILES)

# per effettuare il controllo della sintassi in Emacs con Flymake
check-syntax:
	$(CC) -o /dev/null $(CFLAGS) -S $(CHK_SOURCES)
