# Notas sobre un servidor en Android
## Servidor WEB, TOR, GIT y SSH

Odio a los teléfonos en general y Android en particular. Hablar sobre la odisea que es desbloquear un bootloader, instalar una ROM con las particularidades de cada teléfono, y además de una documentación pésima. Recomiendo leer por XDA y no hacer mucho caso a la documentación del propio TPWR ni de LineageOS. Tenemos los comandos habituales de top, ifconfig, etc.

La intención o __el fin no es el anonimato__, para eso se requerirían tener muchas mas cosas en cuenta, sino el despliegue de los servicios a través de CGNAT, de una manera tan sencilla y cifrada y privacidad. Hablar sobre los metadatos, y como eliminarlos antes de subir nada. Además de otros mil factores a tener en cuenta.

# Primeros pasos: Termux

Primeros pasos tras la instalación, siempre desde f-droid. Actualizamos el sistema y habilitamos los permisos para acceder al almacenamiento del teléfono desde ~/storage.

	$ apt update 
	$ apt upgrade
	$ termux-setup-storage
	
	$ apt install man nano
 
Creo que nano ya viene, revisarlo.
 
También me gusta modificar termux.properties para añadir | y ~ al teclado en pantalla, y modificar las opciones de teclado físico desde la propia app:

	$ nano ~/.termux/termux.properties

~~~
### Two rows with more keys
 extra-keys = [['~','ESC','/','-','PGDN','UP','PGUP','HOME'], \
               ['|','TAB','CTRL','ALT','LEFT','DOWN','RIGHT','END']]
~~~

	$ termux-reload-settings


# Instalando los servicios

Aquí puedo enlazar al video de como funciona TOR. Decir que esto salta CGNAT y valdría para una conexión a través de 4G. Sería un servidor totalmente portátil.

	$ apt install termux-services
	$ apt install tor apache2 gitea sqlite

Aquí en lo de TOR creo que falta el momento de crear los directorios (no sé si el archivo de configuración los crea automáticamente, como las claves). También faltan unos pequeños añadidos de seguridad siguiendo la documentación de TOR:

También buscar información sobre, porque no se si hay que añadir esta linea que aparece en la documentación de termux o no. Aparentemente funciona bien sin ella:

~~~
## Enable TOR SOCKS proxy
SOCKSPort 127.0.0.1:9050
~~~

https://community.torproject.org/onion-services/setup/

  151  sv-enable httpd
  159  nano $PREFIX/etc/tor/torrc 

~~~
# Servidor WEB
HiddenServiceDir /data/data/com.termux/files/home/.tor/tor_ciberetica/
HiddenServicePort 80 127.0.0.1:8080

# Servidor SSH, no es necesario pudiendo usar tmate
HiddenServiceDir /data/data/com.termux/files/home/.tor/tor_ssh/
HiddenServicePort 22 127.0.0.1:8022
~~~

  160  sv-enable tor

Para saber la URL, en cada carpeta de cada servicio nos habrá generado automaticamente una dirección (Podremos personalizarla después) Para ver la dirección actual, simplemente:

  164  cat hostname 


### Servidor de GIT con Gitea

	$ gitea
	
Y accedemos con el navegador por el puerto 3000, por ejemplo: 192.168.1.24:3000




### Conectando por SSH: TMATE (Investigar más)

Puede sacarte de un apuro, pero no es perfecto. Pero el SSH a través de TOR va un poco lento, se hace difícil de utilizar.

https://wiki.termux.com/wiki/Bypassing_NAT

	$ apt install tmate


# Generando un dominio .onion vanidoso
 
 1725  git clone https://github.com/cathugger/mkp224o.git
 1726  cd mkp224o/
 1728  ./autogen.sh 
 1732  ./configure --enable-amd64-51-30k --enable-intfilter
(Esto es para mi arquitectura concreta del 2500k, más o menos, leer documentación)
 1733  make
 1735  ./mkp224o -sd ciberetica pablo

  ->  7 caracteres dura entre 30 y 60 minutos, a partir de ahí es inviable.
  ->  6 y 5 caracteres no tarda nada.



