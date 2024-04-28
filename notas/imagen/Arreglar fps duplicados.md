# Comandos ffmpeg

## extraer todos los frames

ffmpeg -i original.mkv -vsync 0 "$filename%03d.png"

El crf se debería ajustar para cada pelicula independientemente. Ni es igual para todas, si es igual para todos los tipos de compresión. Por defecto medium, pero puede ser slow, fast, etc.

El audio es el mismo codec, no hay problema ya que se mantiene la misma duración. Se están eliminado 5 grames cada segundo, pero los segundos finales siguen siendo los mismos.

ffmpeg -i original.mkv -vf "decimate=cycle=5" -crf 17 -tune grain -c:a copy tunegrain.mkv

ffmpeg -i original.mkv -vf "decimate=cycle=5" -crf 17 -tune film -c:a copy tunefilm.mkv

ks es kostya, que es el mejor codec para prores. Profile 3 es HQ.

ffmpeg -i original.mkv -vf "decimate=cycle=5" -c:v prores_ks -profile:v 3 -c:a pcm_s24le prores-hq-422.mov

Con corte inicial de la charla:

ffmpeg -i original.mkv -ss 00:15:10 -vf "decimate=cycle=5" -crf 17 -tune film -c:a copy tunefilm.mkv

 _______              ______________
|       |            |              |
| input |  demuxer   | encoded data |   decoder
| file  | ---------> | packets      | -----+
|_______|            |______________|      |
                                           v
                                       _________
                                      |         |
                                      | decoded |
                                      | frames  |
                                      |_________|
                                           |
                                           v
                                       __________
                                      |          |
                                      | filtered |
                                      | frames   |
                                      |__________|
 ________             ______________       |
|        |           |              |      |
| output | <-------- | encoded data | <----+
| file   |   muxer   | packets      |   encoder
|________|           |______________|


Stream copy mode omits decoding and encoding. It is like a copy and paste:

 _______              ______________            ________
|       |            |              |          |        |
| input |  demuxer   | encoded data |  muxer   | output |
| file  | ---------> | packets      | -------> | file   |
|_______|            |______________|          |________|





Modern containers govern the time component of presentation of video (and audio) frames using timestamps, rather than framerate. So, instead of recording a video as 25 fps, and thus implying that each frame should be drawn 0.04 seconds apart, they store a timestamp for each frame e.g.

 Frame      pts_time
   0          0.00
   1          0.04
   2          0.08
   3          0.12
   ...

For the sake of precise resolution of these time values, a timebase is used i.e. a unit of time which represents one tick of a clock, as it were. So, a timebase of 1/75 represents 1/75th of a second. The Presentation TimeStamps are then denominated in terms of this timebase. Timescale is simply the reciprocal of the timebase. FFmpeg shows the timescale as the tbn value in the readout of a stream.

Timebase = 1/75; Timescale = 75
 Frame        pts           pts_time
   0          0          0 x 1/75 = 0.00
   1          3          3 x 1/75 = 0.04 
   2          6          6 x 1/75 = 0.08
   3          9          9 x 1/75 = 0.12
   ...

This method of regulating time allows variable frame-rate video.


