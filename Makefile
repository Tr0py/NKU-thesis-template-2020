compile:
	xelatex main
	biber main
	xelatex main
	xelatex main
	rm *.aux *.out *.blg *.toc *.bbl *.bcf

docker-compile:
	# Use TeXlive 2022
	sudo docker run --rm -v "$(PWD)":/latex -w /latex texlive/texlive:TL2022-historic /bin/bash -c "make compile"

clean:
	rm main.pdf main.run.xml main.log

zip:
	zip nkthesis.zip *.tex *.bbx *.bib *.cbx *.sty fonts/* figures/*
