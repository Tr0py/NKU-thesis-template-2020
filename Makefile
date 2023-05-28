PKG  = nkuthesis
THESIS   = main

${THESIS}.pdf: ${THESIS}.tex ${PKG}.cls reference.bib figures/*
	xelatex ${THESIS}
	biber ${THESIS}
	xelatex ${THESIS}
	xelatex ${THESIS}

${PKG}.cls: ${PKG}.dtx
	xelatex $<

${PKG}.pdf: ${PKG}.dtx
	xelatex $<

${PKG}-example.zip: ${PKG}.cls ${THESIS}.tex reference.bib figures/* README.md
	zip $@ $^

${PKG}-example.pdf: ${THESIS}.pdf
	cp $^ $@

.PHONY: thesis package dist clean distclean docker-compile help

thesis: ${THESIS}.pdf

package: ${PKG}.cls ${PKG}.pdf

dist: ${PKG}-example.zip ${PKG}-example.pdf ${PKG}.pdf ${PKG}.cls

clean:
	rm -f *.aux *.blg *.bcf *.bbl *.hd *.log *.out *.toc *.run.xml ${THESIS}.pdf

distclean: clean
	rm -f *.cls *.zip *.pdf

docker-compile:
	sudo docker run --rm -v "$(pwd)":/latex -w /latex texlive/texlive \
	                /bin/bash -c "make"
help:
	@echo "Targets:"
	@echo "	(default)        - compile the example"
	@echo "	help             - print this message"
	@echo "	package          - compile the '${PKG}' class"
	@echo "	dist             - package the thesis template"
	@echo "	clean            - clean all temporary files"
	@echo "	distclean        - clean all generated files"
	@echo "	docker-compile   - compile the example with docker"
