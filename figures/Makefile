Q := @
SVG := ${shell ls | grep '\.svg$$'}
OUT := $(SVG:%.svg=%.pdf)

TOOLS=../tools
DATAOUTDIR=../data

FIGURES= \
.motivationFigures.gen

MOTIVATIONPDFS=freqProfileMotivation.pdf

all: $(OUT) $(FIGURES)

%.pdf: %.svg
	@echo "  INKSCAPE $@"
	$(Q)$(INKSCAPE) -C -z --file=$< --export-pdf=$@ --export-dpi=600

.motivationFigures.gen : $(TOOLS)/motivationFreqs.R $(DATAOUTDIR)/freqprofiles.csv
	Rscript $(TOOLS)/motivationFreqs.R $(DATAOUTDIR)/freqprofiles.csv .
	touch $@
	
$(DATAOUTDIR)/freqprofiles.csv : $(DATAOUTDIR)/motivation.tar.bz2
	tar xf $< -C $(DATAOUTDIR)
	touch $@
	
clean:
	rm -f $(OUT)
	rm -f $(FIGURES)
	rm -f $(MOTIVATIONPDFS)
	rm -f $(DATAOUTDIR)/freqprofiles.csv $(DATAOUTDIR)/freqprofiles_build.csv
