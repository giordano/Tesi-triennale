##### Variabili
SHELL			= /bin/sh
CARTELLA		= Tesi-triennale
PRINCIPALE		= tesi
PRINCIPALE_TEX		= $(PRINCIPALE).tex
PRINCIPALE_PDF		= $(PRINCIPALE).pdf
BIBLIOGRAFIA		= bibliografia.bib
CAPITOLI_TEX		= $(wildcard Capitoli/*.tex)
TUTTI_TEX		= $(PRINCIPALE_TEX) $(CAPITOLI_TEX)
TUTTI_FILE		= $(TUTTI_TEX) $(BIBLIOGRAFIA)
CLEAN_FILE		= *.aux *.bbl *.bcf *.blg *-blx.bib *.fdb_latexmk *.log \
			  *.out *.run.xml *.toc *~ $(wildcard Capitoli/*.aux) \
			  $(wildcard Capitoli/*~)
DISTCLEAN_FILE		= $(PRINCIPALE_PDF)

##### Regole

.PHONY: pdf clean distclean dist

pdf: $(PRINCIPALE_PDF)

$(PRINCIPALE_PDF): $(TUTTI_TEX) $(BIBLIOGRAFIA)
	latexmk -pdf $(PRINCIPALE_TEX)

# Per fare pulizia dei file temporanei generati:
clean:
	rm -f $(CLEAN_FILE)

# Per cancellare tutti i file generati nella compilazione lasciando solo il
# sorgente:
distclean: clean
	rm -f $(DISTCLEAN_FILE)

# Per creare un archivio compresso contenente il sorgente e il repository di git:
dist: $(TUTTI_TEX) $(BIBLIOGRAFIA) distclean
	git gc # comprimo il repository di git per ridurre al minimo la tarball
	cd ..; tar -cJvpsf $(CARTELLA).tar.xz --exclude=$(CARTELLA)/auto  $(CARTELLA)/
