# Método de corrección de color en MLVApp

## Corregimos para obtener la imagen base

Lo primero es corregir las partes mas evidentes, para conseguir una base[^1] sobre la que después trabajar los colores. Aquí incluyo:

[^1]: Otras muchas opciones pueden ser también necesarias en otras circunstancias mas excepcionales, como puede ser *Dual ISO* o *Fix Bad Pixels*.

+ Corrección de los puntos de enfoque ---*pixel dots* en inglés--- de Magic Lantern.
+ Suavizado de crominancia o «*Chroma smooth*» a 3x3. Dependiendo del caso, puede funcionar en 5x5.
+ Corrección de lineas verticales, sobretodo visibles en el ruido estático, muy evidente en cielos y colores uniformes. Suelo ponerlo en *Normal*.
+ Si tenemos las altas luces quemadas ---que MLVApp nos mostrará en magenta--- deberemos ajustar el nivel de blanco RAW hasta poder volverlas completamente blancas gracias a la reconstrucción de altas luces (*highlights reconstruction*).
+ Usamos el Camera Matrix ---si fueramos a utilizar un LUT podría no ser recomendable, pero no es el caso--- y activamos el *Cyan Highlight Fix* que en mi experiencia corrige amarillos/mostaza que generan un artefacto de pixeles marrones.
+ La opción de *Chroma Separation* siempre lo activo[^2].
+ Aumentamos la nitidez. Con las lentes para 16mm ---que no destacan por su nitidez--- que yo utilizo me aguanta perfectamente un 80-100 de nitidez.
+ La opción *RBF Denoise Chroma* junto con su hermana *RBF Denoise Range* pueden ser útiles para eliminar cierto ruido, incluso de aberraciones cromáticas en lineas, pero generalmente no lo subo mucho ya que hacen perder saturación y perder los magentas casi por completo. Al ser en el canal de crominancia, la perdida de nitidez es totalmente despreciable.
+ La **mejor opción para eliminar** aberraciones cromáticas es *CA Desaturate Threshold*, la cual se puede llevar facilmente hasta el máximo sin afectar a la imagen, ni en color, ni en nitidez. Sobre 90% con radio de 5 obtengo unos resultados espectaculares combinándola con un poco ---sobre un 15-20%--- *RBF Denoise Chroma*.

[^2]: Me da buenos resultados, pero tengo que investigar más a fondo que hace exactamente.

## Ahora corregimos el color

Aquí explico como conseguir el color que me gusta, con ejemplos de fotogramas de películas.

# NOTAS

Persona que usaba x3 crop + x3 bitrate in h.264 CineStyle LUT ---parece interesante probar lo de las sombras cálidas y las luces frías---
i begin with bringing the contrast back(i apply technicolor cinestyle in camera). if shadows are still discernible, i will increase blacks, at times all the way to -150. with color–it depends of course, but what i ended up doing most of the time was white balancing towards the cool side and then making shadows warmer. if need be, i adjust the highlights manually to increase the blues there. the clearest example is the thumbnail. hope that helps!
