README
======

This README discusses issues unique to NuttX configurations for the
Atmel SAML21 Xplained Pro development board. This board features the
ATSAML21J18A MCU.

Contents
========

-   STATUS/ISSUES
-   Modules
-   Development Environment
-   GNU Toolchain Options
-   IDEs
-   NuttX EABI "buildroot" Toolchain
-   LEDs and Buttons
-   Serial Consoles
-   Atmel Studio 6.1
-   JTAG
-   SAML21 Xplained Pro-specific Configuration Options
-   Configurations

STATUS/ISSUES
=============

-   Since this port is a leverage of the SAMD20 Xplained port, some of
    the STATUS/ISSUES in the SAMD20 Xplained README.txt may apply here
    as well.

-   2015-5-26: The basic port is running at 48MHz (using 32.768 XTAL
    input and the digital frequency locked loop). The basic NuttShell
    (NSH) configuration is working well with the serial console provided
    by SERCOM4 as 115200 8N1.

-   2015-6-14: Added a DMAC driver. There is no way to verify it at
    present and, hence, depends upon CONFIG\_EXPERIMENTAL=y

Modules
=======

There are several I/O modules available that will work with the SAML21
Xplained Pro Starter Kit:

1)  I/O1 - An MMC/SD card slot, PWM LED control, ADC light sensor, USART
    loopback, TWI AT30TSE758 Temperature sensor.
2)  OLED1 - An OLED plus 3 additional switches and 3 additional LEDs
3)  PROTO1 - A prototyping board with logic on board (other than power-
    related logic).
4)  And others. See
    http://www.atmel.com/products/microcontrollers/avr/xplained.aspx

Some of these are discussed further below.

  I/O1
  ------------------------------------------------------------------------
  The primary function of this module is to provide SD card support, but
  the full list of modules features include:

    - microSD card connector (SPI interface)
    - PWM (LED control)
    - ADC (light sensor)
    - USART loopback
    - TWI AT30TSE758 Temperature sensor with EEPROM

    SPI is available on two of the SAML21 Xplained connectors, EXT1 and EXT2.
    They mate with the I/O1 connector as indicated in this table.

    I/O1 CONNECTOR
    ----------------- ---------------------- ---------------------- ------------------------------------
    I/O1              EXT1                   EXT2                   Other use of either pin
    ----------------- ---------------------- ---------------------- ------------------------------------
    1  ID             1                      1                      Communication line to ID chip on
                                                                    extension board.
    ----------------- ---------------------- ---------------------- ------------------------------------
    2  GND            2       GND            2  GND
    ----------------- ---------------------- ---------------------- ------------------------------------
    3  LIGHT_SENSOR   3  PB05 AIN[13]        3  PA10 AIN[18]
    ----------------- ---------------------- ---------------------- ------------------------------------
    4  LP_OUT         4  PA03 AIN[1]         4  PA11 AIN[19]
    ----------------- ---------------------- ---------------------- ------------------------------------
    5  GPIO1          5  PB06 GPIO           5  PA20 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    6  GPIO2          6  PB07 GPIO           6  PA21 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    7  LED            7  PA12 TCC2/WO[0]     7  PB12 TC4/WO[0]
    ----------------- ---------------------- ---------------------- ------------------------------------
    8  LP_IN          8  PA13 TCC2/WO[1]     8  PB13 TC4/WO[1]
    ----------------- ---------------------- ---------------------- ------------------------------------
    9  TEMP_ALERT     9  PB04 EXTINT[4]      9  PB14 EXTINT[14]
    ----------------- ---------------------- ---------------------- ------------------------------------
    10 microSD_DETECT 10 PA02 GPIO           10 PB15 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    11 TWI SDA        11 PA08 SERCOM2 PAD[0] 11 PA08 SERCOM2 PAD[0] EXT1, EXT2, EXT3 and EDBG
                              I²C SDA                I²C SDA
    ----------------- ---------------------- ---------------------- ------------------------------------
    12 TWI SCL        12 PA09 SERCOM2 PAD[1] 12 PA09 SERCOM2 PAD[1] EXT2, EXT3 and EDBG
                              I²C SCL                I²C SCL
    ----------------- ---------------------- ---------------------- ------------------------------------
    13 USART RX       13 PB09 SERCOM4 PAD[1] 13 PA19 SERCOM1 PAD[3] The SERCOM4 module is shared between
                              USART RX               USART RX       EXT1, 2 and 3 USART's, but uses
                                                                    different pins
    ----------------- ---------------------- ---------------------- ------------------------------------
    14 USART TX       14 PB08 SERCOM4 PAD[0] 14 PA18 SERCOM1 PAD[2] The SERCOM4 module is shared between
                              USART TX               USART TX       EXT1, 2 and 3 USART's, but uses
                                                                    different pins
    ----------------- ---------------------- ---------------------- ------------------------------------
    15 microSD_SS     15 PA05 SERCOM0 PAD[1] 15 PA17 GPIO
                              SPI SS
    ----------------- ---------------------- ---------------------- ------------------------------------
    16 SPI_MOSI       16 PA06 SERCOM0 PAD[2] 16 PB22 SERCOM5 PAD[2]
                              SPI MOSI               SPI MOSI
    ----------------- ---------------------- ---------------------- ------------------------------------
    17 SPI_MISO       17 PA04 SERCOM0 PAD[0] 17 PB16 SERCOM5 PAD[0]
                              SPI MISO               SPI MISO
    ----------------- ---------------------- ---------------------- ------------------------------------
    18 SPI_SCK        18 PA07 SERCOM0 PAD[3] 18 PB23 SERCOM5 PAD[3]
                              SPI SCK                SPI SCK
    ----------------- ---------------------- ---------------------- ------------------------------------
    19 GND            19      GND               GND
    ----------------- ---------------------- ---------------------- ------------------------------------
    20 VCC            20      VCC               VCC
    ----------------- ---------------------- ---------------------- ------------------------------------

    The mapping between the I/O1 pins and the SD connector are shown in the
    following table.

    SD Card Connection
    ------------------
    I/O1 SD   PIN Description
    ---- ---- --- -------------------------------------------------
         D2   1   Data line 2 (not used)
    15   D3   2   Data line 3. Active low chip select, pulled high
    16   CMD  3   Command line, connected to SPI_MOSI.
    20   VDD  4
    18   CLK  5   Clock line, connected to SPI_SCK.
    2/19 GND  6
    17   D0   7   Data line 0, connected to SPI_MISO.
         D1   8   Data line 1 (not used)
    10   SW_A 9   Card detect
    2/19 SW_B 10  GND

    Card Detect
    -----------
    When a microSD card is put into the connector SW_A and SW_B are short-
    circuited. SW_A is connected to the microSD_DETECT signal. To use this
    as a card indicator remember to enable internal pullup in the target
    device.

    GPIOs
    -----
    So all that is required to connect the SD is configure the SPI

    --- ------------------ ---------------------- -------------------------------------
    PIN EXT1               EXT2                   Description
    --- ------------------ ---------------------- -------------------------------------
    15 PA05 SERCOM0 PAD[1] 15 PA17 GPIO            Active low chip select OUTPUT, pulled
            SPI SS                                 high on board.
    --- ------------------ ---------------------- -------------------------------------
    10 PA02 GPIO           10 PB15 GPIO            Active low card detect INPUT, must
                                                   use internal pull-up.
    --- ------------------ ---------------------- -------------------------------------

    Configuration Options:
    ----------------------
      CONFIG_SAML21_XPLAINED_IOMODULE=y      : Informs the system that the
                                              I/O1 module is installed
      CONFIG_SAML21_XPLAINED_IOMODULE_EXT1=y : The module is installed in EXT1
      CONFIG_SAML21_XPLAINED_IOMODULE_EXT2=y : The mdoule is installed in EXT2

    See the set-up in the discussion of the nsh configuration below for other
    required configuration options.

    NOTE: As of this writing, only the SD card slot is supported in the I/O1
    module.

  OLED1
  --------------------------------------------------------------------------
  This module provides an OLED plus 3 additional switches and 3 additional
  LEDs.

    OLED1 CONNECTOR
    ----------------- ---------------------- ---------------------- ------------------------------------
    OLED1             EXT1                   EXT2                   Other use of either pin
    ----------------- ---------------------- ---------------------- ------------------------------------
    1  ID             1                      1                      Communication line to ID chip on
                                                                    extension board.
    ----------------- ---------------------- ---------------------- ------------------------------------
    2  GND            2       GND            2  GND
    ----------------- ---------------------- ---------------------- ------------------------------------
    3  BUTTON2        3  PB05 AIN[13]        3  PA10 AIN[18]
    ----------------- ---------------------- ---------------------- ------------------------------------
    4  BUTTON3        4  PA03 AIN[1]         4  PA11 AIN[19]
    ----------------- ---------------------- ---------------------- ------------------------------------
    5  DATA_CMD_SEL   5  PB06 GPIO           5  PA20 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    6  LED3           6  PB07 GPIO           6  PA21 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    7  LED1           7  PA12 TCC2/WO[0]     7  PB12 TC4/WO[0]
    ----------------- ---------------------- ---------------------- ------------------------------------
    8  LED2           8  PA13 TCC2/WO[1]     8  PB13 TC4/WO[1]
    ----------------- ---------------------- ---------------------- ------------------------------------
    9  BUTTON1        9  PB04 EXTINT[4]      9  PB14 EXTINT[14]
    ----------------- ---------------------- ---------------------- ------------------------------------
    10 DISPLAY_RESET  10 PA02 GPIO           10 PB15 GPIO
    ----------------- ---------------------- ---------------------- ------------------------------------
    11 N/C            11 PA08 SERCOM2 PAD[0] 11 PA08 SERCOM2 PAD[0] EXT1, EXT2, EXT3 and EDBG
                              I²C SDA                I²C SDA
    ----------------- ---------------------- ---------------------- ------------------------------------
    12 N/C            12 PA09 SERCOM2 PAD[1] 12 PA09 SERCOM2 PAD[1] EXT2, EXT3 and EDBG
                              I²C SCL                I²C SCL
    ----------------- ---------------------- ---------------------- ------------------------------------
    13 N/C            13 PB09 SERCOM4 PAD[1] 13 PA19 SERCOM1 PAD[3] The SERCOM4 module is shared between
                              USART RX               USART RX       EXT1, 2 and 3 USART's, but uses
                                                                    different pins
    ----------------- ---------------------- ---------------------- ------------------------------------
    14 N/C            14 PB08 SERCOM4 PAD[0] 14 PA18 SERCOM1 PAD[2] The SERCOM4 module is shared between
                              USART TX               USART TX       EXT1, 2 and 3 USART's, but uses
                                                                    different pins
    ----------------- ---------------------- ---------------------- ------------------------------------
    15 DISPLAY_SS     15 PA05 SERCOM0 PAD[1] 15 PA17 GPIO
                              SPI SS
    ----------------- ---------------------- ---------------------- ------------------------------------
    16 SPI_MOSI       16 PA06 SERCOM0 PAD[2] 16 PB22 SERCOM5 PAD[2]
                              SPI MOSI               SPI MOSI
    ----------------- ---------------------- ---------------------- ------------------------------------
    17 N/C            17 PA04 SERCOM0 PAD[0] 17 PB16 SERCOM5 PAD[0]
                              SPI MISO               SPI MISO
    ----------------- ---------------------- ---------------------- ------------------------------------
    18 SPI_SCK        18 PA07 SERCOM0 PAD[3] 18 PB23 SERCOM5 PAD[3]
                              SPI SCK                SPI SCK
    ----------------- ---------------------- ---------------------- ------------------------------------
    19 GND            19      GND               GND
    ----------------- ---------------------- ---------------------- ------------------------------------
    20 VCC            20      VCC               VCC
    ----------------- ---------------------- ---------------------- ------------------------------------

    Configuration Options:
    ----------------------
      CONFIG_SAML21_XPLAINED_OLED1MODULE=y      : Informs the system that the
                                                 I/O1 module is installed
      CONFIG_SAML21_XPLAINED_OLED1MODULE_EXT1=y : The module is installed in EXT1
      CONFIG_SAML21_XPLAINED_OLED1MODULE_EXT2=y : The mdoule is installed in EXT2

    See the set-up in the discussion of the nsh configuration below for other
    required configuration options.

  PROTO1
  ---------------------------------------------------------------------------
  A prototyping board with logic on board (other than power-related logic).
  There is no built-in support for the PROTO1 module.

Development Environment
=======================

Either Linux or Cygwin on Windows can be used for the development
environment. The source has been built only using the GNU toolchain (see
below). Other toolchains will likely cause problems. Testing was
performed using the Cygwin environment.

GNU Toolchain Options
=====================

The NuttX make system can be configured to support the various different
toolchain options. All testing has been conducted using the NuttX
buildroot toolchain. To use alternative toolchain, you simply need to
add change of the following configuration options to your .config (or
defconfig) file:

    CONFIG_ARM_TOOLCHAIN_BUILDROOT=y  : NuttX buildroot under Linux or Cygwin (default)
    CONFIG_ARM_TOOLCHAIN_GNU_EABI=y   : Generic GCC ARM EABI toolchain for Linux
    CONFIG_ARM_TOOLCHAIN_GNU_EABI=y   : Generic GCC ARM EABI toolchain for Windows

NOTE about Windows native toolchains
------------------------------------

There are basically three kinds of GCC toolchains that can be used:

    1. A Linux native toolchain in a Linux environment,
    2. The buildroot Cygwin tool chain built in the Cygwin environment,
    3. A Windows native toolchain.

There are several limitations to using a Windows based toolchain (\#3)
in a Cygwin environment. The three biggest are:

1.  The Windows toolchain cannot follow Cygwin paths. Path conversions
    are performed automatically in the Cygwin makefiles using the
    'cygpath' utility but you might easily find some new path problems.
    If so, check out 'cygpath -w'

2.  Windows toolchains cannot follow Cygwin symbolic links. Many
    symbolic links are used in NuttX (e.g., include/arch). The make
    system works around these problems for the Windows tools by copying
    directories instead of linking them. But this can also cause some
    confusion for you: For example, you may edit a file in a "linked"
    directory and find that your changes had no effect. That is because
    you are building the copy of the file in the "fake" symbolic
    directory. If you use a Windows toolchain, you should get in the
    habit of making like this:

    make clean\_context all

    An alias in your .bashrc file might make that less painful.

IDEs
====

NuttX is built using command-line make. It can be used with an IDE, but
some effort will be required to create the project.

  Makefile Build
  -------------------------------------------------------------------------------
  Under Eclipse, it is pretty easy to set up an "empty makefile project" and
  simply use the NuttX makefile to build the system. That is almost for free
  under Linux. Under Windows, you will need to set up the "Cygwin GCC" empty
  makefile project in order to work with Windows (Google for "Eclipse Cygwin" -
  there is a lot of help on the internet).

  Native Build
  ---------------------------------------------------
  Here are a few tips before you start that effort:

1)  Select the toolchain that you will be using in your .config file
2)  Start the NuttX build at least one time from the Cygwin command line
    before trying to create your project. This is necessary to create
    certain auto-generated files and directories that will be needed.
3)  Set up include paths: You will need include/, arch/arm/src/sam34,
    arch/arm/src/common, arch/arm/src/armv7-m, and sched/.
4)  All assembly files need to have the definition option -D
    **ASSEMBLY** on the command line.

Startup files will probably cause you some headaches. The NuttX startup
file is arch/arm/src/sam34/sam\_vectors.S. You may need to build NuttX
one time from the Cygwin command line in order to obtain the pre-built
startup object needed by an IDE.

NuttX EABI "buildroot" Toolchain
================================

A GNU GCC-based toolchain is assumed. The PATH environment variable
should be modified to point to the correct path to the Cortex-M0 GCC
toolchain (if different from the default in your PATH variable).

If you have no Cortex-M0 toolchain, one can be downloaded from the NuttX
Bitbucket download site
(https://bitbucket.org/nuttx/buildroot/downloads/). This GNU toolchain
builds and executes in the Linux or Cygwin environment.

1.  You must have already configured NuttX in `<some-dir>`{=html}/nuttx.

    tools/configure.sh saml21-xplained:`<sub-dir>`{=html}

2.  Download the latest buildroot package into `<some-dir>`{=html}

3.  unpack the buildroot tarball. The resulting directory may have
    versioning information on it like buildroot-x.y.z. If so, rename
    `<some-dir>`{=html}/buildroot-x.y.z to
    `<some-dir>`{=html}/buildroot.

4.  cd `<some-dir>`{=html}/buildroot

5.  cp boards/cortexm0-eabi-defconfig-4.6.3 .config

6.  make oldconfig

7.  make

8.  Make sure that the PATH variable includes the path to the newly
    built binaries.

See the file boards/README.txt in the buildroot source tree. That has
more details PLUS some special instructions that you will need to follow
if you are building a Cortex-M0 toolchain for Cygwin under Windows.

LEDs and Buttons
================

  LED
  -----------------------------------------------------------------------------
  There is one yellow LED available on the SAML21 Xplained Pro board that
  can be turned on and off. The LED can be activated by driving the connected
  PB10 I/O line to GND.

When CONFIG\_ARCH\_LEDS is defined in the NuttX configuration, NuttX
will control the LED as follows:

    SYMBOL              Meaning                 LED0
    ------------------- ----------------------- ------
    LED_STARTED         NuttX has been started  OFF
    LED_HEAPALLOCATE    Heap has been allocated OFF
    LED_IRQSENABLED     Interrupts enabled      OFF
    LED_STACKCREATED    Idle stack created      ON
    LED_INIRQ           In an interrupt         N/C
    LED_SIGNAL          In a signal handler     N/C
    LED_ASSERTION       An assertion failed     N/C
    LED_PANIC           The system has crashed  FLASH

Thus is LED is statically on, NuttX has successfully booted and is,
apparently, running normally. If LED is flashing at approximately 2Hz,
then a fatal error has been detected and the system has halted.

  Button
  --------------------------------------------------------------------------
  SAM L21 Xplained Pro contains one mechanical button on PA02 that can be
  controlled by software. When a button is pressed it will drive the I/O
  line to GND. Note: There is no pull-up resistor connected to the generic
  user button. Remember to enable the internal pull-up in the SAM L21 to
  use the button.

  QTouch Button
  ----------------
  To be provided

Serial Consoles
===============

  SERCOM0
  -------------------------------------------------------------
  SERCOM0 is dedicated for use with SPI at the EXT1 connector

  SERCOM1
  --------------------------------------------------
  SERCOM1 is available as a USART on EXT2 and EXT3

    PIN   EXT1 EXT2 EXT3 GPIO Function
    ----  ---- ---- ---- ------------------
     13   ---  PA19 PA19 SERCOM1 / USART RX
     14   ---  PA18 PA18 SERCOM1 / USART TX
     19   GND  GND  GND  N/A
     20   VCC  VCC  VCC  N/A

  SERCOM2
  -------------------------------------------------------------------
  SERCOM0 is dedicated for use with I2C at the EXT1, EXT2, and EXT3
  connectors.

  SERCOM3
  --------------------------------------------------------------------
  SERCOM3 is not available on any EXT connector but is dedicated for
  use with Virtual COM (see below).

  SERCOM4
  -----------------------------------------
  SERCOM1 is available as a USART on EXT1

    PIN   EXT1 EXT2 EXT3 GPIO Function
    ----  ---- ---- ---- ------------------
     13   PB09 ---  ---  SERCOM4 / USART RX
     14   PB08 ---  ---  SERCOM4 / USART TX
     19   GND  GND  GND  N/A
     20   VCC  VCC  VCC  N/A

SERCOM5 -------

SERCOM5 is dedicated for use with SPI at the EXT2 and EXT3 connectors

  Configuration
  ------------------------------------------------------------------------------
  There are options available in the NuttX configuration to select which
  connector SERCOM4 is on: SAML21\_XPLAINED\_USART4\_EXTn, where n=1, 2, or 3.

If you have a TTL to RS-232 converter then this is the most convenient
serial console to use (because you don't lose the console device each
time you lose the USB connection). It is the default in all of these
configurations. An option is to use the virtual COM port.

Virtual COM Port ----------------

The SAML21 Xplained Pro contains an Embedded Debugger (EDBG) that can be
used to program and debug the ATSAML21J18A using Serial Wire Debug
(SWD). The Embedded debugger also include a Virtual COM port interface
over SERCOM3. Virtual COM port connections:

    PA22 SERCOM3 / USART TXD
    PA23 SERCOM3 / USART RXD

Atmel Studio 6.1
================

NOTE: These instructions are old. The SAML21 requires Atmel Studio 6.2.
They may still prove useful to you, however.

Loading Code into FLASH: -----------------------

Tools menus: Tools -\> Device Programming.

Debugging the NuttX Object File -------------------------------

1)  Rename object file from nutt to nuttx.elf. That is an extension that
    will be recognized by the file menu.

2)  File menu: File -\> Open -\> Open object file for debugging

    -   Select nuttx.elf object file
    -   Select AT91SAML21J18
    -   Select files for symbols as desired
    -   Select debugger

3)  Debug menu: Debug -\> Start debugging and break

    -   This will reload the nuttx.elf file into FLASH

JTAG
====

I did all of the debug of the SAML21 Xplained using a Segger J-Link
connected to the micro JTAG connector on board the SAML21 Xplained. I
used an Olimex ARM-JTAG 20-10 Adapter to connect the J-Link to the
SAML21 Xplained.

SAML21 Xplained Pro-specific Configuration Options
==================================================

    CONFIG_ARCH - Identifies the arch/ subdirectory.  This should
       be set to:

       CONFIG_ARCH=arm

    CONFIG_ARCH_family - For use in C code:

       CONFIG_ARCH_ARM=y

    CONFIG_ARCH_architecture - For use in C code:

       CONFIG_ARCH_CORTEXM0=y

    CONFIG_ARCH_CHIP - Identifies the arch/*/chip subdirectory

       CONFIG_ARCH_CHIP="samd2l2"

    CONFIG_ARCH_CHIP_name - For use in C code to identify the exact
       chip:

       CONFIG_ARCH_CHIP_SAML2X
       CONFIG_ARCH_CHIP_SAML21
       CONFIG_ARCH_CHIP_ATSAML21J18

    CONFIG_ARCH_BOARD - Identifies the boards/ subdirectory and
       hence, the board that supports the particular chip or SoC.

       CONFIG_ARCH_BOARD="saml21-xplained" (for the SAML21 Xplained Pro development board)

    CONFIG_ARCH_BOARD_name - For use in C code

       CONFIG_ARCH_BOARD_SAML21_XPLAINED=y

    CONFIG_ARCH_LOOPSPERMSEC - Must be calibrated for correct operation
       of delay loops

    CONFIG_ENDIAN_BIG - define if big endian (default is little
       endian)

    CONFIG_RAM_SIZE - Describes the installed DRAM (SRAM in this case):

       CONFIG_RAM_SIZE=0x00010000 (64KB)

    CONFIG_RAM_START - The start address of installed DRAM

       CONFIG_RAM_START=0x20000000

    CONFIG_ARCH_LEDS - Use LEDs to show state. Unique to boards that
       have LEDs

    CONFIG_ARCH_INTERRUPTSTACK - This architecture supports an interrupt
       stack. If defined, this symbol is the size of the interrupt
        stack in bytes.  If not defined, the user task stacks will be
      used during interrupt handling.

    CONFIG_ARCH_STACKDUMP - Do stack dumps after assertions

    CONFIG_ARCH_LEDS -  Use LEDs to show state. Unique to board architecture.

Individual subsystems can be enabled:

    CONFIG_SAMD2L2_AC      - Analog Comparator
    CONFIG_SAMD2L2_ADC     - Analog-to-Digital Converter
    CONFIG_SAMD2L2_DAC     - Digital-to-Analog Converter
    CONFIG_SAMD2L2_DMAC    - Analog Comparator
    CONFIG_SAMD2L2_EVSYS   - Event System
    CONFIG_SAMD2L2_NVMCTRL - Non-Volatile Memory Controller
    CONFIG_SAMD2L2_PTC     - Peripheral Touch Controller
    CONFIG_SAMD2L2_RTC     - Real Time Counter
    CONFIG_SAMD2L2_SERCOM0 - Serial Communication Interface 0
    CONFIG_SAMD2L2_SERCOM1 - Serial Communication Interface 1
    CONFIG_SAMD2L2_SERCOM2 - Serial Communication Interface 2
    CONFIG_SAMD2L2_SERCOM3 - Serial Communication Interface 3
    CONFIG_SAMD2L2_SERCOM4 - Serial Communication Interface 4
    CONFIG_SAMD2L2_SERCOM5 - Serial Communication Interface 5
    CONFIG_SAMD2L2_TCC0    - Timer/Counter 0 for Control
    CONFIG_SAMD2L2_TCC1    - Timer/Counter 1 for Control
    CONFIG_SAMD2L2_TCC2    - Timer/Counter 2 for Control
    CONFIG_SAMD2L2_TC3     - Timer/Counter 3
    CONFIG_SAMD2L2_TC4     - Timer/Counter 4
    CONFIG_SAMD2L2_TC5     - Timer/Counter 5
    CONFIG_SAMD2L2_TC6     - Timer/Counter 6
    CONFIG_SAMD2L2_TC7     - Timer/Counter 6
    CONFIG_SAMD2L2_USB     - USB device or host
    CONFIG_SAMD2L2_WDT     - Watchdog Timer

Some subsystems can be configured to operate in different ways. The
drivers need to know how to configure the subsystem.

    CONFIG_SAMD2L2_SERCOM0_ISI2C, CONFIG_SAMD2L2_SERCOM0_ISSPI, or CONFIG_SAMD2L2_SERCOM0_ISUSART
    CONFIG_SAMD2L2_SERCOM1_ISI2C, CONFIG_SAMD2L2_SERCOM1_ISSPI, or CONFIG_SAMD2L2_SERCOM1_ISUSART
    CONFIG_SAMD2L2_SERCOM2_ISI2C, CONFIG_SAMD2L2_SERCOM2_ISSPI, or CONFIG_SAMD2L2_SERCOM2_ISUSART
    CONFIG_SAMD2L2_SERCOM3_ISI2C, CONFIG_SAMD2L2_SERCOM3_ISSPI, or CONFIG_SAMD2L2_SERCOM3_ISUSART
    CONFIG_SAMD2L2_SERCOM4_ISI2C, CONFIG_SAMD2L2_SERCOM4_ISSPI, or CONFIG_SAMD2L2_SERCOM4_ISUSART
    CONFIG_SAMD2L2_SERCOM5_ISI2C, CONFIG_SAMD2L2_SERCOM5_ISSPI, or CONFIG_SAMD2L2_SERCOM5_ISUSART

SAML21 specific device driver settings

    CONFIG_USARTn_SERIAL_CONSOLE - selects the USARTn (n=0,1,2,..5) for the
      console and ttys0 (default is the USART4).
    CONFIG_USARTn_RXBUFSIZE - Characters are buffered as received.
       This specific the size of the receive buffer
    CONFIG_USARTn_TXBUFSIZE - Characters are buffered before
       being sent.  This specific the size of the transmit buffer
    CONFIG_USARTn_BAUD - The configure BAUD of the USART.  Must be
    CONFIG_USARTn_BITS - The number of bits.  Must be either 7 or 8.
    CONFIG_USARTn_PARTIY - 0=no parity, 1=odd parity, 2=even parity
    CONFIG_USARTn_2STOP - Two stop bits

Configurations
==============

Each SAML21 Xplained Pro configuration is maintained in a sub-directory
and can be selected as follow:

    tools/configure.sh saml21-xplained:<subdir>

Before building, make sure that the PATH environmental variable includes
the correct path to the directory than holds your toolchain binaries.

And then build NuttX by simply typing the following. At the conclusion
of the make, the nuttx binary will reside in an ELF file called, simply,
nuttx.

    make

The `<subdir>`{=html} that is provided above as an argument to the
tools/configure.sh must be is one of the following.

NOTE: These configurations use the mconf-based configuration tool. To
change any of these configurations using that tool, you should:

    a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
       see additional README.txt files in the NuttX tools repository.

    b. Execute 'make menuconfig' in nuttx/ in order to start the
       reconfiguration process.

NOTES:

1.  These configurations use the mconf-based configuration tool. To
    change any of these configurations using that tool, you should:

```{=html}
<!-- -->
```
    a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
       see additional README.txt files in the NuttX tools repository.

    b. Execute 'make menuconfig' in nuttx/ in order to start the
       reconfiguration process.

2.  Unless stated otherwise, all configurations generate console output
    of on SERCOM4 which is available on EXT1 (see the section "Serial
    Consoles" above). The SERCOM1 on EXT2 or EXT3 or the virtual COM
    port on SERCOME could be used, instead, by reconfiguring to use
    SERCOM1 or SERCOM3 instead of SERCOM4:

    System Type -\> SAMD/L Peripheral Support CONFIG\_SAMD2L2\_SERCOM1=y
    : Enable one or both CONFIG\_SAMD2L2\_SERCOM3=y
    CONFIG\_SAMD2L2\_SERCOM4=n

    Device Drivers -\> Serial Driver Support -\> Serial Console
    CONFIG\_USART1\_SERIAL\_CONSOLE=y : Select only one for the console
    CONFIG\_USART3\_SERIAL\_CONSOLE=y : Select only one for the console
    CONFIG\_USART4\_SERIAL\_CONSOLE=n

    Device Drivers -\> Serial Driver Support -\> SERCOMn Configuration
    where n=1 or 3:

        CONFIG_USARTn_2STOP=0
        CONFIG_USARTn_BAUD=115200
        CONFIG_USARTn_BITS=8
        CONFIG_USARTn_PARITY=0
        CONFIG_USARTn_RXBUFSIZE=256
        CONFIG_USARTn_TXBUFSIZE=256

3.  Unless otherwise stated, the configurations are setup for Cygwin
    under Windows:

    Build Setup: CONFIG\_HOST\_WINDOWS=y : Windows Host
    CONFIG\_WINDOWS\_CYGWIN=y : Cygwin environment on windows

4.  These configurations use the ARM EABI toolchain. But that is easily
    reconfigured:

    System Type -\> Toolchain: CONFIG\_ARM\_TOOLCHAIN\_GNU\_EABI=y

    Any re-configuration should be done before making NuttX or else the
    subsequent 'make' will fail. If you have already attempted building
    NuttX then you will have to 1) 'make distclean' to remove the old
    configuration, 2) 'tools/configure.sh sam3u-ek/ksnh' to start with a
    fresh configuration, and 3) perform the configuration changes above.

    Also, make sure that your PATH variable has the new path to your
    Atmel tools. Try 'which arm-none-eabi-gcc' to make sure that you are
    selecting the right tool.

    See also the "NOTE about Windows native toolchains" in the section
    called "GNU Toolchain Options" above.

Configuration sub-directories
-----------------------------

nsh: This configuration directory will built the NuttShell. See NOTES
above and below:

    NOTES:

    1. This configuration is set up to build on Windows using the Cygwin
       environment using the ARM EABI toolchain.  This can be easily
       changed as described above under "Configurations."

    2. By default, this configuration provides a serial console on SERCOM4
       at 115200 8N1 via EXT1:

       PIN   EXT1 GPIO Function
       ----  ---- ------------------
        13   PB09 SERCOM4 / USART RX
        14   PB08 SERCOM4 / USART TX
        19   GND  N/A
        20   VCC  N/A

       If you would prefer to use the EDBG serial COM port or would prefer
       to use SERCOM4 on EXT1 or EXT2, you will need to reconfigure the
       SERCOM as described under "Configurations".  See also the section
       entitled "Serial Consoles" above.

    3. NOTE: If you get a compilation error like:

         libxx_new.cxx:74:40: error: 'operator new' takes type 'size_t'
                              ('unsigned int') as first parameter [-fper

       Sometimes NuttX and your toolchain will disagree on the underlying
       type of size_t; sometimes it is an 'unsigned int' and sometimes it is
       an 'unsigned long int'.  If this error occurs, then you may need to
       toggle the value of CONFIG_ARCH_SIZET_LONG.

    4. WARNING: This info comes from the SAMD20 Xplained README.  I have
       not tried the I/O1 module on the SAML21!

       If the I/O1 module is connected to the SAML21 Xplained Pro, then
       support for the SD card slot can be enabled by making the following
       changes to the configuration.  These changes assume that the I/O1
       modules is connected in EXT1.  Most of the modifications necessary
       to work with the I/O1 in a different connector are obvious.. except
       for the selection of SERCOM SPI support:

         EXT1: SPI is provided through SERCOM0
         EXT2: SPI is provided through SERCOM1
         EXT3: SPI is provided through SERCOM5

       File Systems:
         CONFIG_FS_FAT=y                   : Enable the FAT file system
         CONFIG_FAT_LCNAMES=y              : Enable upper/lower case 8.3 file names (Optional, see below)
         CONFIG_FAT_LFN=y                  : Enable long file named (Optional, see below)
         CONFIG_FAT_MAXFNAME=32            : Maximum supported file name length

         There are issues related to patents that Microsoft holds on FAT long
         file name technologies.  See the top level NOTICE file for further
         details.

       System Type -> Peripherals:
         CONFIG_SAMD2L2_SERCOM0=y          : Use SERCOM0 if the I/O is in EXT1
         CONFIG_SAMD2L2_SERCOM0_ISSPI=y    : Configure SERCOM0 as an SPI master

       Device Drivers
         CONFIG_SPI=y                      : Enable SPI support
         CONFIG_SPI_EXCHANGE=y             : The exchange() method is supported

         CONFIG_MMCSD=y                    : Enable MMC/SD support
         CONFIG_MMCSD_NSLOTS=1             : Only one MMC/SD card slot
         CONFIG_MMCSD_MULTIBLOCK_LIMIT=0   : Should not need to disable multi-block transfers
         CONFIG_MMCSD_MMCSUPPORT=n         : May interfere with some SD cards
         CONFIG_MMCSD_HAVE_CARDDETECT=y    : I/O1 module as a card detect GPIO
         CONFIG_MMCSD_SPI=y                : Use the SPI interface to the MMC/SD card
         CONFIG_MMCSD_SPICLOCK=20000000    : This is a guess for the optimal MMC/SD frequency
         CONFIG_MMCSD_SPIMODE=0            : Mode 0 is required

       Board Selection -> Common Board Options
         CONFIG_NSH_MMCSDSLOTNO=0          : Only one MMC/SD slot, slot 0
         CONFIG_NSH_MMCSDSPIPORTNO=0       : Use port=0 -> SERCOM0 if the I/O1 is in EXT1

       Board Selection -> SAML21 Xplained Pro Modules
         CONFIG_SAML21_XPLAINED_IOMODULE=y      : I/O1 module is connected
         CONFIG_SAML21_XPLAINED_IOMODULE_EXT2=y : I/O1 modules is in EXT2

       Application Configuration -> NSH Library
         CONFIG_NSH_ARCHINIT=y             : Board has architecture-specific initialization

       NOTE: If you enable the I/O1 this configuration with SERCOM4 as the
       console and with the I/O1 module in EXT1, you *must* remove USART
       jumper.  Otherwise, you have lookback on SERCOM4 and NSH will *not*
       behave very well (since its outgoing prompts also appear as incoming
       commands).

       STATUS:  As of 2013-6-18, this configuration appears completely
       functional.  Testing, however, has been very light.  Example:

         NuttShell (NSH) NuttX-6.34
         nsh> mount -t vfat /dev/mmcsd0 /mnt/stuff
         nsh> ls /mnt/stuff
         /mnt/stuff:
         nsh> echo "This is a test" >/mnt/stuff/atest.txt
         nsh> ls /mnt/stuff
         /mnt/stuff:
          atest.txt
         nsh> cat /mnt/stuff/atest.txt
         This is a test
         nsh>

    5. WARNING: This info comes from the SAMD20 Xplained README.  I have
       not tried the OLED1 module on the SAML21!

    5. If the OLED1 module is connected to the SAML21 Xplained Pro, then
       support for the OLED display can be enabled by making the following
       changes to the configuration.  These changes assume that the I/O1
       modules is connected in EXT1.  Most of the modifications necessary
       to work with the I/O1 in a different connector are obvious.. except
       for the selection of SERCOM SPI support:

         EXT1: SPI is provided through SERCOM0
         EXT2: SPI is provided through SERCOM1
         EXT3: SPI is provided through SERCOM5

       System Type -> Peripherals:
         CONFIG_SAMD2L2_SERCOM1=y           : Use SERCOM1 if the I/O is in EXT2
         CONFIG_SAMD2L2_SERCOM1_ISSPI=y     : Configure SERCOM1 as an SPI master

       Device Drivers -> SPI
         CONFIG_SPI=y                       : Enable SPI support
         CONFIG_SPI_EXCHANGE=y              : The exchange() method is supported
         CONFIG_SPI_CMDDATA=y               : CMD/DATA support is required

       Device Drivers -> LCDs
         CONFIG_LCD=y                       : Enable LCD support
         CONFIG_LCD_MAXCONTRAST=255         : Maximum contrast value
         CONFIG_LCD_LANDSCAPE=y             : Landscape orientation (see below*)
         CONFIG_LCD_UG2832HSWEG04=y         : Enable support for the OLED
         CONFIG_LCD_SSD1306_SPIMODE=0       : SPI Mode 0
         CONFIG_LCD_SSD1306_SPIMODE=3500000 : Pick an SPI frequency

       Board Selection -> SAML21 Xplained Pro Modules
         CONFIG_SAML21_XPLAINED_OLED1MODULE=y      : OLED1 module is connected
         CONFIG_SAML21_XPLAINED_OLED1MODULE_EXT2=y : OLED1 modules is in EXT2

       The NX graphics subsystem also needs to be configured:

         CONFIG_NX=y                        : Enable graphics support
         CONFIG_NX_LCDDRIVER=y              : Using an LCD driver
         CONFIG_NX_NPLANES=1                : With a single color plane
         CONFIG_NX_WRITEONLY=n              : You can read from the LCD (see below*)
         CONFIG_NX_DISABLE_2BPP=y           : Disable all resolutions except 1BPP
         CONFIG_NX_DISABLE_4BPP=y
         CONFIG_NX_DISABLE_8BPP=y
         CONFIG_NX_DISABLE_16BPP=y
         CONFIG_NX_DISABLE_24BPP=y
         CONFIG_NX_DISABLE_32BPP=y
         CONFIG_NX_PACKEDMSFIRST=y          : LSB packed first (shouldn't matter)
         CONFIG_NXSTART_EXTERNINIT=y        : We have board_graphics_setup()
         CONFIG_NXTK_BORDERWIDTH=2          : Use a small border
         CONFIG_NXTK_DEFAULT_BORDERCOLORS=y : Default border colors
         CONFIG_NXFONTS_CHARBITS=7          : 7-bit fonts
         CONFIG_NXFONT_SANS17X23B=y         : Pick a font (any that will fit)

        * The hardware is write only, but the driver maintains a frame buffer
          to support read and read-write-modiry operations on the LCD.
          Reading from the frame buffer is, however, untested.

       Then, in order to use the OLED, you will need to build some kind of
       graphics application or use one of the NuttX graphics examples.
       Here, for example, is the setup for the graphic "Hello, World!"
       example:

         CONFIG_EXAMPLES_NXHELLO=y                : Enables the example
         CONFIG_EXAMPLES_NXHELLO_DEFAULT_COLORS=y : Use default colors (see below *)
         CONFIG_EXAMPLES_NXHELLO_DEFAULT_FONT=y   : Use the default font
         CONFIG_EXAMPLES_NXHELLO_BPP=1            : One bit per pixel
         CONFIG_EXAMPLES_NXHELLO_EXTERNINIT=y     : Special initialization is required.

        * The OLED is monochrome so the only "colors" are black and white.
          The default "colors" will give you while text on a black background.
          You can override the faults it you want black text on a while background.
