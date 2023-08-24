#!/bin/bash

sudo apt install pandoc imagemagick libimage-exiftool-perl

ELIMINAR METADATOS DE TODO!

COMPRIMIR IMAGENES CON ImageMagick!

pandoc --toc --toc-depth=3 -c src/style.css -B menu.html -A pie.html ../doc/index.md -o ../index.html --template plantilla.html


convert foto.png -sampling-factor 4:2:0 -strip -quality 80 -interlace Plane -gaussian-blur 0.05 -colorspace RGB foto.jpg
ESTE LAS DEJA ALGO BORROSAS, CREO QUE NO MERECE LA PENA

convert foto.png -strip -quality 80 foto.jpg
ESTE ALGO MEJOR, AUNQUE PESAN UN POCO MAS. MAS SENCILLO TAMBIEN


exiftool -overwrite_original -all= archivo.doc


pngquant imagen.png 

para las png

En los nombres de archivo, sustituir espacios por guiones para generar el .html ya listo para subir.


PARA SABER QUE ARCHIVOS MODIFICAR Y CUALES NO COMPARAMOS POR FECHAS? NO SE SI SE PUEDE CREO QUE NO, habra que pensar otra cosa.
Comparar por hash!


Mirar web de error 404

Accesible, Legible Estatica.etica Sostenible y Simple ALESS

#!/bin/bash
find textos/ -name "*.md*" | while read i; do pandoc -s "$i" -o "${i%.*}.html"; done
basename ${prueba%.*}


Comando mejorado para hacer todos los md a la vez:
for f in ../raw/*.md; do pandoc "$f" --toc --toc-depth=3 --template plantilla.html -c src/style.css -B menu.html -A pie.html -o "../$(basename "${f%.*}").html"; done
