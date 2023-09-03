#!/bin/bash

for f in ../*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../$(basename "${f%.*}").html"; done
for f in ../microfono1/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../microfono1/$(basename "${f%.*}").html"; done
for f in ../microfono2/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../microfono2/$(basename "${f%.*}").html"; done
for f in ../geofono/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../geofono/$(basename "${f%.*}").html"; done
for f in ../camara/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../camara/$(basename "${f%.*}").html"; done
rm ../README.html
