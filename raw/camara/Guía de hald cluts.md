To generate an identity 12-level 16-bit HaldCLUT image using ImageMagick, run this command in a console: 

convert hald:8 -depth 16 -colorspace sRGB hald12_16bit.tif


Transformar un .cube en haldclut para meterlo en rawtherapee. Parece que funciona bastante bien:

$ gmic -input_cube ~/Downloads/NightFromDay2.cube -r 64,64,64,3,3 -r 512,512,1,3,-1 -o haldclut.png

Esto funciona de puta madre para generar el HAld a partir del cube:

gmic -input_cube ARRI_LogC2Video_Classic709_davinci3d_33.cube -r 64,64,64,3,3 -r 512,512,1,3,-1 -o haldclut.png


Luego para devolverlo a CLUT (Funciona a la perfección):

gmic haldclut.png -output_cube customlut.cube