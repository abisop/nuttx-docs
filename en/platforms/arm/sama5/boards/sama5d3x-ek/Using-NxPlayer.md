Using the Binaries:
===================

Prerequisites:
==============

1.  SAMA5D3x-EK board and power supply
2.  RS-232 NUL modem cable
3.  A full size SD card. This should be older style SD or SDHC cards.
    Some of the newest very high capacity cards will not work.
4.  The WAV file jsbach16.wav
5.  The NuttX HEX binary, nuttx.hex, .bin or .elf.

Procedure:

1.  Put the WAV file jsbach16.wav on the SD card

2.  Place the SD card in the full size SD slot on the motherboard.

3.  Use SAM-BA to copy the NuttX binary to NOR flash

4.  Set the boot jumper to boot from NOR FLASH

5.  NSH should start

    NuttShell (NSH) NuttX-7.3 nsh\>

6.  Mount the SD card at /music

    nsh\> mount -t vfat /dev/mmcsd0 /music

7.  Star the NxPlayer and select the pcm0 device

    nsh\> nxplayer NxPlayer version 1.04 h for commands, q to exit

    nxplayer\> device pcm0

8.  And play the WAV file

    nxplayer\> play jsbach16.wav
