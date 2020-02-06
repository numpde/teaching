
default:
	libreoffice --headless --convert-to pdf *.odt
	pdftk call.pdf call.pdf cat output call2.pdf
	pdfjam --nup 1x2 call2.pdf --no-landscape -o call.pdf
	rm call2.pdf

