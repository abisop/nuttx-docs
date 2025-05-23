# Device Drivers

NuttX supports a variety of device drivers, which can be broadly divided
in three classes:

> character/index.rst block/index.rst special/index.rst
> thermal/index.rst

<div class="note">

<div class="title">

Note

</div>

Device driver support depends on the *in-memory*, *pseudo* file system
that is enabled by default.

</div>

## Lower-half and upper-half

Drivers in NuttX generally work in two distinct layers:

>   - An *upper half* which registers itself to NuttX using a call such
>     as :c`register_driver` or :c`register_blockdriver` and implements
>     the corresponding high-level interface
>     (<span class="title-ref">read</span>,
>     <span class="title-ref">write</span>,
>     <span class="title-ref">close</span>, etc.). implements the
>     interface. This *upper half* calls into the *lower half* via
>     callbacks.
>   - A "lower half" which is typically hardware-specific. This is
>     usually implemented at the architecture or board level.

Details about drivers implementation can be found in
\[<span class="title-ref">../../implementation/driver\](</span>../../implementation/driver.md)s\_design\`
and
\[<span class="title-ref">../../implementation/device\_driver\](</span>../../implementation/device\_driver.md)s\`.

## Subdirectories of `nuttx/drivers`

  - `1wire/`
    \[<span class="title-ref">character/1wire</span>\](<span class="title-ref">character/1wire</span>.md)
    
    1wire device drivers.

  - `analog/`
    \[<span class="title-ref">character/analog/index</span>\](<span class="title-ref">character/analog/index</span>.md)
    
    This directory holds implementations of analog device drivers. This
    includes drivers for Analog to Digital Conversion (ADC) as well as
    drivers for Digital to Analog Conversion (DAC).

  - `audio/` \[<span class="title-ref">\](</span>.md)special/audio\`
    
    Audio device drivers.

  - `bch/`
    \[<span class="title-ref">character/bch</span>\](<span class="title-ref">character/bch</span>.md)
    
    Contains logic that may be used to convert a block driver into a
    character driver. This is the complementary conversion as that
    performed by loop.c.

  - `can/`
    \[<span class="title-ref">character/can</span>\](<span class="title-ref">character/can</span>.md)
    
    This is the CAN drivers and logic support.

  - `clk/`\[<span class="title-ref">\](</span>.md)special/clk\`
    
    Clock management (CLK) device drivers.

  - `contactless/`
    \[<span class="title-ref">character/contactle\](\`character/contactle.md)ss</span>
    
    Contactless devices are related to wireless devices. They are not
    communication devices with other similar peers, but
    couplers/interfaces to contactless cards and tags.

  - `crypto/`
    \[<span class="title-ref">character/crypto/index</span>\](<span class="title-ref">character/crypto/index</span>.md)
    
    Contains crypto drivers and support logic, including the
    `/dev/urandom` device.

  - `devicetree/`
    \[<span class="title-ref">\](</span>.md)special/devicetree\`
    
    Device Tree support.

  - `dma/` \[<span class="title-ref">\](</span>.md)special/dma\`
    
    DMA drivers support.

  - `eeprom/`
    \[<span class="title-ref">block/eeprom</span>\](<span class="title-ref">block/eeprom</span>.md)
    
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

  - `efuse/`
    \[<span class="title-ref">character/efu\](\`character/efu.md)se</span>
    
    EFUSE drivers support.

  - `i2c/` \[<span class="title-ref">\](</span>.md)special/i2c\`
    
    I2C drivers and support logic.

  - `i2s/`
    \[<span class="title-ref">character/i2\](\`character/i2.md)s</span>
    
    I2S drivers and support logic.

  - `i3c/` \[<span class="title-ref">\](</span>.md)special/i3c\`
    
    I3C drivers and support logic.

  - `input/`
    \[<span class="title-ref">character/input/index</span>\](<span class="title-ref">character/input/index</span>.md)
    
    This directory holds implementations of human input device (HID)
    drivers. This includes such things as mouse, touchscreen, joystick,
    keyboard and keypad drivers.
    
    Note that USB HID devices are treated differently. These can be
    found under `usbdev/` or `usbhost/`.

  - `ioexpander/`
    \[<span class="title-ref">\](</span>.md)special/ioexpander\`
    
    IO Expander drivers.

  - `ipcc/`
    \[<span class="title-ref">character/ipcc</span>\](<span class="title-ref">character/ipcc</span>.md)
    
    IPCC (Inter Processor Communication Controller) driver.

  - `lcd/` \[<span class="title-ref">\](</span>.md)special/lcd\`
    
    Drivers for parallel and serial LCD and OLED type devices.

  - `leds/`
    \[<span class="title-ref">character/led\](\`character/led.md)s/index</span>
    
    Various LED-related drivers including discrete as well as PWM-
    driven LEDs.

  - `loop/`
    \[<span class="title-ref">character/loop</span>\](<span class="title-ref">character/loop</span>.md)
    
    Supports the standard loop device that can be used to export a file
    (or character device) as a block device.
    
    See `losetup()` and `loteardown()` in `include/nuttx/fs/fs.h`.

  - `math/`
    \[<span class="title-ref">character/math</span>\](<span class="title-ref">character/math</span>.md)
    
    MATH Acceleration drivers.

  - `misc/` \[<span class="title-ref">character/nullzero</span>
    ``](`character/nullzero`` `.md)special/rwbuffer`
    \[<span class="title-ref">block/ramdi\](\`block/ramdi.md)sk</span>
    
    Various drivers that don't fit elsewhere.

  - `mmcsd/` \[<span class="title-ref">\](</span>.md)special/sdio\`
    \[<span class="title-ref">\](</span>.md)special/mmcsd\`
    
    Support for MMC/SD block drivers. MMC/SD block drivers based on SPI
    and SDIO/MCI interfaces are supported.

  - `modem/`
    \[<span class="title-ref">character/modem</span>\](<span class="title-ref">character/modem</span>.md)
    
    Modem Support.

  - `motor/`
    \[<span class="title-ref">character/motor/index</span>\](<span class="title-ref">character/motor/index</span>.md)
    
    Motor control drivers.

  - `mtd/` \[<span class="title-ref">\](</span>.md)special/mtd\`
    
    Memory Technology Device (MTD) drivers. Some simple drivers for
    memory technologies like FLASH, EEPROM, NVRAM, etc.
    
    (Note: This is a simple memory interface and should not be confused
    with the "real" MTD developed at infradead.org. This logic is
    unrelated; I just used the name MTD because I am not aware of any
    other common way to refer to this class of devices).

  - `net/` \[<span class="title-ref">\](</span>.md)special/net/index\`
    
    Network interface drivers.

  - `notes/`
    \[<span class="title-ref">character/note</span>\](<span class="title-ref">character/note</span>.md)
    
    Note Driver Support.

  - `pinctrl/` \[<span class="title-ref">\](</span>.md)special/pinctrl\`
    
    Configure and manage pin.

  - `pipes/` \[<span class="title-ref">\](</span>.md)special/pipes\`
    
    FIFO and named pipe drivers. Standard interfaces are declared in
    `include/unistd.h`

  - `power/`
    \[<span class="title-ref">\](</span>.md)special/power/index\`
    
    Various drivers related to power management.

  - `rc/`
    \[<span class="title-ref">character/rc</span>\](<span class="title-ref">character/rc</span>.md)
    
    Remote Control Device Support.

  - `regmap/` \[<span class="title-ref">\](</span>.md)special/regmap\`
    
    Regmap Subsystems Support.

  - `reset/` \[<span class="title-ref">\](</span>.md)special/reset\`
    
    Reset Driver Support.

  - `rf/`
    \[<span class="title-ref">character/rf</span>\](<span class="title-ref">character/rf</span>.md)
    
    RF Device Support.

  - `rptun/` \[<span class="title-ref">\](</span>.md)special/rptun\`
    
    Remote Proc Tunnel Driver Support.

  - `segger/` \[<span class="title-ref">\](</span>.md)special/segger\`
    
    Segger RTT drivers.

  - `sensors/` \[<span class="title-ref">\](</span>.md)special/sensors\`
    
    Drivers for various sensors. A sensor driver differs little from
    other types of drivers other than they are use to provide
    measurements of things in environment like temperature, orientation,
    acceleration, altitude, direction, position, etc.
    
    DACs might fit this definition of a sensor driver as well since they
    measure and convert voltage levels. DACs, however, are retained in
    the `analog/` sub-directory.

  - `serial/`\[<span class="title-ref">character/\](\`character/.md)serial</span>
    
    Front-end character drivers for chip-specific UARTs. This provide
    some TTY-like functionality and are commonly used (but not required
    for) the NuttX system console.

  - `spi/` \[<span class="title-ref">\](</span>.md)special/spi\`
    
    SPI drivers and support logic.

  - `syslog/` \[<span class="title-ref">\](</span>.md)special/syslog\`
    
    System logging devices.

  - `timers/`
    \[<span class="title-ref">character/timer\](\`character/timer.md)s/index</span>
    
    Includes support for various timer devices.

  - `usbdev/` \[<span class="title-ref">\](</span>.md)special/usbdev\`
    
    USB device drivers.

  - `usbhost/` \[<span class="title-ref">\](</span>.md)special/usbhost\`
    
    USB host drivers.

  - `usbmisc/` \[<span class="title-ref">\](</span>.md)special/usbmisc\`
    
    USB Miscellaneous drivers.

  - `usbmonitor/`
    \[<span class="title-ref">\](</span>.md)special/usbmonitor\`
    
    USB Monitor support.

  - `usrsock/` \[<span class="title-ref">\](</span>.md)special/usrsock\`
    
    Usrsock Driver Support.

  - `video/` \[<span class="title-ref">\](</span>.md)special/video\`
    
    Video-related drivers.

  - `virtio/` \[<span class="title-ref">\](</span>.md)special/virtio\`
    
    Virtio Device Support.

  - `wireless/`
    \[<span class="title-ref">\](</span>.md)special/wireless\`
    
    Drivers for various wireless devices.

## Skeleton Files

Skeleton files are "empty" frameworks for NuttX drivers. They are
provided to give you a good starting point if you want to create a new
NuttX driver. The following skeleton files are available:

  - `drivers/lcd/skeleton.c` Skeleton LCD driver
  - `drivers/mtd/skeleton.c` Skeleton memory technology device drivers
  - `drivers/net/skeleton.c` Skeleton network/Ethernet drivers
  - `drivers/usbhost/usbhost_skeleton.c` Skeleton USB host class driver

## Drivers Early Initialization

To initialize drivers early in the boot process, the
:c`drivers_early_initialize` function is introduced. This is
particularly beneficial for certain drivers, such as SEGGER SystemView,
or others that require initialization before the system is fully
operational.

It is important to note that during this early initialization phase,
system resources are not yet available for use. This includes memory
allocation, file systems, and any other system resources.
