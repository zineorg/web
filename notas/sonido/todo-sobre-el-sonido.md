# Todo sobre el sonido en el cine
## Herramientas libres ---y asequibles--- para crear sonido

### Micrófonos y cápsulas

Principalmente hay dos cápsulas:

1. Primo EM272/Z1 - Made in Japan (sustituye a EM172)
2. PUI AOM-5024L-HD-R - Made in USA

Son muy parecidas. La EM272 está mas extendida y es la utilizada en los micrófonos *USI* de *lom.audio* y en los *Clippy* de *Micboosters*. Más dificil de conseguir, solo he visto que la vendan suelta en micbooster a un precio mas elevado que la AOM. La AOM, según algunas pruebas parece incluso mejor[^*]. Más fácil de conseguir ya que está en *Banzaimusic* y mucho más barata. Tambíen disponible en Digikey y en Mouser.

Each Primo EM272 microphone capsule has just 14 dB of self noise. At this level, they compete with professional microphones costing upwards of $1000.

Phantom powered Clippy and Lom mics need much more energy to run well, so the Pip versions are still preferable in some situations. ¡De hecho, parece que todos los micros basados en EM272 y AOM pueden dar problemas de inestabilidad con la F3!

|  Manufacturer  |   Mic  | Noise | Price |
|:--------------:|:------:|:-----:|:-----:|
| Rode           | NT5    | 16 dB | $219  |
| Sanken         | CS-3e  | 15 dB | $1499 |
| Audio Technica | AT4021 | 14 dB | $349  |
| Primo          | EM272  | 14 dB | $20   |
| Sennheiser     | MKH416 | 13 dB | $999  |

Contacté directamente con Primo.de para presupuesto EM272Z1:

 
```
MOQ per delivery 10pcs

Price per piece € 9,00

Terms of delivery ex Works, we can offer shipment via postal package at € 14,95

Terms of payment in advance

We generally have some quantity of EM272Z1 in stock.

 

If you do not have a EU valid VAT number, we must charge 19% german VAT.
```

He calculado que con el cable Mogami y el conector Neutrik bueno, saldría cada stereo de EM272Z1 a 35€. En SeeSound.es venden BBI-L04 Bubblebee.

Luego está la Primo EM258, que es con la que están fabricados los LOM MikroUSI. La venden en Banzaimusic por 9€.

[^*]: https://drbadphil.com/earsight-microphones

###

Paravientos: https://www.zachpoff.com/resources/mic-windscreen-conparisons/

Los mejores los DIY y los MOVO



### Como emparejar capsulas para estéreo

REW: https://www.roomeqwizard.com/

Pair matching microphones:

https://gearspace.com/board/remote-possibilities-in-location-recording-amp-production/1146764-pair-matching-microphones.html

### Grabadoras

Basicamente con estas no hay pérdida, se pueden conseguir de segunda mano a precios razonables, sobretodo las olympus, que tienen menos fama que las Sony:

Sony (PCM-D50, PCM-D100) Los mejores.
Sony PCM-M10 (Casi igual que los LS-5,10,11 pero más compacto y más caro de conseguir)
Olympus (LS-5, LS-10, LS-11) Quizá los mejores relación calidad-precio.
Roland R-05 Buena relación calidad-precio.

Olympus LS-12/14 (Éstas ligeramente peores)[^*]
Sony PCM-A10

Olympus LS-100 (XLR) Algo peor, con XLR, pero mas voluminoso y mas caro.(Great preamps and fairly good onboard mics. Terrible software and proprietary batteries)
Tascam DR-100 MKIII (not MKI or MKII!) Mas voluminoso, buena calidad como la LS-100.

ZOOM F3 (Problemas de estabilidad en largas duraciones o con EM272, no tiene PIP, peor rendimiento con EM272 al no tener entrada minijack y PIP!!)

ZOOM H6 (problemas con humedad, problemas de acabados, mala calidad de la pintura, se vuelve pegajosa al poco tiempo)

Olympus seem to have forsaken the "professional" side of the audio market. Their newer recorders are marketed for dictation and band practice. Even the LS-100 has a poor PIP mic input.

A secondhand LS-11 or LS-5 would be better than LS-12 in my opinion. I've worked with both and the LS-11/5 (they are the same, LS-11 has more internal storage) have more options for custom recording settings. The pre-amps are also a bit better. The secondhand price is more or less the same. I have 3 recorders and used them a lot for al sorts of recordings.

I’ve now got the Sound Devices MixPre3 and still use my Olympus LS-11 in ‘ultra-light’ situations. 

32 bit vs 24 bit: bloated file size, extra energy needed at recording stage, more processing power needed in the studio, longer time to analyze and work with the files. The pros outweigh the cons in the situations you may need 32 bit, but I would have preferred to have the 24 bit option as well.


[^*]: http://www.avisoft.com/recorder-tests/

## ZOOM F3

As I understand it, think of the volume control on the F3 as the post gain faders. The signal isn’t going to clip unless the microphone physically overloads or the mic preamp overloads. So all you’re adjusting is how loud you hear it in the headphone output.

For a second, drop the idea of 32 bit recording. The way the F3 works, and most 32 bit recorders, is by having dual ADCs.
One ADC is for quiet sources (high gain) and one is for loud sources (low gain).
The math under the hood uses voltages received from the microphones based on their sensitivity to decide which ADC to use.
Normally it stays in the high gain ADC mode.
When loud signals occur, and to preemptively prevent clipping, it swaps to the low gain ADC.
This automatic switch is the magic. The two ADCs enable the higher headroom to not clip.
However, there is a huge drawback for anyone working in 88200 or higher sample rates. The noise signature of the low gain ADC injects 30dB of noise when it comes in. So, it is lower gain and not clipped internally in the gain structure, but the curve of the noise signature is exponentially worse the higher the frequencies go. Thus, if you do ever do SFX that you plan to pitch down you are screwed when the low gain ADC decides to occur on the math under the hood because it injected that noise in a way you can’t fix in post.
Now back to 32 bit. It’s only 32 bit to handle the dual ADCs. While it will never clip in the recorder, it can still clip at the capsule, and can easily inject the low gain ADC noise for any medium-loud sound sources which ruins takes if you plan to ever pitch things down like sound effects.

Switching from one ADC to the other (from low to high gain ADC, for example) does not affect recording levels. When it switches it maintains and compensates output gain of the signal mathematically as far as I can tell. Whatever you set for "gain" on the recording is irrelevant. 1X, 2X, 6X, 32X, 128X, etc. won't affect how the signal works or how a preamp operates. I tested that out and no matter what I set those values to it didn't change how the capsule clipped or how the ADC was triggered.

Between the two ADCs the whole dynamic range of a given microphone can be captured without needing to control the gain. Then recording that signal at 32 bits also makes gain control unnecessary. You just record and that's it. Later you set the desired gain in post and before bit reduction for exporting (e.g., to 24 bits), without having to worry about bringing up noise floor. On non 32 bit recorders and limited range ADC you have to control the gain before the ADC since the microphone's dynamic range is wider than what the converter can take, so you have to choose what section of the whole dynamic range you want to fit into the ADC.

the two ADCs overlap. So it’s like counting to 20 using two counters that both have 13 values; one counts from 0 to 12, the other counts from 8 to 20. The transition between them is therefore seamless.

Basically gain control in audio recorders exist to overcome technical limitations of the capturing system (e.g., analog tape dynamic range or analog to digital converters, noise floor due to limited bit depth, etc.). This new generation of recorders with 32 bit dual stage ADCs make gain control unnecessary

### ¿Dónde comprarlos?

https://www.veldshop.nl/en/clippy-em272-stereo-microphone.html

immsersivesoundscapes

micbooster

lom.audio

https://sonorousobjects.nyc/products/so-1-omni-microphone


https://whamelectronics.com/product/geophone-sismophone/
