ST STM32L Discovery
===================

::: {.tags}
chip:stm32, chip:stm32l1, chip:stm32l152
:::

This page discusses issues unique to NuttX configurations for the
STMicro STM32L-Discovery development board. The STM32L-Discovery board
is based on the STM32L152RBT6 MCU (128KB FLASH and 16KB of SRAM).

The STM32L-Discovery and 32L152CDISCOVERY kits are functionally
equivalent. The difference is the internal Flash memory size
(STM32L152RBT6 with 128 Kbytes or STM32L152RCT6 with 256 Kbytes).

Both boards feature:

-   An ST-LINK/V2 embedded debug tool interface,
-   LCD (24 segments, 4 commons),
-   LEDs,
-   Pushbuttons,
-   A linear touch sensor, and
-   Four touchkeys.

LEDs
----

The STM32L-Discovery board has four LEDs. Two of these are controlled by
logic on the board and are not available for software control:

    LD1 COM:   LD2 default status is red. LD2 turns to green to indicate
               that communications are in progress between the PC and the
               ST-LINK/V2.
    LD2 PWR:   Red LED indicates that the board is powered.

And two LEDs can be controlled by software:

    User LD3:  Green LED is a user LED connected to the I/O PB7 of the
               STM32L152 MCU.
    User LD4:  Blue LED is a user LED connected to the I/O PB6 of the
               STM32L152 MCU.

These LEDs are not used by the board port unless CONFIG\_ARCH\_LEDS is
defined. In that case, the usage by the board port is defined in
include/board.h and src/stm32\_autoleds.c. The LEDs are used to encode
OS-related events as follows:

>   SYMBOL                 Meaning                                         LED3      LED4
>   ---------------------- ----------------------------------------------- --------- ----------
>   LED\_STARTED           NuttX has been started                          OFF       OFF
>   LED\_HEAPALLOCATE      Heap has been allocated                         OFF       OFF
>   LED\_IRQSENABLED       Interrupts enabled                              OFF       OFF
>   LED\_STACKCREATED      Idle stack created                              ON        OFF
>   LED\_INIRQ             In an interrupt                                 N/C       N/C
>   LED\_SIGNAL            In a signal handler                             N/C       N/C
>   LED\_ASSERTION         An assertion failed                             N/C       N/C
>   LED\_PANIC LED\_IDLE   The system has crashed STM32 is is sleep mode   OFF N/U   Blinking

Serial Console
--------------

The STM32L-Discovery has no on-board RS-232 driver. Further, there are
no USART pins that do not conflict with the on board resources, in
particular, the LCD: Most USART pins are available if the LCD is
enabled; USART2 may be used if either the LCD or the on-board LEDs are
disabled.

> PA9 USART1\_TX LCD glass COM1 P2, pin 22 PA10 USART1\_RX LCD glass
> COM2 P2, pin 21 PB6 USART1\_TX LED Blue P2, pin 8 PB7 USART1\_RX LED
> Green P2, pin 7
>
> PA2 USART2\_TX LCD SEG1 P1, pin 17 PA3 USART2\_RX LCD SEG2 P1, pin 18
>
> PB10 USART3\_TX LCD SEG6 P1, pin 22 PB11 USART3\_RX LCD SEG7 P1, pin
> 23 PC10 USART3\_TX LCD SEG22 P2, pin 15 PC11 USART3\_RX LCD SEG23 P2,
> pin 14

NOTES:

-   GND and (external) 5V are available on both P1 and P2. Note: These
    signals may be at lower voltage levels and, hence, may not properly
    drive an external RS-232 transceiver.

-   The crystal X3 is not installed on the STM32L3-Discovery. As a
    result, the HSE clock is not available and the less accurate HSI
    must be used. This may limit the accuracy of the computed baud,
    especially at higher BAUD. The HSI is supposedly calibrated in the
    factory to within 1% at room temperatures so perhaps this not a
    issue.

-   According to the STM32L-Discovery User Manual, the LCD should be
    removed from its socket if you use any of the LCD pins for any other
    purpose.

    I have had no problems using the USART1 with PA9 and PA10 with a
    3.3-5V RS-232 transceiver module at 57600 baud. I have not tried
    higher baud rates.

-   There is no support for a USB serial connector on the
    STM32L-Discovery board. The STM32L152 does support USB, but the USB
    pins are \"free I/O\" on the board and no USB connector is provided.
    So the use of a USB console is not option. If you need console
    output, you will need to disable either LCD (and use any USART) or
    the LEDs (and use USART1)

Debugging
---------

If you are going to use a debugger, you should make sure that the
following settings are selection in your configuration file:

    CONFIG_DEBUG_SYMBOLS=y : Enable debug symbols in the build

### STM32 ST-LINK Utility

For simply writing to FLASH, I use the STM32 ST-LINK Utility. At least
version 2.4.0 is required (older versions do not recognize the STM32 F3
device). This utility is available from free from the STMicro website.

### OpenOCD

I am told that OpenOCD will work with the ST-Link, but I have never
tried it.

> <https://github.com/texane/stlink>

This is an open source server for the ST-Link that I have never used.

Configurations
--------------

Each STM32L-Discovery configuration is maintained in a sub-directory and
can be selected as follow:

> tools/configure.sh STM32L-Discovery:\<subdir\>

Where \<subdir\> is one of the following sub-directories.

NOTE: These configurations use the mconf-based configuration tool. To
change any of these configurations using that tool, you should:

> a.  Build and install the kconfig-mconf tool. See nuttx/README.txt see
>     additional README.txt files in the NuttX tools repository.
> b.  Execute \'make menuconfig\' in nuttx/ in order to start the
>     reconfiguration process.

### Configuration sub-directories

### nsh:

Configures the NuttShell (nsh) located at apps/examples/nsh.

NOTES:

1.  The serial console is on UART1 and NuttX LED support is enabled.
    Therefore, you will need an external RS232 driver or TTL
    serial-to-USB converter. The UART1 TX and RX pins should be
    available on PA9 and PA10, respectively.

    The serial console is configured for 57600 8N1 by default.

2.  Support for NSH built-in applications is *not* enabled.

3.  By default, this configuration uses the ARM EABI toolchain for
    Windows and builds under Cygwin (or probably MSYS). That can easily
    be reconfigured, of course.

    Build Setup:

        CONFIG_HOST_WINDOWS=y                   : Builds under Windows
        CONFIG_WINDOWS_CYGWIN=y                 : Using Cygwin

        System Type::

        CONFIG_ARM_TOOLCHAIN_GNU_EABI=y      : GNU EABI toolchain for Windows

4.  SLCD. When the LCD is enabled and the LEDs are disabled, the USART1
    serial console will automatically move to PB6 and PB7 (you will get
    a compilation error if you forget to disable the LEDs).

    >   SIGNAL   FUNCTION     LED         CONNECTION
    >   -------- ------------ ----------- ------------
    >   PB6      USART1\_TX   LED Blue    P2, pin 8
    >   PB7      USART1\_RX   LED Green   P2, pin 7

    To enable apps/examples/slcd to test the SLCD:

    Binary Formats:

        CONFIG_BINFMT_DISABLE=n                 : Don't disable binary support
        CONFIG_BUILTIN=y                        : Enable support for built-in binaries

    Application Configuration -\> NSH Library:

        CONFIG_NSH_BUILTIN_APPS=y               : Enable builtin apps in NSH
        CONFIG_NSH_ARCHINIT=y                   : Needed to initialize the SLCD

    Application Configuration -\> Examples:

        CONFIG_EXAMPLES_SLCD=y                  : Enable apps/examples/slcd
