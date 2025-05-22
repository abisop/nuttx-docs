Device Drivers
==============

NuttX supports a variety of device drivers, which can be broadly divided
in three classes:

::: {.toctree maxdepth="1"}
character/index.rst block/index.rst special/index.rst thermal/index.rst
:::

::: {.note}
::: {.title}
Note
:::

Device driver support depends on the *in-memory*, *pseudo* file system
that is enabled by default.
:::

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
`../../implementation/drivers_design`{.interpreted-text role="doc"} and
`../../implementation/device_drivers`{.interpreted-text role="doc"}.

Subdirectories of `nuttx/drivers`
---------------------------------

-   `1wire/` `character/1wire`{.interpreted-text role="doc"}

    1wire device drivers.

-   `analog/` `character/analog/index`{.interpreted-text role="doc"}

    This directory holds implementations of analog device drivers. This
    includes drivers for Analog to Digital Conversion (ADC) as well as
    drivers for Digital to Analog Conversion (DAC).

-   `audio/` `special/audio`{.interpreted-text role="doc"}

    Audio device drivers.

-   `bch/` `character/bch`{.interpreted-text role="doc"}

    Contains logic that may be used to convert a block driver into a
    character driver. This is the complementary conversion as that
    performed by loop.c.

-   `can/` `character/can`{.interpreted-text role="doc"}

    This is the CAN drivers and logic support.

-   `clk/``special/clk`{.interpreted-text role="doc"}

    Clock management (CLK) device drivers.

-   `contactless/` `character/contactless`{.interpreted-text role="doc"}

    Contactless devices are related to wireless devices. They are not
    communication devices with other similar peers, but
    couplers/interfaces to contactless cards and tags.

-   `crypto/` `character/crypto/index`{.interpreted-text role="doc"}

    Contains crypto drivers and support logic, including the
    `/dev/urandom` device.

-   `devicetree/` `special/devicetree`{.interpreted-text role="doc"}

    Device Tree support.

-   `dma/` `special/dma`{.interpreted-text role="doc"}

    DMA drivers support.

-   `eeprom/` `block/eeprom`{.interpreted-text role="doc"}

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

-   `efuse/` `character/efuse`{.interpreted-text role="doc"}

    EFUSE drivers support.

-   `i2c/` `special/i2c`{.interpreted-text role="doc"}

    I2C drivers and support logic.

-   `i2s/` `character/i2s`{.interpreted-text role="doc"}

    I2S drivers and support logic.

-   `i3c/` `special/i3c`{.interpreted-text role="doc"}

    I3C drivers and support logic.

-   `input/` `character/input/index`{.interpreted-text role="doc"}

    This directory holds implementations of human input device (HID)
    drivers. This includes such things as mouse, touchscreen, joystick,
    keyboard and keypad drivers.

    Note that USB HID devices are treated differently. These can be
    found under `usbdev/` or `usbhost/`.

-   `ioexpander/` `special/ioexpander`{.interpreted-text role="doc"}

    IO Expander drivers.

-   `ipcc/` `character/ipcc`{.interpreted-text role="doc"}

    IPCC (Inter Processor Communication Controller) driver.

-   `lcd/` `special/lcd`{.interpreted-text role="doc"}

    Drivers for parallel and serial LCD and OLED type devices.

-   `leds/` `character/leds/index`{.interpreted-text role="doc"}

    Various LED-related drivers including discrete as well as PWM-
    driven LEDs.

-   `loop/` `character/loop`{.interpreted-text role="doc"}

    Supports the standard loop device that can be used to export a file
    (or character device) as a block device.

    See `losetup()` and `loteardown()` in `include/nuttx/fs/fs.h`.

-   `math/` `character/math`{.interpreted-text role="doc"}

    MATH Acceleration drivers.

-   `misc/` `character/nullzero`{.interpreted-text role="doc"}
    `special/rwbuffer`{.interpreted-text role="doc"}
    `block/ramdisk`{.interpreted-text role="doc"}

    Various drivers that don\'t fit elsewhere.

-   `mmcsd/` `special/sdio`{.interpreted-text role="doc"}
    `special/mmcsd`{.interpreted-text role="doc"}

    Support for MMC/SD block drivers. MMC/SD block drivers based on SPI
    and SDIO/MCI interfaces are supported.

-   `modem/` `character/modem`{.interpreted-text role="doc"}

    Modem Support.

-   `motor/` `character/motor/index`{.interpreted-text role="doc"}

    Motor control drivers.

-   `mtd/` `special/mtd`{.interpreted-text role="doc"}

    Memory Technology Device (MTD) drivers. Some simple drivers for
    memory technologies like FLASH, EEPROM, NVRAM, etc.

    (Note: This is a simple memory interface and should not be confused
    with the \"real\" MTD developed at infradead.org. This logic is
    unrelated; I just used the name MTD because I am not aware of any
    other common way to refer to this class of devices).

-   `net/` `special/net/index`{.interpreted-text role="doc"}

    Network interface drivers.

-   `notes/` `character/note`{.interpreted-text role="doc"}

    Note Driver Support.

-   `pinctrl/` `special/pinctrl`{.interpreted-text role="doc"}

    Configure and manage pin.

-   `pipes/` `special/pipes`{.interpreted-text role="doc"}

    FIFO and named pipe drivers. Standard interfaces are declared in
    `include/unistd.h`

-   `power/` `special/power/index`{.interpreted-text role="doc"}

    Various drivers related to power management.

-   `rc/` `character/rc`{.interpreted-text role="doc"}

    Remote Control Device Support.

-   `regmap/` `special/regmap`{.interpreted-text role="doc"}

    Regmap Subsystems Support.

-   `reset/` `special/reset`{.interpreted-text role="doc"}

    Reset Driver Support.

-   `rf/` `character/rf`{.interpreted-text role="doc"}

    RF Device Support.

-   `rptun/` `special/rptun`{.interpreted-text role="doc"}

    Remote Proc Tunnel Driver Support.

-   `segger/` `special/segger`{.interpreted-text role="doc"}

    Segger RTT drivers.

-   `sensors/` `special/sensors`{.interpreted-text role="doc"}

    Drivers for various sensors. A sensor driver differs little from
    other types of drivers other than they are use to provide
    measurements of things in environment like temperature, orientation,
    acceleration, altitude, direction, position, etc.

    DACs might fit this definition of a sensor driver as well since they
    measure and convert voltage levels. DACs, however, are retained in
    the `analog/` sub-directory.

-   `serial/``character/serial`{.interpreted-text role="doc"}

    Front-end character drivers for chip-specific UARTs. This provide
    some TTY-like functionality and are commonly used (but not required
    for) the NuttX system console.

-   `spi/` `special/spi`{.interpreted-text role="doc"}

    SPI drivers and support logic.

-   `syslog/` `special/syslog`{.interpreted-text role="doc"}

    System logging devices.

-   `timers/` `character/timers/index`{.interpreted-text role="doc"}

    Includes support for various timer devices.

-   `usbdev/` `special/usbdev`{.interpreted-text role="doc"}

    USB device drivers.

-   `usbhost/` `special/usbhost`{.interpreted-text role="doc"}

    USB host drivers.

-   `usbmisc/` `special/usbmisc`{.interpreted-text role="doc"}

    USB Miscellaneous drivers.

-   `usbmonitor/` `special/usbmonitor`{.interpreted-text role="doc"}

    USB Monitor support.

-   `usrsock/` `special/usrsock`{.interpreted-text role="doc"}

    Usrsock Driver Support.

-   `video/` `special/video`{.interpreted-text role="doc"}

    Video-related drivers.

-   `virtio/` `special/virtio`{.interpreted-text role="doc"}

    Virtio Device Support.

-   `wireless/` `special/wireless`{.interpreted-text role="doc"}

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
