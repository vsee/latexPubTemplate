export TEXINPUTS := $(TEXINPUTS):$(shell pwd)/lib
export INKSCAPE=/usr/bin/inkscape

FINALTARGET := paper
TARGET := main
BIBS := main.bib 
CHAPTERS := $(shell find chap/ | grep -E ".tex$$")
GENDIR := gen
PDFLATEXARGS := -halt-on-error -output-directory $(GENDIR)
PDFLATEX_CMD := pdflatex $(PDFLATEXARGS) $(TARGET) 2>/dev/null

.PHONY : figures clean figures-clean

$(FINALTARGET).pdf $(TARGET).log: $(GENDIR) $(TARGET).bbl $(TARGET).pdf
	@echo " *** Final Build *** "
	$(PDFLATEX_CMD) >/dev/null
	$(PDFLATEX_CMD) >/dev/null
	cp $(GENDIR)/$(TARGET).pdf $(FINALTARGET).pdf

$(TARGET).pdf $(TARGET).aux $(TARGET).toc: figures $(TARGET).tex $(CHAPTERS)
	@echo " *** Initial Build *** "
	$(PDFLATEX_CMD)

$(TARGET).blg $(TARGET).bbl: $(TARGET).aux $(BIBS)
	cp $(BIBS) $(GENDIR)
	cd $(GENDIR) && bibtex $(TARGET)

$(GENDIR):
	mkdir -p $(GENDIR)

figures:
	+make -C figures/

figures-clean:
	make -C figures clean
	
clean: figures-clean
	rm -f $(FINALTARGET).pdf
	rm -fr $(GENDIR)
