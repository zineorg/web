#!/bin/bash

for f in ../en/raw/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c ../src/style.css -B menu.en.html -A pie.en.html -o "../en/$(basename "${f%.*}").html"; done
