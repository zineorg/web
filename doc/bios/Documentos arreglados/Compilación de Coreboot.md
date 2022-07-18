# COMPILACIÓN DE COREBOOT

Compilar Coreboot uno mismo tiene ciertas ventajas y se puede compilar sin ningún blob privativo, exactamente igual que las versiones de libreboot (que no dejan de ser un coreboot precompilado y servido de esta manera). De esta manera seremos menos dependientes de un proyecto irregular y controvertido como es libreboot, con un mantenimiento bastante deficiente.

Lo primero es descargar todas los paquetes que vamos a necesitar para la compilación, y el propio Coreboot:

~~~
$ sudo apt install -y bison build-essential curl flex git gnat libncurses5-dev m4 zlib1g-dev python
~~~

~~~
git clone https://review.coreboot.org/coreboot.git
cd coreboot/
make crossgcc-i386 CPUS=$(nproc)
~~~



## Compilación en X200

El X200 es un poco diferente, ya que la propia BIOS contiene la MAC de la tarjeta de red. Es un proceso que haremos con las propias herramientas de libreboot.

Limpiamos por si hubiera una configuración anterior. Es una buena practica ejecutar este comando habitualmente, sobretodo al compilar para diferentes placas, ya que de lo contrario corremos le riesgo de obtener una mala compilación y tener un brick:

~~~
$ make distclean
$ make menuconfig
~~~

Dejamos las opciones por defecto, salvo estas:

* Mainboard
    - Mainboard vendor (Lenovo)  --->
    - Mainboard model (ThinkPad X200 / X200t)  --->
    - ROM chip size (8192 KB (8 MB))  --->

        NOTA: Selecciona el tamaño de tu chip EEPROM
        (4, 8, 16MB) and restale 0x3000 para obtener el tamaño correcto para la región BIOS, o como aquí se llama: “Size of CBFS
        filesystem in ROM”.

    - (0x7fd000) Size of CBFS filesystem in ROM

        NOTA: The original size of flash region 1 (BIOS) is 0x200000, but
        we are going to use a libreboot-modified descriptor which deletes
        region 2 (IME-Firmware) and increases region 1.

* General Setup
    - [*] Option Backend to use (Use CMOS for configuration values)

* Chipset
    - Include CPU microcode in CBFS (Generate from tree)  --->

        NOTE: Include CPU microcode in order to avoid occasional freezes
        which otherwise might occur with VMX and video usage. Note that we
        are not d'accord with any proprietary license status of that blob
        or its sources, but machines that occasionally hang without warning
        is not an option, either.

* Devices
    - Graphics initialization (libgfxinit - Use native graphics init)  --->
    - Display  --->
        + Framebuffer mode (Linear "high-resolution" framebuffer)  --->

* Payload ---> Elegimos Seabios y los payloads secundarios que nos interesen.

Descargamos y descomprimimos las herramientas de Libreboot que usaremos para editar la MAC de nuestra tarjeta ethernet. Puedes ahorrarte esto si ya tienes tu GbE correctamente configurada con tu MAC (Ver como actualizar BIOS sin cambiar la MAC):
~~~
wget https://www.mirrorservice.org/sites/libreboot.org/release/stable/20160907/libreboot_r20160907_util.tar.xz
~~~

~~~
tar -xf libreboot_r20160907_util.tar.xz
~~~

~~~
$ ./ich9gen --macaddress 00:1F:16:2E:51:2B

$ dd if=ich9fdgbe_8m.bin of=coreboot.rom bs=1 count=12k conv=notrunc
~~~

### Cambiando los valores CMOS

Esto también se puede cambiar después desde el payload de NVRAMCUI. Para modificarlo en nuestra imagen:
~~~
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w gfx_uma_size=256M
(importante para gráficos, juegos y video)
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w wwan=Disable
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w bluetooth=Disable
~~~

Para mostrar los diferentes valores disponibles para una opción concreta:

~~~
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -e gfx_uma_size
~~~

### ACTUALIZACIÓN DE UN X200 SIN TOCAR LA MAC MODIFICADA, SOLO LA REGION DE BIOS:

~~~
sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force --ifd -i bios -w libreboot.rom
~~~

The --ifd -i bios option, when you use a ROM for GM45 machine, will only flash the BIOS region. On those machines, the boot flash is split into IFD, GbE and BIOS region. The GbE region contains your MAC address. 

When flashing the Coreboot onto an
Already-Running-With-Coreboot-Machine, remember to reset the CMOS Checksum:

* pull the coin battery
* or use `sudo ./nvramtool -c 0x00`.


## COMPILAR COREBOOT SEABIOS PARA X60

~~~
$ make distclean
$ make menuconfig
~~~

Use default values, but additionally select/deselect as specified:

* Mainboard
- Mainboard vendor (Lenovo) --->
- Mainboard model (ThinkPad X60 / X60s / X60t) --->
- ROM chip size (2048 KB (2 MB)) --->
- (0x200000) Size of CBFS filesystem in ROM

* General Setup
Option backend to use (Use CMOS for configuration values)
- [*] Add a bootsplash image

* Chipset
- Include CPU microcode in CBFS (Do not include microcode updates) --->

NOTE: We prefer to avoid CPU Microcode Updates on machines that
are known to work well enough without (see libreboot’s
documentation). Otherwise select "Generate from tree".

* Devices
- Graphics initialization (Use native graphics init) --->
- Display --->
+ Framebuffer mode (Linear "high-resolution" framebuffer) --->
- [*] Add a bootsplash image

* Console
- [ ] Serial port console output



### Aquí hacemos unas mejoras, ajustes a la CMOS:

Tweak parameters `gfx_uma_size`, `wwan` and `bluetooth` in the ROM’s
`cmos.default` file:

~~~
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w gfx_uma_size=64M
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w wwan=Disable
$ build/util/nvramtool/nvramtool -C build/coreboot.rom -w bluetooth=Disable
~~~

### ACTUALIZAR COREBOOT EN X60:
~~~
$ sudo flashrom -p internal -w coreboot.rom
$ sudo ./nvramtool -c 0x00
~~~