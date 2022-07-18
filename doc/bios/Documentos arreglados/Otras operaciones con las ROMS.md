# Otras operaciones con las ROMS

## EXTRAYENDO LAS REGIONES DE LA FLASH

The content of flash region 0 will not be used, instead a libreboot-modified descriptor build from scratch comes into action. 
    • Flash region 1 will be replaced by coreboot firmware. From the output above, the original size of that region is obvious: 0x200000.
This region will be increased by the modified descriptor, and it will be located right behind the re-located region 3. 
    • Flash region 2 will be deleted. 
    • The content of region 3 will not be used.
Instead, GbE configuration data will be build from scratch, and region 3 will be located right behind region 0. 
    • Flash region 4 will be deleted. 

cd util/ifdtool
$ make
$ ./ifdtool -x lenovo.bin
File lenovo.bin is 8388608 bytes
  Flash Region 0 (Flash Descriptor): 00000000 - 00000fff
  Flash Region 1 (BIOS): 00600000 - 007fffff
  Flash Region 2 (Intel ME): 00001000 - 005f5fff
  Flash Region 3 (GbE): 005f6000 - 005f7fff
  Flash Region 4 (Platform Data): 005f8000 - 005fffff
$ l *.bin
flashregion_0_flashdescriptor.bin flashregion_1_bios.bin flashregion_2_intel_me.bin flashregion_3_gbe.bin flashregion_4_platform_data.bin lenovo.bin


## DIFERENCIAR cmos.default entre dos versiones diferentes:

./util/nvramtool/nvramtool -C rom0.rom -a > nvramrom0
./util/nvramtool/nvramtool -C rom1.rom -a > nvramrom1
$ diff -y nvramrom0 vnramrom1