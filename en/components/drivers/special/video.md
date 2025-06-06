Video Device Drivers
====================

-   `include/nuttx/video/`. All structures and APIs needed to work with
    video drivers are provided in this header file.

max7456
-------

23 March 2019 Bill Gatliff \<<bgat@billgatliff.com>\>

The code in drivers/video/max7456.\[ch\] is a preliminary device driver
for the MAX7456 analog on-screen-display generator. This SPI slave chip
is a popular feature in many embedded devices due its low cost and power
requirements. In particular, you see it a lot on drone flight-management
units.

I use the term \"preliminary\" because at present, only the most
rudimentary capabilities of the chip are supported:

> -   chip reset and startup
> -   read and write low-level chip control registers (DEBUG mode only)
> -   write CA (Character Address) data to the chip\'s framebuffer
>     memory

Some key missing features are, in no particular order:

> -   VSYNC and HSYNC synchronization (prevents flicker)
> -   ability to update NVM (define custom character sets)

If you have a factory-fresh chip, then the datasheet shows you what the
factory character data set looks like. If you\'ve used the chip in other
scenarios, i.e. with Betaflight or similar, then your chip will almost
certainly have had the factory character data replaced with something
application-specific.

Either way, you\'ll probably want to update your character set before
long. I should probably get that working, unless you want to take a look
at it yoruself\...

The max7456\_register() function starts things rolling. The omnibusf4
target device provides an example (there may be others by the time you
read this).

In normal use, the driver creates a set of interfaces under /dev, i.e.:

    /dev/osd0/fb
    /dev/osd0/raw   (*)
    /dev/osd0/vsync (*)

-   -   not yet implemented

By writing character data to the \"fb\" interface, you\'ll see data
appear on the display. NOTE that the data you write is NOT, for example,
ASCII text: it is the addresses of the characters in the chip\'s onboard
character map.

For example, if entry 42 in your onboard character map is a bitmap that
looks like \"H\", then when you write the ASCII \"\*\" (decimal 42, hex
2a), you\'ll see that \"H\" appear on your screen.

If you build the code with the DEBUG macro defined, you will see a bunch
more interfaces:

    /dev/osd0/VM0
    /dev/osd0/VM1
    /dev/osd/DMM
    ...
    ...

These are interfaces to the low-level chip registers, which can be read
and/or written to help you figure out what\'s going on inside the chip.
They\'re probably more useful for me than you, but there they are in
case I\'m wrong about that.

b.g.
