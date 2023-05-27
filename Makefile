PACKAGE  = nkuthesis
THESIS   = main
DIST_DIR = dist

.PHONY: help thesis package dist clean docker-compile

help:
	@echo "Targets:"
	@echo "	help (default)   - print this message"
	@echo "	thesis           - compile the example"
	@echo "	package          - compile the '${PACKAGE}' class and its document"
	@echo "	dist             - collect the files to release"
	@echo "	clean            - clean all generated files"
	@echo "	docker-compile   - compile the example with docker"

thesis: ${THESIS}.pdf

package: ${PACKAGE}.cls ${PACKAGE}.pdf

dist: example.zip ${THESIS}.pdf ${PACKAGE}.cls ${PACKAGE}.pdf 
	mkdir -p ${DIST_DIR}
	cp $^ ${DIST_DIR}
	mv ${DIST_DIR}/${THESIS}.pdf ${DIST_DIR}/example.pdf

${THESIS}.pdf: ${THESIS}.tex ${PACKAGE}.cls reference.bib figures
	xelatex ${THESIS}
	biber ${THESIS}
	xelatex ${THESIS}
	xelatex ${THESIS}

${PACKAGE}.pdf: ${PACKAGE}.dtx
	xelatex $<

${PACKAGE}.cls: ${PACKAGE}.pdf

example.zip: ${PACKAGE}.cls ${THESIS}.tex reference.bib figures/* README.md
	zip $@ $^

clean:
	rm -f *.aux *.blg *.bcf *.bbl *.cls *.hd *.log *.out *.toc *.pdf *.run.xml *.zip 
	rm -r ${DIST_DIR}

docker-compile:
	sudo docker run --rm -v "$(pwd)":/latex -w /latex texlive/texlive /bin/bash -c "make"

