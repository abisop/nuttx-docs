fire-stm2v2
===========

chip:stm32, chip:stm32f1, chip:stm32f103

This page discusses issues unique to NuttX configurations for the M3
Wildfire development board (STM32F103VET6). See
<http://firestm32.taobao.com>

This configuration should support both the version 2 and version 3 of
the Wildfire board (using NuttX configuration options). However, only
version 2 has been verified.

Pin Configuration
-----------------

DFU and JTAG
------------

### Enabling Support for the DFU Bootloader

The linker files in these projects can be configured to indicate that
you will be loading code using STMicro built-in USB Device Firmware
Upgrade (DFU) loader or via some JTAG emulator. You can specify the DFU
bootloader by adding the following line:

    CONFIG_STM32_DFU=y

to your .config file. Most of the configurations in this directory are
set up to use the DFU loader.

If CONFIG\_STM32\_DFU is defined, the code will not be positioned at the
beginning of FLASH (0x08000000) but will be offset to 0x08003000. This
offset is needed to make space for the DFU loader and 0x08003000 is
where the DFU loader expects to find new applications at boot time. If
you need to change that origin for some other bootloader, you will need
to edit the file(s) ld.script.dfu for the configuration.

The DFU SE PC-based software is available from the STMicro website,
<http://www.st.com>. General usage instructions:

1.  Convert the NuttX Intel Hex file (nuttx.hex) into a special DFU file
    (nuttx.dfu)\... see below for details.
2.  Connect the M3 Wildfire board to your computer using a USB cable.
3.  Start the DFU loader on the M3 Wildfire board. You do this by
    resetting the board while holding the *Key* button. Windows should
    recognize that the DFU loader has been installed.
4.  Run the DFU SE program to load nuttx.dfu into FLASH.

What if the DFU loader is not in FLASH? The loader code is available
inside of the Demo directory of the USBLib ZIP file that can be
downloaded from the STMicro Website. You can build it using RIDE (or
other toolchains); you will need a JTAG emulator to burn it into FLASH
the first time.

In order to use STMicro\'s built-in DFU loader, you will have to get the
NuttX binary into a special format with a .dfu extension. The DFU SE
PC\_based software installation includes a file \"DFU File Manager\"
conversion program that a file in Intel Hex format to the special DFU
format. When you successfully build NuttX, you will find a file called
nutt.hex in the top-level directory. That is the file that you should
provide to the DFU File Manager. You will end up with a file called
nuttx.dfu that you can use with the STMicro DFU SE program.

### Enabling JTAG

If you are not using the DFU, then you will probably also need to enable
JTAG support. By default, all JTAG support is disabled but there NuttX
configuration options to enable JTAG in various different ways.

These configurations effect the setting of the SWJ\_CFG\[2:0\] bits in
the AFIO MAPR register. These bits are used to configure the SWJ and
trace alternate function I/Os. The SWJ (SerialWire JTAG) supports JTAG
or SWD access to the Cortex debug port. The default state in this port
is for all JTAG support to be disabled.:

    CONFIG_STM32_JTAG_FULL_ENABLE - sets SWJ_CFG[2:0] to 000 which enables full
      SWJ (JTAG-DP + SW-DP)

    CONFIG_STM32_JTAG_NOJNTRST_ENABLE - sets SWJ_CFG[2:0] to 001 which enable
      full SWJ (JTAG-DP + SW-DP) but without JNTRST.

    CONFIG_STM32_JTAG_SW_ENABLE - sets SWJ_CFG[2:0] to 010 which would set JTAG-DP
      disabled and SW-DP enabled.

    The default setting (none of the above defined) is SWJ_CFG[2:0] set to 100
    which disable JTAG-DP and SW-DP.

OpenOCD
-------

I have also used OpenOCD with the M3 Wildfire. In this case, I used the
Olimex USB ARM OCD. See the script in
boards/arm/stm32/fire-stm32v2/tools/oocd.sh for more information. Using
the script:

-   Start the OpenOCD GDB server:

        cd <nuttx-build-directory>
        boards/arm/stm32/fire-stm32v2/tools/oocd.sh PWD

-   Load NuttX:

        cd <nuttx-built-directory>
        arm-none-eabi-gdb nuttx
        gdb> target remote localhost:3333
        gdb> mon reset
        gdb> mon halt
        gdb> load nuttx

-   Running NuttX:

        gdb> mon reset
        gdb> c

LEDs
----

The M3 Wildfire has 3 LEDs labeled LED1, LED2 and LED3. These LEDs are
not used by the NuttX port unless CONFIG\_ARCH\_LEDS is defined. In that
case, the usage by the board port is defined in include/board.h and
src/up\_autoleds.c. The LEDs are used to encode OS-related events as
follows:

    /* LED1   LED2   LED3 */
    #define LED_STARTED                0  /* OFF    OFF    OFF */
    #define LED_HEAPALLOCATE           1  /* ON     OFF    OFF */
    #define LED_IRQSENABLED            2  /* OFF    ON     OFF */
    #define LED_STACKCREATED           3  /* OFF    OFF    OFF */

    #define LED_INIRQ                  4  /* NC     NC    ON  (momentary) */
    #define LED_SIGNAL                 5  /* NC     NC    ON  (momentary) */
    #define LED_ASSERTION              6  /* NC     NC    ON  (momentary) */
    #define LED_PANIC                  7  /* NC     NC    ON  (2Hz flashing) */
    #undef  LED_IDLE                      /* Sleep mode indication not supported */

RTC
---

The STM32 RTC may configured using the following settings.:

    CONFIG_RTC - Enables general support for a hardware RTC. Specific
      architectures may require other specific settings.
    CONFIG_RTC_HIRES - The typical RTC keeps time to resolution of 1
      second, usually supporting a 32-bit time_t value.  In this case,
      the RTC is used to &quot;seed&quot; the normal NuttX timer and the
      NuttX timer provides for higher resolution time. If CONFIG_RTC_HIRES
      is enabled in the NuttX configuration, then the RTC provides higher
      resolution time and completely replaces the system timer for purpose of
      date and time.
    CONFIG_RTC_FREQUENCY - If CONFIG_RTC_HIRES is defined, then the
      frequency of the high resolution RTC must be provided.  If CONFIG_RTC_HIRES
      is not defined, CONFIG_RTC_FREQUENCY is assumed to be one.
    CONFIG_RTC_ALARM - Enable if the RTC hardware supports setting of an alarm.
      A callback function will be executed when the alarm goes off.

In hi-res mode, the STM32 RTC operates only at 16384Hz. Overflow
interrupts are handled when the 32-bit RTC counter overflows every 3
days and 43 minutes. A BKP register is incremented on each overflow
interrupt creating, effectively, a 48-bit RTC counter.

In the lo-res mode, the RTC operates at 1Hz. Overflow interrupts are not
handled (because the next overflow is not expected until the year 2106).

WARNING: Overflow interrupts are lost whenever the STM32 is powered
down. The overflow interrupt may be lost even if the STM32 is powered
down only momentarily. Therefore hi-res solution is only useful in
systems where the power is always on.

M3 Wildfire-specific Configuration Options
------------------------------------------

Configurations
--------------

Each M3 Wildfire configuration is maintained in a sub-directory and can
be selected as follow:

    tools/configure.sh fire-stm32v2:<subdir>

Where \<subdir\> is one of the following:

### nsh

Configure the NuttShell (nsh) located at examples/nsh. The nsh
configuration contains support for some built-in applications that can
be enabled by making some additional minor change to the configuration
file.

Reconfiguring: This configuration uses to the kconfig-mconf
configuration tool to control the configuration. See the section
entitled \"NuttX Configuration Tool\" in the top-level README.txt file.

Start Delays: If no SD card is present in the slot, or if the network is
not connected, then there will be long start-up delays before you get
the NSH prompt. If I am focused on ENC28J60 debug, I usually disable
MMC/SD so that I don\'t have to bother with the SD card:

    CONFIG_STM32_SDIO=n
    CONFIG_MMCSD=n

STATUS: The board port is basically functional. Not all features have
been verified. The ENC28J60 network is not yet functional. Networking is
enabled by default in this configuration for testing purposes. To use
this configuration, the network must currently be disabled. To do this
using the kconfig-mconf configuration tool:

    > make menuconfig

Then de-select \"Networking Support\" -\> \"Networking Support\"

PDATE: The primary problem with the ENC29J60 is a v2 board issue: The
SPI FLASH and the ENC28J60 shared the same SPI chip select signal
(PA4-SPI1-NSS). In order to finish the debug of the ENC28J60, it may be
necessary to lift the SPI FLASH chip select pin from the board.
