##### Variabili
SHELL			= /bin/sh
CARTELLA		= Tesi-triennale
PRINCIPALE		= tesi
PRINCIPALE_TEX		= $(PRINCIPALE).tex
PRINCIPALE_PDF		= $(PRINCIPALE).pdf
BIBLIOGRAFIA		= bibliografia.bib
FRONTESPIZIO		= frontespizio.tex
FRONTESPIZIO_FRN	= $(PRINCIPALE)-frn.tex
FRONTESPIZIO_PDF	= $(patsubst %.tex,%.pdf,$(FRONTESPIZIO_FRN))
CAPITOLI_TEX		= $(wildcard Capitoli/*.tex)
IMMAGINI_GNUPLOT	= $(wildcard Immagini/gnuplot/*.gnuplot)
IMMAGINI_GNUPLOT_PDF	= $(patsubst %.gnuplot,%.pdf,$(IMMAGINI_GNUPLOT))
IMMAGINI_GNUPLOT_EPS	= $(patsubst %.gnuplot,%.eps,$(IMMAGINI_GNUPLOT))
IMMAGINI_GNUPLOT_TEX	= $(patsubst %.gnuplot,%.tex,$(IMMAGINI_GNUPLOT))
KEPLERO			= risoluzione-keplero
IMMAGINI_KEPLERO_PDF	= $(KEPLERO)/keplero-anomalia_eccentrica.pdf \
			  $(KEPLERO)/keplero-raggio.pdf \
			  $(KEPLERO)/keplero-anomalia_vera.pdf
IMMAGINI_KEPLERO_EPS	= $(patsubst %.pdf,%.eps,$(IMMAGINI_KEPLERO_PDF))
IMMAGINI_KEPLERO_TEX	= $(patsubst %.pdf,%.tex,$(IMMAGINI_KEPLERO_PDF))
TUTTI_TEX		= $(PRINCIPALE_TEX) $(CAPITOLI_TEX)
TUTTI_FILE		= $(KEPLERO)/immagini-keplero $(KEPLERO)/keplero.c\
			  $(TUTTI_TEX) $(BIBLIOGRAFIA) $(IMMAGINI_GNUPLOT_PDF)\
			  $(FRONTESPIZIO_PDF)
CLEAN_FILE		= *.aux *.bbl *.bcf *.blg *-blx.bib *.fdb_latexmk *.lof \
			  *.log *.out *.run.xml *.toc *~ \
			  $(wildcard Capitoli/*.aux) $(wildcard Capitoli/*~) \
			  $(IMMAGINI_GNUPLOT_EPS) $(wildcard Immagini/gnuplot/*~) \
			  $(wildcard $(KEPLERO)/*~) \
			  $(wildcard $(KEPLERO)/*.eps)
DISTCLEAN_FILE		= $(PRINCIPALE_PDF) $(IMMAGINI_GNUPLOT_PDF) \
			  $(IMMAGINI_GNUPLOT_TEX) $(FRONTESPIZIO_FRN) \
			  $(FRONTESPIZIO_PDF) $(KEPLERO)/keplero.dat \
			  $(KEPLERO)/immagini-keplero \
			  $(IMMAGINI_KEPLERO_PDF) $(IMMAGINI_KEPLERO_TEX)

##### Regole

.PHONY: pdf clean distclean dist

pdf: $(PRINCIPALE_PDF)

$(PRINCIPALE_PDF): $(TUTTI_FILE)
	latexmk -pdf $(PRINCIPALE_TEX)

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

## Immagini da produrre nella cartella risoluzione-keplero/
$(KEPLERO)/immagini-keplero: $(KEPLERO)/keplero.dat $(KEPLERO)/keplero.gnuplot
	gnuplot $(KEPLERO)/keplero.gnuplot
	for file in $(IMMAGINI_KEPLERO_EPS); do \
		epstopdf $${file}; \
	done
	touch $(KEPLERO)/immagini-keplero

$(KEPLERO)/keplero.dat: $(KEPLERO)/keplero
	cd $(KEPLERO) && ./keplero

$(KEPLERO)/keplero: $(KEPLERO)/keplero.c
	@cd $(KEPLERO) && make exe
### Fine delle regole per le immagini

# Per fare pulizia dei file temporanei generati:
clean:
	rm -f $(CLEAN_FILE)

# Per cancellare tutti i file generati nella compilazione lasciando solo il
# sorgente:
distclean: clean
	rm -f $(DISTCLEAN_FILE)
	@cd $(KEPLERO) && make distclean

# Per creare un archivio compresso contenente il sorgente e il repository di git:
dist: $(TUTTI_TEX) $(BIBLIOGRAFIA) distclean
	git gc # comprimo il repository di git per ridurre al minimo la tarball
	cd .. && tar -cJvpsf $(CARTELLA).tar.xz --exclude=$(CARTELLA)/auto  $(CARTELLA)/
