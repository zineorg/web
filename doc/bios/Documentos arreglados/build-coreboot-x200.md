Build the Coreboot ROM Image (ThinkPad X200)
============================================


TODO: This file lists essential steps for reference only and should be
thoroughly reviewed. Please use the toolchain scripts instead. See
`../doc/toolchain.md`.


Prepare
-------


See Coreboot Build How-To: <https://www.coreboot.org/Build_HOWTO>

Basically:

    $ git clone https://review.coreboot.org/coreboot
    $ cd coreboot
    $ git checkout 4.8.1
    $ git submodule update --init --checkout
    $ make crossgcc-i386


Extract Binary Blobs from Original Firmware Dump
------------------------------------------------


NOTE: These blobs are not needed, they are extracted for reference only!

Place your original `lenovo.bin` firmware dump into folder
`util/ifdtool/`, then use `ifdtool` to extract flashregions, i.e.:

    $ cd util/ifdtool
    $ make
    $ ./ifdtool -x lenovo.bin
    File lenovo.bin is 8388608 bytes
      Flash Region 0 (Flash Descriptor): 00000000 - 00000fff
      Flash Region 1 (BIOS): 00600000 - 007fffff
      Flash Region 2 (Intel ME): 00001000 - 005f5fff
      Flash Region 3 (GbE): 005f6000 - 005f7fff
      Flash Region 4 (Platform Data): 005f8000 - 005fffff
    $ ls *.bin
    flashregion_0_flashdescriptor.bin  flashregion_1_bios.bin  flashregion_2_intel_me.bin  flashregion_3_gbe.bin  flashregion_4_platform_data.bin  lenovo.bin

* The content of flash region 0 will not be used, instead a
  libreboot-modified descriptor build from scratch comes into action.

* Flash region 1 will be replaced by coreboot firmware. From the output
  above, the original size of that region is obvious: 0x200000.

    This region will be increased by the modified descriptor, and it will
    be located right behind the re-located region 3.

* Flash region 2 will be deleted.

* The content of region 3 will not be used.

    Instead, GbE configuration data will be build from scratch, and
    region 3 will be located right behind region 0.

* Flash region 4 will be deleted.


Configuration
-------------


    $ make menuconfig

Use default values, but additionally select/deselect as specified:

* Mainboard
    - Mainboard vendor (Lenovo)  --->
    - Mainboard model (ThinkPad X200 / X200t)  --->
    - ROM chip size (8192 KB (8 MB))  --->

        NOTE: Select the appropriate ROM chip size of your X200 model
        (4, 8, 16MB) and substract 0x3000 to get the correct size of
        region BIOS, or like it is called here: “Size of CBFS
        filesystem in ROM”.

    - (0x7fd000) Size of CBFS filesystem in ROM

        NOTE: The original size of flash region 1 (BIOS) is 0x200000, but
        we are going to use a libreboot-modified descriptor which deletes
        region 2 (IME-Firmware) and increases region 1.

* General Setup
    - [*] Use CMOS for configuration values

* Chipset
    - Include CPU microcode in CBFS (Generate from tree)  --->

        NOTE: Include CPU microcode in order to avoid occasional freezes
        which otherwise might occur with VMX and video usage. Note that we
        are not d'accord with any proprietary license status of that blob
        or its sources, but machines that occasionally hang without warning
        is not an option, either.

* Devices
    - Graphics initialization (Use native graphics init)  --->
    - Display  --->
        + Framebuffer mode (Linear "high-resolution" framebuffer)  --->

* Payload
    - Add a payload (An ELF executable payload)  --->
    - `"(payload.elf)"` Payload path and filename

        NOTE: File `payload.elf` should match your previously built
        executable GRUB payload file for platform i386-coreboot. See
        [GRUB How-To][].

    - Secondary Payloads --->
        + Select: Load coreinfo as a secondary payload
        + Select: Load nvramcui as a secondary payload

NOTE: The .config file may contain your paths which you probably don't
want to share with others.


Compile
-------


When you have exit the menuconfig tool, type:

    $ make

This will provide the `coreboot.rom` in folder `build/`.


Add Custom Files
----------------


### Add Zerocat’s GRUB Configuration File


Use coreboot’s `cbfstool` to add the custom configuration file as
`etc/zerocat.cfg`.

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


### Add Descriptor and GbE File


See [How To Modify The Intel Flash Descriptor][how-to-modify-ifd] for
reference.

Now add the previously generated descriptor+gbe to your ROM image,
adapt paths as required:

    $ dd \
        if=ich9fdgbe_8m.bin \
        of=build/coreboot.rom \
        bs=1 count=12k conv=notrunc

NOTE: This X200 still has its IME architecture on board and it is
unknown to the public which basic features might be hardwired. It
probably would be safer *not* to install the GbE binary blob using the
“...fdnogbe...” binaries. However, this doesn't seem to work with this
How-to. The toolchain scripts offer to blank region GbE instead.


Tweak Parameters in `cmos.default`
----------------------------------


Tweak parameters `gfx_uma_size`, `wwan` and `bluetooth` in the ROM’s
`cmos.default` file:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w gfx_uma_size=256M
    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w wwan=Disable
    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -w bluetooth=Disable

Inquire parameter’s possible values with option `-e`, i.e.:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -e gfx_uma_size

Our “standard” CMOS setup now looks like this:

    $ build/util/nvramtool/nvramtool -C build/coreboot.rom -a
    boot_option = Fallback
    reboot_counter = 0x0
    debug_level = Spew
    sata_mode = AHCI
    power_on_after_fail = Disable
    first_battery = Primary
    bluetooth = Disable
    wwan = Disable
    wlan = Enable
    trackpoint = Enable
    volume = 0x3
    fn_ctrl_swap = Disable
    sticky_fn = Disable
    power_management_beeps = Enable
    low_battery_beep = Enable
    uwb = Disable
    boot_devices =
    boot_default = 0x0
    gfx_uma_size = 256M

NOTE: You will be able to modify these settings with the NVRAMCUI
Payload upon boot time.


Done!
-----


Your ROM should now be ready to go!

Don't forget to reset the checksum of the NVRAM Option Table to zero by
unplugging the small coin battery for some seconds.



[how-to-modify-ifd]:              ../doc/how-to-modify-ifd.md
[GRUB How-To]:                    ../doc/grub-how-to.md
[Coreinfo CPU Exceptions]:        ../doc/coreinfo-cpu-exceptions.md
[grub@2.02_zerocat.cfg]:          ../templates/grub@2.02_zerocat.cfg


___

Copyright (C) 2017-2019  Kai Mertens <kmx@posteo.net>  
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover
Texts. A copy of the license is included in the section entitled:
[GNU Free Documentation License](../doc/GNU-FDL.md)
