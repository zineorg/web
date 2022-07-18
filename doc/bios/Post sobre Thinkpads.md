# Breve introducción

https://www.xataka.com/ordenadores/viejos-thinkpad-buenos-que-hay-gente-que-destripa-para-ponerlos-al-dia-bestia

https://www.xataka.com/ordenadores/thinkpad-el-portatil-de-los-100-millones-de-unidades

# ¿Por qué portátiles viejos?

A la vez que se alcanzaba la madurez de los ordenadores portátiles, la época de oro para los ThinkPad y la implantación de IME. Desde aproximadamente 2008 que los ordenadores portátiles consiguieron ser una tecnología madura y eficiente, consiguiendo una más que suficiente potencia de computación. Son los únicos portátiles a los que se le puede eliminar completamente.

Reparabilidad. Grandísima comunidad. La privacidad se tenía en cuenta a la hora de diseñar los portátiles.

~~~
La reparabilidad de los portátiles ThinkPad se ha perdido en los modelos más recientes, menos modulares y desmontables, sin embargo para los antiguos modelos es posible encontrar y comprar cualquier pieza por internet. IBM empezó a publicar los manuales de mantenimiento y uso de sus máquinas, y Lenovo lo ha seguido haciendo, así que sustituir cualquier componente está al alcance de cualquiera que esté dispuesto a invertir algo de tiempo en leer los manuales y desatornillar unos cuantos tornillos. Facilidad de desmontaje con un simple destornillador, acceso al disco duro, cambio de teclado...

Más o menos cada tres años, las empresas renuevan su parque de ordenadores: sustituyen los que tienen por el último modelo de la misma familia. Muchos revendedores compran todo el lote de una empresa y lo ponen en venta en tiendas de segunda mano físicas y por internet. Los ThinkPad son tradicionalmente portátiles de empresa, así que es fácil encontrarlos en buen estado, ya que han sido usados durante unos pocos años, y a buen precio en el mercado de segunda mano, ya que hay mucha oferta.

Hablar sobre las baterías TRESSHOLDS DE CARGA (EC), baterías de Aliexpress y compatibles, piezas y componentes.

Hablar sobre los SSD.

Modelos como el X200 tienen la tarjeta de sonido a parte.

Posibilidad de eGPU, USB3...
~~~

Lo que provoca que las sucesivas mejoras en rendimiento de los equipos no sean tan evidentes por un software cada vez más pesado y menos eficiente, y unos sistemas operativos cada vez mas sobrecargados. Cumpliéndose así la Paradoja de Jevons

https://es.wikipedia.org/wiki/Paradoja_de_Jevons

# Motivaciones

De alguna manera, todas están relacionados entre si. Algunas son caracteristicas propias de los Thinkpad. Otras son de la BIOS libre:

- Privacidad (Libertad de prensa, encriptación desde el chip, botones desconexión Imagen exclusiva de Assange en la razón con sus thinkpads.)
- Ético (software libre, libertad, ser dueño de tu equipo)
- Ecológico (linkar con articulo de solar.lowtech, repuestos)
- Calidad (Escritores, buen teclado, menos distracciones, 4:3 o 16:10 poco peso, duraderos, resistentes, video maltrato)Especiales, innovadores (teclado mariposa, segunda pantalla, x301, teclado númerico)
- Fiabilidad (entornos complicados, automoción, foto ISS, actualizaciones constantes de coreboot)
- Educativo (ver y entender el funcionamiento, aprender y compartir)
- Rendimiento (Velocidad en servidores con coreboot+linuxboot de AMZ y facebook)
- Diseñadores (por el precio de una tableta sencilla tienes algo mejor)
- Modding (de todo tipo ver reddit)
- Preparacionismo (tontería)
- Criptomonedas (monedero confiable, software libre)


# ¿Qué modelo? ¿Cómo elegir?

Pegatina mercury pantallas LED. T400 no tiene pantalla led. Potencia/tamaño x200s. IME. Disipador T400 con gráfica. Chips WSON lo complican. X60 fáciles, pero limitados. eGPU. Pantalla táctil equipos mas grandes y recambios más difíciles. pantallas led, quad core, pantallas ips, mods de refrigeración

Lista de modelos hasta el T440p.


~~~
La diferencia fundamental entre ambas es el tamaño: los portátiles de la serie T son máquinas con pantallas de 14 o 15 pulgadas. Los de la serie X son máquinas compactas y ligeras con pantalla de 12,1 pulgadas. Si lo que se quiere es un ordenador para moverse, hay que mirar la serie X sin duda. Los ThinkPad serie X tienen mayor autonomía energética también
~~~


# IME

~~~
Since 2008, most of Intel’s chipsets have contained a tiny homunculus computer called the “Management Engine” (ME). The ME is a largely undocumented master controller for your CPU: it works with system firmware during boot and has direct access to system memory, the screen, keyboard, and network. All of the code inside the ME is secret, signed, and tightly controlled by Intel. 

The IME is totally opaque. No one knows for sure what it’s doing, only that it has access to everything. It can read your encrypted data from memory when you decrypt it -rendering encryption basically useless- and transmit that data back to someone via the internet

The Intel ME is an attractive target for hackers, since it has top level access to all devices and completely bypasses the operating system. The Electronic Frontier Foundation has voiced concern about Intel ME and some security researchers have voiced concern that it is a backdoor. 

The fact that the IME is made impossible to remove is a massive slap in the face to user freedom. Effectively, the machine that you bought with your own money isn’t yours. If you use a modern machine, you are in a sense simply licensing the use of the machine contingent on leaving the back door open.

If you want a machine that is totally free, then you have to use an older machine without the newer IME. Once you libreboot your thinkpad and install a FOSS OS, you are the master of the machine. Every line of code is accessible, and every decision is yours.

In December, Dell began showing certain laptops on its website that offered the "Systems Management" option "Intel vPro - ME Inoperable, Custom Order" for an additional fee. Dell has not announced or publicly explained the methods used. In response to press requests, Dell stated that those systems had been offered for quite a while, but not for the general public, and had found their way to the website only inadvertently.[91] The laptops are available only by custom order and only to military, government and intelligence agencies.[92] They are specifically designed for covert operations, such as providing a very robust case and a "stealth" operating mode kill switch that disables display, LED lights, speaker, fan and any wireless technology.[93]

~~~


# Cambia el CHIP: Flasheando la BIOS

~~~
Una vez comprado, no le debemos nada a nadie. Ni a Intel, ni a Lenovo. El equipo es nuestro. Esto parece algo que no entienden o no quieren entender.
~~~

Descripción del proceso sin entrar en detalles. Link a hilo de reddit de flasheo. Documentación coreboot, libreboot, etc.

# Coreboot y sus derivados

Imagenes precompiladas, algunas en github, skulls, heads, libreboot etc.


# Encriptación

~~~
On any normal computer, when you hit the power button to turn on your machine a signal is sent to your BIOS chip. The code written to that chip is your BIOS. The BIOS then -absent user intervention- starts looking for a bootable device. The BIOS will eventually find a bootloader on one of the devices it checks (generally your ssd/hdd) and execute it. If you have a classic BIOS, then the bootloader is in the master boot record of the disk, if it is an EFI disk, then your firmware will be checking a special EFI partition. Either way: the bootloader then loads your operating system from the disk.

For almost all linux systems, the bootloader in question is GRUB2. GRUB’s role is to find an initial ramdisk (generall initramfs in a /boot partition) and a kernel (generally vmlinuz-x-x-x) on the disk and load them into memory. You can think of it as GRUB passing ownership of your hardware to your operating system. When GRUB sees that you have an encrypted disk, it has the tools to prompt you for a password, decrypt the disk, and then load the operating system from the (now readable) disk. GRUB therefore has a lot of power.

If you already have an encrypted disk, then you know that your data is safe at rest. When you shut off your computer, all of the data on your disk is unreadable by an attacker. But what would a sophisticated attacker do if they happened upon your fully encrypted disk? Your encrypted data is unreadable, but GRUB isn’t! Since your firmware needs to execute a bootloader, that bootloader must be unencrypted. An attacker could therefore edit the plainly viewable GRUB code to insert a rootkit. The rootkit could potentially store your key, transmit it to the attacker, or outright transmit your unencrypted data back to the attacker.

Libreboot/Coreboot defeat the rootkit vulnerability of GRUB on your disk. Since you flash your own firmware, you can choose to have GRUB run as part of the firmware on your BIOS chip. In fact, GRUB2 is the default payload for libreboot (for now). Since there is no need for a bootloader on your disk, an attacker can’t do anything with your encrypted disk. When you input your key now, no program on your disk has access to it until GRUB loads your OS. An attacker can’t make any changes to the OS on your disk because everything is fully encrypted.
~~~


# PASOS PREVIOS

Update the EC firmware
Make sure your RAM (memory) is compatible
Install a compatible wirless card

# Después de la instalación

Valores cmos
RESET BATERIA AMARILLA
powertop --calibrate (elimina ruiditos procesador, pantalla, etc)


# Ideas

Dell maleta que se podía comprar para entornos delicados americanos sin el IME.

Servidores de google y facebook con linuxboot. ¿Por qué ellos quieren software libre para sus sistemas, pero promueven lo contrario para los demás?

Noticias de Intel comprando sus propios procesadores «antiguos».

A raíz de la pandemia, las marcas se están dando cuenta de los beneficios que genera el mercado de segunda mano, por lo que el panorama de precios y disponibilidad puede cambiar.

FSF RYF

Hablar sobre otros firmwares del equipo donde puede flaquear esto (creo que había algo en la web de libreboot)

Alternativas: Comunidad 51nb, Purism, System76.

# Enlaces

https://solar.lowtechmagazine.com/2020/12/how-and-why-i-stopped-buying-new-laptops.html

https://lukesmith.xyz/articles/only-use-old-computers

https://thonkpeasant.xyz/index.html

libreboot.org

coreboot.org

https://www.thinkwiki.org/wiki/Category:Models

https://github.com/corna/me_cleaner

https://www.xyte.ch/

Reddit de: coreboot, libreboot, thinkpad&setups, 

Link videos: historia de X301

https://www.reddit.com/r/libreboot/comments/7dajn6/x200_libreboot_tutorial_for_raspberry_pi_with/

https://www.eff.org/deeplinks/2017/05/intels-management-engine-security-hazard-and-users-need-way-disable-it

https://en.wikipedia.org/wiki/Intel_Management_Engine

https://stackoverflow.com/questions/53681838/how-does-linuxboot-differs-from-coreboot-in-the-firmware-phase

Anatomy of the UEFI Boot Sequence on the Intel Galileo
https://blog.hansenpartnership.com/anatomy-of-the-uefi-boot-sequence-on-the-intel-galileo/

https://doc.coreboot.org/getting_started/architecture.html
