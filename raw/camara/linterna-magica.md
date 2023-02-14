# Primeros pasos MLVApp

Importante crear los **Archivos MAPP** para ahorrar tiempo, creando unos índices para no tener que estar recargando los MLV cada vez que se abre una sesión. En mi caso, al no grabar con audio, los archivos MAPP hacen que la carga sea aún incluso más rápida.

Los niveles RAW para los blancos y para los negros son puestos automáticamente por MLVApp en base a la cámara. Normalmente están correctos, pero a veces al corregir un cielo, o unas sombras, puede aparecer patrones púrpuras o verdes respectivamente. En estos casos, cuando modificando la luz en un cielo aparece este halo violeta, tendremos que ajustar el nivel RAW de los blancos para que el *Highlights reconstruction* funcione correctamente y lo vuelva de color blanco.


# Ideas

Hablar sobre como funciona la captura de video digital, el sensor y los modos. Esta información se encuentra mas fácilmente en el entorno de Magic Lantern.

Hablar sobre como funciona el procesamiento de video digital, la *crominancia* y el *luma*. Esta información se encuentra en el entorno de MLVApp y de la edición de video digital en general.
	
	Hablar aquí sobre el waveform, histogram, parade y vector scope.
	
	También sobre los *debayer algorithms*.
	
	Ruido: Temporal nois o Static Noise. Chroma noise (ruido de colores), luma noise (monocromo) y pattern noise (ruido con patrones de formas)

Tiene la capacidad de generar archivos RAW. Este tipo de archivos ofrece una gran ventaja de cara a la corrección de color, ya que contiene toda la información de luz y color que puede captar el sensor de la cámara. Para decodificarlos se realiza una conversión a otro tipo de archivo que es el .DNG que puede considerarse como un ‘negativo digital’. En esta conversión para conseguir el .DNG se dan dos procesos que son el demosaico y el debayer, generalmente estos procesos los realiza la cámara / software automáticamente, sin embargo en este caso el cliente / usuario puede intervenir sobre éstos.
	
¿Qué es exactamente MLVApp? Una especie de entorno gráfico para ffmpeg y más.

https://github.com/ilia3101/MLV-App/wiki

https://wiki.magiclantern.fm/glossary#photosite

https://www.elladodelmal.com/2015/06/magic-lantern-hackers-por-la.html

Magiae naturalis (nombre de un tipo de cámara oscura)

Canon: The EOS-M is made for women. No plan to make FF mirrorless (for now)
https://www.mirrorlessrumors.com/canon-the-eos-m-is-made-for-women-no-plan-to-make-ff-mirrorless-for-now/

Canon EOS M: A Camera For The Ladies (according to Canon), And To Be Released In September
https://www.canonwatch.com/canon-eos-m-a-camera-for-the-ladies-according-to-canon-and-to-be-released-in-september/

Tatoroses.eu tamaño de sensor

Alternativas: Axiom, Elphel, CinePi.

What's the problem with crop factors? Calculate them ... 1736 is the sensor width in 1080p and 5K frtp, 5208 in crop modes, additionally 1.6 because of APS-C sensor. So if you use 1080p or 5K settings with 1736 of width: 1736/1736*1.6 = 1.6x. If you use 2.8K: 5208/2800*1.6=3x.