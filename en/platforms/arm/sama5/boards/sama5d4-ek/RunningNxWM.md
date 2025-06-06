Simplified instructions for Running the NxWM Demo:

Prerequisites:
==============

1.  SAMA5D4-MB Rev. C board and power supply
2.  TM7000 LCD panel
3.  RS-232 NUL modem cable
4.  Ethernet cross-over cable
5.  USB "Boot" Keyboard
6.  One each of a microSD card and a full size SD card. These should be
    older style SD or SDHC cards. Some of the newest very high capacity
    cards will not work.
7.  The file dramboot.bin which is the NuttX boot program. It runs from
    SRAM and will load the NuttX HEX binary from serial into DRAM.
8.  The NuttX HEX binary, nuttx.hex.

References:
===========

See the README.txt for much more detailed, technical information.

Setup:
======

1.  Make sure that the you a terminal like TeraTerm connected to the
    DB-9 and configured to work at 11520 8N1.

2.  You should also connect a USB keyboard and the TM7000 LCD to the
    SAMA5D4-MB Rev C. Note only USB "Boot" keyboards are supported.

3.  The binary has networking enabled. The network is configured to work
    in my test environment so it does not use DHCP, rather the board
    uses the fixed IP address of 10.0.0.2. It expects the host PC to
    have the address 10.0.0.1.

    For testing, usually use a PC with two networks (one configured at
    115200 8N1) and an Ethernet crossover cable.

4.  A full size SD card with some sample .WAV files may be inserted in
    HSMCI0 slot. These files will be accessed by the Media Player demo.

If you do not connect a network to the board, the consequence will be an
extremely slow start up time. Ideally, network bring-up should occur on
a separate thread so that it does not interfere with the main
application. If you have the network connected, the start up will be
quick. If there is no network connected, it could take a long time to
start (perhaps a minute?). The delay is the time before the Ethernet
driver decides to fail the attempt to negotiate the link speed.

Starting the Demo:
==================

1.  Copy dramboot.bin to a microSD card as boot.bin

2.  Inserted the microSD card in the HSMCI1 slot.

3.  Power cycle the board, you should see:

    RomBOOT Send Intel HEX file now

4.  Send the NuttX file from the terminal. If you use TeraTerm, this is
    in the "Files" menu as "Send file ..."

5.  When the file download completes, NuttX will start.

Running the Demo:
=================

When NuttX first starts, you will need to perform a touchscreen
calibration:

1.  Touch the circular when you see the "Touch" or "Again" messages.

2.  Release the touch when you see the "OK" message.

There are four points to be touched and the software will expect you to
touch each position twice.

There is a NuttX configuration option that will allow you to save this
calibration file to FLASH or a file, but that option is not enabled in
this configuration. As you result, you have to do this calibration on
each boot.

After that the Demo will start. The opening screen will show a taskbar
and tray to the left and the background with the NuttX logo.

Touching the triangle button in the taskbar will bring up the Start
Window. The start window holds icons for each installed application. For
this demo the following icons will be visible:

1.  Scales: This will perform touchscreen calibration again.

2.  NxTerm. This is will bring up a graphics terminal running the
    NuttShell (NSH). You interact with NSH using the attached USB
    keyboard.

3.  Calculator. A simple HEX calculator

4.  Media Player. This brings up the media player GUI. There is a list
    box that shows all of the .WAV fails from the SD card that are
    available. Touching the file name selects it. There are also
    controls to play, pause, fast forward, rewind, and adjust the
    volume.

    Unfortunately in this version, the WM8904 audio CODEC is stubbed out
    so you will not actually be able to heard any of the .WAV files that
    you

Telnet access:
==============

For better access to NSH, you can also Telnet to the target at address
10.0.0.2
