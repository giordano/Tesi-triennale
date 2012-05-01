##### Variabili
SHELL			= /bin/sh
CARTELLA		= Tesi-triennale
PRINCIPALE		= tesi
PRINCIPALE_TEX		= $(PRINCIPALE).tex
PRINCIPALE_PDF		= $(PRINCIPALE).pdf
BIBLIOGRAFIA		= bibliografia.bib
FRONTESPIZIO		= MaterialeInizialeFinale/frontespizio.tex
FRONTESPIZIO_FRN	= $(PRINCIPALE)-frn.tex
FRONTESPIZIO_PDF	= $(patsubst %.tex,%.pdf,$(FRONTESPIZIO_FRN))
CAPITOLI_TEX		= $(wildcard Capitoli/*.tex)
INIZIO_FINE_TEX		= $(wildcard MaterialeInizialeFinale/*.tex)
IMMAGINI_GNUPLOT	= $(wildcard Immagini/gnuplot/*.gnuplot)
IMMAGINI_GNUPLOT_PDF	= $(patsubst %.gnuplot,%.pdf,$(IMMAGINI_GNUPLOT))
IMMAGINI_GNUPLOT_EPS	= $(patsubst %.gnuplot,%.eps,$(IMMAGINI_GNUPLOT))
IMMAGINI_GNUPLOT_TEX	= $(patsubst %.gnuplot,%.tex,$(IMMAGINI_GNUPLOT))
IMMAGINI_TIKZ		= $(wildcard Immagini/tikz/*.tex)
PROG			= programmi
KEPLERO_DAT		= $(PROG)/newton.dat $(PROG)/bessel.dat
IMMAGINI_KEPLERO_PDF	= $(PROG)/newton-anomalia_eccentrica.pdf \
	$(PROG)/newton-raggio.pdf $(PROG)/newton-anomalia_vera.pdf \
	$(PROG)/bessel-anomalia_eccentrica.pdf $(PROG)/bessel-raggio.pdf \
	$(PROG)/bessel-anomalia_vera.pdf
IMMAGINI_KEPLERO_EPS	= $(patsubst %.pdf,%.eps,$(IMMAGINI_KEPLERO_PDF))
IMMAGINI_KEPLERO_TEX	= $(patsubst %.pdf,%.tex,$(IMMAGINI_KEPLERO_PDF))
ECLISSI_DAT		= $(PROG)/eclissi.dat
IMMAGINI_ECLISSI_PDF	= $(PROG)/distanza_proiettata.pdf \
	$(PROG)/flusso.pdf $(PROG)/piano_cielo.pdf
IMMAGINI_ECLISSI_EPS	= $(patsubst %.pdf,%.eps,$(IMMAGINI_ECLISSI_PDF))
IMMAGINI_ECLISSI_TEX	= $(patsubst %.pdf,%.tex,$(IMMAGINI_ECLISSI_PDF))
TUTTI_TEX		= $(PRINCIPALE_TEX) $(CAPITOLI_TEX) $(INIZIO_FINE_TEX) \
			  $(IMMAGINI_TIKZ)
TUTTI_FILE		= $(PROG)/keplero-immagini $(PROG)/keplero-dat \
	$(PROG)/keplero.c $(PROG)/eclissi-immagini $(ECLISSI_DAT) \
	$(PROG)/eclissi.c $(TUTTI_TEX) $(BIBLIOGRAFIA) $(IMMAGINI_GNUPLOT_PDF) \
	$(FRONTESPIZIO_PDF) mythesis.bbx mythesis.cbx
CLEAN_FILE		= *.aux *.bbl *.bcf *.blg *-blx.bib *.fdb_latexmk *.fls \
	*.lof *.log *.nav *.out *.pgf-plot.* *.run.xml *.snm *.toc *~ \
	$(wildcard Capitoli/*~) $(wildcard MaterialeInizialeFinale/*~) \
	$(IMMAGINI_GNUPLOT_EPS) $(wildcard Immagini/gnuplot/*~) \
	$(wildcard Immagini/tikz/*~) $(wildcard Immagini/presentazione/*~) \
	$(wildcard $(PROG)/*~) $(wildcard $(PROG)/*.eps)
DISTCLEAN_FILE		= *.pdf $(IMMAGINI_GNUPLOT_PDF) \
	$(IMMAGINI_GNUPLOT_TEX) $(FRONTESPIZIO_FRN) $(KEPLERO_DAT) \
	$(PROG)/keplero-immagini $(PROG)/keplero-dat $(IMMAGINI_KEPLERO_PDF) \
	$(IMMAGINI_KEPLERO_TEX) $(ECLISSI_DAT) $(PROG)/eclissi-immagini \
	$(IMMAGINI_ECLISSI_PDF) $(IMMAGINI_ECLISSI_TEX)

##### Regole

.PHONY: pdf clean distclean dist full-dist

pdf: $(PRINCIPALE_PDF)

$(PRINCIPALE_PDF): $(TUTTI_FILE)
	latexmk -pdf -recorder $(PRINCIPALE_TEX)

$(FRONTESPIZIO_PDF): $(FRONTESPIZIO)
	pdflatex $(PRINCIPALE_TEX)
	pdflatex $(FRONTESPIZIO_FRN)

### Inizio delle regole per compilare le immagini con gnuplot
# Per compilare tutte le immagini in formato EPS:
Immagini/gnuplot/%.eps: Immagini/gnuplot/%.gnuplot
	gnuplot $<

# Per generare i file .tex da includere nel documento.
# La regola è uguale a quella precedente:
Immagini/gnuplot/%.tex: Immagini/gnuplot/%.gnuplot
	gnuplot $<

Immagini/gnuplot/%.pdf: Immagini/gnuplot/%.eps
	epstopdf $<

## Immagini da produrre nella cartella programmi/
$(PROG)/keplero-immagini: $(PROG)/keplero-dat $(PROG)/keplero.gnuplot
	gnuplot $(PROG)/keplero.gnuplot
	for file in $(IMMAGINI_KEPLERO_EPS); do \
		epstopdf $${file}; \
	done
	rm -f $(IMMAGINI_KEPLERO_EPS)
	touch $(PROG)/keplero-immagini

$(PROG)/eclissi-immagini: $(PROG)/eclissi.dat $(PROG)/eclissi.gnuplot
	gnuplot $(PROG)/eclissi.gnuplot
	for file in $(IMMAGINI_ECLISSI_EPS); do \
		epstopdf $${file}; \
	done
	rm -f $(IMMAGINI_ECLISSI_EPS)
	touch $(PROG)/eclissi-immagini

$(PROG)/keplero-dat: $(PROG)/keplero $(PROG)/keplero.c
	cd $(PROG) && ./keplero
	touch $(PROG)/keplero-dat

$(PROG)/eclissi.dat: $(PROG)/eclissi $(PROG)/eclissi.c
	cd $(PROG) && ./eclissi

$(PROG)/keplero: $(PROG)/keplero.c $(PROG)/libreria.h $(PROG)/libreria.o
	@cd $(PROG) && make all

$(PROG)/eclissi: $(PROG)/eclissi.c $(PROG)/libreria.h $(PROG)/libreria.o
	@cd $(PROG) && make all

$(PROG)/libreria.o: $(PROG)/libreria.c $(PROG)/libreria.h
	@cd $(PROG) && make libreria.o
### Fine delle regole per le immagini

# Per fare pulizia dei file temporanei generati:
clean:
	rm -f $(CLEAN_FILE)

# Per cancellare tutti i file generati nella compilazione lasciando solo il
# sorgente:
distclean: clean
	rm -f $(DISTCLEAN_FILE)
	@cd $(PROG) && make distclean

# opzioni da passare a tar per escludere tutti i file legati alla presentazione
ESCLUDI_PRESENTAZIONE	= --exclude=$(CARTELLA)/presentazione.* --exclude=$(CARTELLA)/Immagini/presentazione

# Per creare un archivio compresso contenente il sorgente e il repository di git
# (e senza tutte le cose legate alla presentazione)
dist: $(TUTTI_TEX) $(BIBLIOGRAFIA) distclean
	git gc # comprimo il repository di git per ridurre al minimo la tarball
	cd .. && tar -cJvpsf $(CARTELLA).tar.xz --exclude=$(CARTELLA)/auto $(ESCLUDI_PRESENTAZIONE) $(CARTELLA)/

# Crea un archivio compresso (.tar.gz) contenente tutte le immagini e senza il
# repo git (e senza tutte le cose legate alla presentazione)
full-dist: $(PRINCIPALE_PDF) clean
	cd .. && tar -czvpsf $(CARTELLA).tar.gz --exclude=$(CARTELLA)/auto $(ESCLUDI_PRESENTAZIONE) --exclude-vcs $(CARTELLA)/
