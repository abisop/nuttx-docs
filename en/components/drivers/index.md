Device Drivers
==============

NuttX supports a variety of device drivers, which can be broadly divided
in three classes:

> character/index.rst block/index.rst special/index.rst
> thermal/index.rst

Note

Device driver support depends on the *in-memory*, *pseudo* file system
that is enabled by default.

Lower-half and upper-half
-------------------------

Drivers in NuttX generally work in two distinct layers:

> -   An *upper half* which registers itself to NuttX using a call such
>     as :c`register_driver`{.interpreted-text role="func"} or
>     :c`register_blockdriver`{.interpreted-text role="func"} and
>     implements the corresponding high-level interface
>     ([read]{.title-ref}, [write]{.title-ref}, [close]{.title-ref},
>     etc.). implements the interface. This *upper half* calls into the
>     *lower half* via callbacks.
> -   A \"lower half\" which is typically hardware-specific. This is
>     usually implemented at the architecture or board level.

Details about drivers implementation can be found in
\[[../../implementation/driver\](]{.title-ref}../../implementation/driver.md)s\_design\`
and
\[[../../implementation/device\_driver\](]{.title-ref}../../implementation/device\_driver.md)s\`.

Subdirectories of `nuttx/drivers`
---------------------------------

-   `1wire/`
    \[[character/1wire]{.title-ref}\]([character/1wire]{.title-ref}.md)

    1wire device drivers.

-   `analog/`
    \[[character/analog/index]{.title-ref}\]([character/analog/index]{.title-ref}.md)

    This directory holds implementations of analog device drivers. This
    includes drivers for Analog to Digital Conversion (ADC) as well as
    drivers for Digital to Analog Conversion (DAC).

-   `audio/` \[[\](]{.title-ref}.md)special/audio\`

    Audio device drivers.

-   `bch/`
    \[[character/bch]{.title-ref}\]([character/bch]{.title-ref}.md)

    Contains logic that may be used to convert a block driver into a
    character driver. This is the complementary conversion as that
    performed by loop.c.

-   `can/`
    \[[character/can]{.title-ref}\]([character/can]{.title-ref}.md)

    This is the CAN drivers and logic support.

-   `clk/`\[[\](]{.title-ref}.md)special/clk\`

    Clock management (CLK) device drivers.

-   `contactless/`
    \[[character/contactle\](\`character/contactle.md)ss]{.title-ref}

    Contactless devices are related to wireless devices. They are not
    communication devices with other similar peers, but
    couplers/interfaces to contactless cards and tags.

-   `crypto/`
    \[[character/crypto/index]{.title-ref}\]([character/crypto/index]{.title-ref}.md)

    Contains crypto drivers and support logic, including the
    `/dev/urandom` device.

-   `devicetree/` \[[\](]{.title-ref}.md)special/devicetree\`

    Device Tree support.

-   `dma/` \[[\](]{.title-ref}.md)special/dma\`

    DMA drivers support.

-   `eeprom/`
    \[[block/eeprom]{.title-ref}\]([block/eeprom]{.title-ref}.md)

    An EEPROM is a form of Memory Technology Device (see `drivers/mtd`).
    EEPROMs are non-volatile memory like FLASH, but differ in underlying
    memory technology and differ in usage in many respects: They may not
    be organized into blocks (at least from the standpoint of the user)
    and it is not necessary to erase the EEPROM memory before re-writing
    it. In addition, EEPROMs tend to be much smaller than FLASH parts,
    usually only a few kilobytes vs megabytes for FLASH. EEPROM tends to
    be used to retain a small amount of device configuration
    information; FLASH tends to be used for program or massive data
    storage. For these reasons, it may not be convenient to use the more
    complex MTD interface but instead use the simple character interface
    provided by the EEPROM drivers.

-   `efuse/` \[[character/efu\](\`character/efu.md)se]{.title-ref}

    EFUSE drivers support.

-   `i2c/` \[[\](]{.title-ref}.md)special/i2c\`

    I2C drivers and support logic.

-   `i2s/` \[[character/i2\](\`character/i2.md)s]{.title-ref}

    I2S drivers and support logic.

-   `i3c/` \[[\](]{.title-ref}.md)special/i3c\`

    I3C drivers and support logic.

-   `input/`
    \[[character/input/index]{.title-ref}\]([character/input/index]{.title-ref}.md)

    This directory holds implementations of human input device (HID)
    drivers. This includes such things as mouse, touchscreen, joystick,
    keyboard and keypad drivers.

    Note that USB HID devices are treated differently. These can be
    found under `usbdev/` or `usbhost/`.

-   `ioexpander/` \[[\](]{.title-ref}.md)special/ioexpander\`

    IO Expander drivers.

-   `ipcc/`
    \[[character/ipcc]{.title-ref}\]([character/ipcc]{.title-ref}.md)

    IPCC (Inter Processor Communication Controller) driver.

-   `lcd/` \[[\](]{.title-ref}.md)special/lcd\`

    Drivers for parallel and serial LCD and OLED type devices.

-   `leds/` \[[character/led\](\`character/led.md)s/index]{.title-ref}

    Various LED-related drivers including discrete as well as PWM-
    driven LEDs.

-   `loop/`
    \[[character/loop]{.title-ref}\]([character/loop]{.title-ref}.md)

    Supports the standard loop device that can be used to export a file
    (or character device) as a block device.

    See `losetup()` and `loteardown()` in `include/nuttx/fs/fs.h`.

-   `math/`
    \[[character/math]{.title-ref}\]([character/math]{.title-ref}.md)

    MATH Acceleration drivers.

-   `misc/` \[[character/nullzero]{.title-ref}
    `` ](`character/nullzero ``{.interpreted-text role="doc"}
    `.md)special/rwbuffer`{.interpreted-text role="doc"}
    \[[block/ramdi\](\`block/ramdi.md)sk]{.title-ref}

    Various drivers that don\'t fit elsewhere.

-   `mmcsd/` \[[\](]{.title-ref}.md)special/sdio\`
    \[[\](]{.title-ref}.md)special/mmcsd\`

    Support for MMC/SD block drivers. MMC/SD block drivers based on SPI
    and SDIO/MCI interfaces are supported.

-   `modem/`
    \[[character/modem]{.title-ref}\]([character/modem]{.title-ref}.md)

    Modem Support.

-   `motor/`
    \[[character/motor/index]{.title-ref}\]([character/motor/index]{.title-ref}.md)

    Motor control drivers.

-   `mtd/` \[[\](]{.title-ref}.md)special/mtd\`

    Memory Technology Device (MTD) drivers. Some simple drivers for
    memory technologies like FLASH, EEPROM, NVRAM, etc.

    (Note: This is a simple memory interface and should not be confused
    with the \"real\" MTD developed at infradead.org. This logic is
    unrelated; I just used the name MTD because I am not aware of any
    other common way to refer to this class of devices).

-   `net/` \[[\](]{.title-ref}.md)special/net/index\`

    Network interface drivers.

-   `notes/`
    \[[character/note]{.title-ref}\]([character/note]{.title-ref}.md)

    Note Driver Support.

-   `pinctrl/` \[[\](]{.title-ref}.md)special/pinctrl\`

    Configure and manage pin.

-   `pipes/` \[[\](]{.title-ref}.md)special/pipes\`

    FIFO and named pipe drivers. Standard interfaces are declared in
    `include/unistd.h`

-   `power/` \[[\](]{.title-ref}.md)special/power/index\`

    Various drivers related to power management.

-   `rc/` \[[character/rc]{.title-ref}\]([character/rc]{.title-ref}.md)

    Remote Control Device Support.

-   `regmap/` \[[\](]{.title-ref}.md)special/regmap\`

    Regmap Subsystems Support.

-   `reset/` \[[\](]{.title-ref}.md)special/reset\`

    Reset Driver Support.

-   `rf/` \[[character/rf]{.title-ref}\]([character/rf]{.title-ref}.md)

    RF Device Support.

-   `rptun/` \[[\](]{.title-ref}.md)special/rptun\`

    Remote Proc Tunnel Driver Support.

-   `segger/` \[[\](]{.title-ref}.md)special/segger\`

    Segger RTT drivers.

-   `sensors/` \[[\](]{.title-ref}.md)special/sensors\`

    Drivers for various sensors. A sensor driver differs little from
    other types of drivers other than they are use to provide
    measurements of things in environment like temperature, orientation,
    acceleration, altitude, direction, position, etc.

    DACs might fit this definition of a sensor driver as well since they
    measure and convert voltage levels. DACs, however, are retained in
    the `analog/` sub-directory.

-   `serial/`\[[character/\](\`character/.md)serial]{.title-ref}

    Front-end character drivers for chip-specific UARTs. This provide
    some TTY-like functionality and are commonly used (but not required
    for) the NuttX system console.

-   `spi/` \[[\](]{.title-ref}.md)special/spi\`

    SPI drivers and support logic.

-   `syslog/` \[[\](]{.title-ref}.md)special/syslog\`

    System logging devices.

-   `timers/`
    \[[character/timer\](\`character/timer.md)s/index]{.title-ref}

    Includes support for various timer devices.

-   `usbdev/` \[[\](]{.title-ref}.md)special/usbdev\`

    USB device drivers.

-   `usbhost/` \[[\](]{.title-ref}.md)special/usbhost\`

    USB host drivers.

-   `usbmisc/` \[[\](]{.title-ref}.md)special/usbmisc\`

    USB Miscellaneous drivers.

-   `usbmonitor/` \[[\](]{.title-ref}.md)special/usbmonitor\`

    USB Monitor support.

-   `usrsock/` \[[\](]{.title-ref}.md)special/usrsock\`

    Usrsock Driver Support.

-   `video/` \[[\](]{.title-ref}.md)special/video\`

    Video-related drivers.

-   `virtio/` \[[\](]{.title-ref}.md)special/virtio\`

    Virtio Device Support.

-   `wireless/` \[[\](]{.title-ref}.md)special/wireless\`

    Drivers for various wireless devices.

Skeleton Files
--------------

Skeleton files are \"empty\" frameworks for NuttX drivers. They are
provided to give you a good starting point if you want to create a new
NuttX driver. The following skeleton files are available:

-   `drivers/lcd/skeleton.c` Skeleton LCD driver
-   `drivers/mtd/skeleton.c` Skeleton memory technology device drivers
-   `drivers/net/skeleton.c` Skeleton network/Ethernet drivers
-   `drivers/usbhost/usbhost_skeleton.c` Skeleton USB host class driver

Drivers Early Initialization
----------------------------

To initialize drivers early in the boot process, the
:c`drivers_early_initialize`{.interpreted-text role="func"} function is
introduced. This is particularly beneficial for certain drivers, such as
SEGGER SystemView, or others that require initialization before the
system is fully operational.

It is important to note that during this early initialization phase,
system resources are not yet available for use. This includes memory
allocation, file systems, and any other system resources.
