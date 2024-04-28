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

Here's a test I made last week, checking overhead. Could be useful as a baseline.

## The effects of different settings on Write Speeds / Recording times:


Because I didn't know what the parameters were ahead of time, I give the following figures in seconds of recording time instead of speed in MB/s.
This allowed me to set a fixed exposure level and only change Settings.
As the slightest change in exposure can make a difference of +- 30 seconds, this approach will make the test length more manageable, because there are too many variables to take into account to do several trials to check repeatability.

Card Tested: Samsung Evo Plus microSDXC UHS-I 512GB MB-MC512K (Fresh Low-Level Format)
Build Used:magiclantern-crop_mood.2024Feb11_Custom.EOSM202.zip
Resolution: 2880x1206 14 bit
More Hacks set to Always, unless specified.
Filming a test chart on LCD Screen, slightly off-focus to avoid moiré (Which would affect the Data Rate).

I set the exposure to be slightly under the Write Speed limit of the card,  so I could get a max record time of about 30 seconds (Baseline).

1- MF (Manual Focus), No Custom Buttons Assignments, Kill GD ON = 31-35 Seconds (Baseline)

2- AF (Auto Focus), No Custom Buttons Assignments, Kill GD ON = 31-45 Seconds

3- MF, No Custom Buttons Assignments, Kill GD Off = 20-21 Seconds

4- AF, No Custom Buttons Assignments, Kill GD Off = 20-21 Seconds

5-MF, Custom Buttons INFO x10 Zoom , SET False Colors, Kill GD On = 31-33 seconds

6-AF, Custom Buttons INFO x10 Zoom , SET False Colors, Kill GD On = 31-33 seconds

7-AF, Custom Buttons INFO x10 Zoom, SET False Colors, U/D ISO, Kill GD On = 6 seconds (31-33 seconds if More Hacks = Always)

8- MF, Custom Buttons INFO x10 Zoom, SET False Colors, U/D ISO, Kill GD On = 6 seconds (31-33 seconds if More Hacks = Always)

9-MF, Custom INFO Aperture Expo, SET False Colors, U/D ISO, Kill GD On= 6 Seconds (31-33 seconds if More Hacks = Always)

10-AF, Custom INFO Aperture Expo, SET False Colors, U/D ISO, Kill GD On= 6 Seconds (31-33 seconds if More Hacks = Always)

11-AF, Custom INFO x10 Zoom, SET False Colors, Kill GD On, Histogram On= 31 Seconds

12-AF, Custom INFO x10 Zoom, SET False Colors, Kill GD Off, Histogram On= 16-18 Seconds

13-AF, Custom INFO x10 Zoom, SET False Colors, Kill GD Off, Histogram On= 11-16  Seconds; Kill GD On=30-31 Seconds

14-AF, Custom INFO x10 Zoom, SET False Colors, Kill GD On,  =1:07 (I lowered the exposure to get a New, Longer Baseline)

14b-AF, Custom INFO x10 Zoom, SET False Colors, U/D ISO, Kill GD On,  = 6 Seconds

14c-AF, Custom INFO x10 Zoom, SET False Colors, Kill GD Off,  = 21-25 Seconds

Conclusion: For those who prefer using the higher resolution / high bit depth Presets, or just extend recording times, the following is recommended:
Kill Global Draw must be set to On;
and ISO / Aperture assignments to the custom buttons must be avoided while recording.

https://www.imaging-resource.com/PRODS/E7D/E7DIMATEST.HTM
