# Generación de subtítulos automática con Whisper

## Extraer el audio de una película

Para extraer audio con ffmpeg:

```
ffmpeg -i video.mp4 audio.mp3
```

## Google Colab

Iniciamos sesión en nuestra cuenta y creamos un nuevo cuaderno.

Acordarse de hacer primero lo de seleccionar GPU.

Primer comando a ejecutar:
```
!pip install git+https://github.com/openai/whisper.git 
!pip install jiwer
```

Ahora subimos nuestro audio generado en el paso anterior. Arrastramos a la carpeta de archivos de Colab, y esperamos a que se muestre el circulo verde. Si se muestra un circulo rojo, probablemente tenemos problemas con nuestro navegador (lamentablemente da problemas con Firefox) recomiendo Chromium.

Transcribir cualquier idioma:
```
!whisper "audio.mp3" --language French --task translate --model medium --verbose False --output_dir traduccion
```

Transcribir y traducir del francés al inglés:
```
!whisper "audio.mp3" --language French --task translate --model medium --verbose False --output_dir traduccion
```

## Traducción manual al Español con DeepL

Generará 3 archivos, vtt, srt y txt. El txt nos puede ser util para traducirlo al Español con DeepL. Luego solo tendremos que ir añadiendo a mano la traducción a las marcas de tiempo. También se podría hacer directamente la traducción del srt, pero el resultado probablemente sea peor, al no entender el contexto de algunas frases.
