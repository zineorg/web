---
title: Este es un artículo técnico que no se justifica.
lang: es-ES
date: 03/11/1992
author:
description: No sé como escribir aquí algo con mucho texto. Pero bueno, lo voy a intentar, no se como hacer saltos de linea ni nada, tendrá que escribir todo a cañón y como quede. aunquqe ya va varias lineas. Primero ponemos un breve texto que hace como de descripción del artículo. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque  ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
---

# Build the Coreboot ROM Image (ThinkPad X60-32bit)
## Prepare

See Coreboot Build How-To: <https://www.coreboot.org/Build_HOWTO>

Basically:

    $ git clone https://review.coreboot.org/coreboot
    $ cd coreboot
    $ git checkout 4.8.1
    $ git submodule update --init --checkout
    $ make crossgcc-i386

.sdfsdf

Configuration
-------------


    $ make menuconfig

Use default values, but additionally select/deselect as specified:

* Mainboard
    - Mainboard vendor (Lenovo)  --->
    - Mainboard model (ThinkPad X60 / X60s / X60t)  --->
    - ROM chip size (2048 KB (2 MB))  --->
    - (0x200000) Size of CBFS filesystem in ROM

* General Setup
    - [*] Use CMOS for configuration values

* Chipset
    - Include CPU microcode in CBFS (Do not include microcode updates)  --->

        NOTE: We prefer to avoid CPU Microcode Updates on machines that
        are known to work well enough without (see libreboot’s
        documentation). Otherwise select "Generate from tree".

* Devices
    - Graphics initialization (Use native graphics init)  --->
    - Display  --->
        + Framebuffer mode (Linear "high-resolution" framebuffer)  --->

* Console
    - [ ] Serial port console output

* Payload
    - Add a payload (An ELF executable payload)  --->
    - `"(payload.elf)"` Payload path and filename

        NOTE: File `payload.elf` should match your previously built
        executable GRUB payload file for platform i386-coreboot. See
        [GRUB How-To][].

    - Secondary Payloads --->
        + Select: Load coreinfo as a secondary payload
        + Select: Load nvramcui as a secondary payload

NOTE: The `.config` file may contain your paths which you probably
don't want to share with others.


Compile
-------


When you have exit the menuconfig tool, type:

    $ make

This will provide the `coreboot.rom` in folder `build/`.


Add Custom Files
----------------


### Add Zerocat’s GRUB Configuration File


Use coreboot’s `cbfstool` to add the custom configuration file as
`etc/zerocat.cfg`:

    $ build/cbfstool build/coreboot.rom \
        add -t raw -n etc/zerocat.cfg -f <your/path/to/grub@2.02_zerocat.cfg>
    $ build/cbfstool build/coreboot.rom \
        print

See [grub@2.02_zerocat.cfg][] for reference. Before using it, please
edit the file and adjust your keyboard layout which is currently
pre-set via `keymap`.


### Secondary Payloads


#### NVRAMCUI and Coreinfo


Secondary payloads `nvramcui` and `coreinfo` should be accompanied with
an informative message about occasional freezes, what can be achieved
with GRUB, but not with SeaBIOS. Therefor, let’s move them out of the
SeaBIOS `img/` search path:

    $ for i in coreinfo nvramcui; do \
        build/cbfstool build/coreboot.rom \
          extract -m x86 -n img/$i -f $i.extracted && \
        build/cbfstool build/coreboot.rom \
          remove -n img/$i && \
        build/cbfstool build/coreboot.rom \
          add-payload -c lzma -n $i -f $i.extracted && \
        rm $i.extracted; \
      done;

NOTE: When invoking `coreinfo` fromout the GRUB Boot Menu, please get
prepared for occasional freezes due to CPU exceptions and faults. See
[Coreinfo CPU Exceptions][].

NOTE: When invoking `nvramcui` fromout the GRUB Boot Menu, switch your
RF Kill Switch off! Active bluetooth devices might freeze the
application.

NOTE: Hmm..., and secondary payloads `nvramcui` and `coreinfo` seem to
freeze in case a fingerprint sensor is part of the system, so please
unplug that sensor.


#### Add SeaBIOS Payload


[Zerocat’s GRUB Configuration File][grub@2.02_zerocat.cfg] already
comes with a menu entry to chainload the SeaBIOS payload. Add files to
the `coreboot.rom` as required:

    $ build/cbfstool build/coreboot.rom \
        add -t raw -n config-seabios -f <your/path/to/seabios/.config>
    $ build/cbfstool build/coreboot.rom \
        add -t raw -n vgaroms/vgabios.bin -f <your/path/to/seabios/out/vgabios.bin>
    $ build/cbfstool build/coreboot.rom \
        add-payload -n seabios.elf -f <your/path/to/seabios/out/bios.bin.elf>
    $ build/cbfstool build/coreboot.rom \
        print

Please read section “Adding SeaBIOS Payload” of the [GRUB How-To][] for
more information.


### Add Background Images


[Zerocat’s GRUB Configuration File][grub@2.02_zerocat.cfg] has already
been prepared to make use of background images, if available. Just add
a first image like so:

    $ build/cbfstool build/coreboot.rom \
        add -t raw -n background.png -f <your/path/to/background.png>
    $ build/cbfstool build/coreboot.rom \
        print

You may add up to three more images named `background_1.png`,
`background_2.png` and `background_3.png`. This feature provides space
for additional information, such as a documented flash procedure for
example. Use hotkey 'i' in GRUB’s Boot Menu to cycle through the
images.


Tweak Parameters in `cmos.default`
----------------------------------


Tweak parameters `gfx_uma_size`, `wwan` and `bluetooth` in the ROM’s
`cmos.default` file:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w gfx_uma_size=64M
    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w wwan=Disable
    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w bluetooth=Disable

Inquire parameter’s possible values with option `-e`, i.e.:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -e gfx_uma_size

Our “standard” CMOS setup now looks like this:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -a
    boot_option = Fallback
    reboot_counter = 0x0
    debug_level = Spew
    nmi = Enable
    gfx_uma_size = 64M
    boot_devices = ''
    boot_default = 0x40
    cmos_defaults_loaded = Yes
    lpt = Enable
    hyper_threading = Enable
    first_battery = Primary
    bluetooth = Disable
    wwan = Disable
    wlan = Enable
    trackpoint = Enable
    sticky_fn = Disable
    power_management_beeps = Enable
    low_battery_beep = Enable
    volume = 0x3
    tft_brightness = 0xff

NOTE: You will be able to modify these settings with the NVRAMCUI
Payload upon boot time.


Done!
-----


Your ROM should now be ready to go!

In order to reset old & obsolete CMOS settings, please remind to unplug
the coin battery for some seconds after flashing.



[GRUB How-To]:                ../doc/grub-how-to.md
[Coreinfo CPU Exceptions]:    ../doc/coreinfo-cpu-exceptions.md
[grub@2.02_zerocat.cfg]:      ../templates/grub@2.02_zerocat.cfg


___

Copyright (C) 2017-2019  Kai Mertens <kmx@posteo.net>  
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover
Texts. A copy of the license is included in the section entitled:
[GNU Free Documentation License](../doc/GNU-FDL.md)
