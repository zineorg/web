#!/bin/bash

for f in ../*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../$(basename "${f%.*}").html"; done
for f in ../microfono1/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../microfono1/$(basename "${f%.*}").html"; done
for f in ../microfono2/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../microfono2/$(basename "${f%.*}").html"; done
for f in ../geofono/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../geofono/$(basename "${f%.*}").html"; done
for f in ../camara/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../camara/$(basename "${f%.*}").html"; done
for f in ../notas/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c /src/style.css -B menu.html -A pie.html -o "../notas/$(basename "${f%.*}").html"; done
rm ../README.html
git add ../ -A
echo "Introduce el mensaje para el commit:"
read mensaje
git commit -m "$mensaje"
git push origin main
# Esperar a que el usuario presione Enter antes de salir
read -p "Presiona Enter para salir..."
