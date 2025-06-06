ST Nucleo L476RG
================

chip:stm32, chip:stm32l4, chip:stm32l476

This page discusses issues unique to NuttX configurations for the ST
NucleoL476RG board from ST Micro. See

> <http://www.st.com/nucleo-l476rg>

NucleoL476RG:

-   Microprocessor: 32-bit ARM Cortex M4 at 80MHz STM32L476RGT6
-   Memory: 1024 KB Flash and 96+32 KB SRAM
-   ADC: 2×12-bit, 2.4 MSPS A/D converter: up to 24 channels
-   DMA: 16-stream DMA controllers with FIFOs and burst support
-   Timers: Up to 11 timers: up to eight 16-bit, two 32-bit timers, two
    watchdog timers, and a SysTick timer
-   GPIO: Up to 51 I/O ports with interrupt capability
-   I2C: Up to 3 × I2C interfaces
-   USARTs: Up to 3 USARTs, 2 UARTs, 1 LPUART
-   SPIs: Up to 3 SPIs
-   SAIs: Up to 2 dual-channel audio interfaces
-   CAN interface
-   SDIO interface
-   QSPI interface
-   USB: USB 2.0 full-speed device/host/OTG controller with on-chip PHY
-   CRC calculation unit
-   RTC

Board features:

-   Peripherals: 1 led, 1 push button
-   Debug: Serial wire debug and JTAG interfaces
-   Expansion I/F Ardino and Morpho Headers

Uses a STM32F103 to provide a ST-Link for programming, debug similar to
the OpenOcd FTDI function - USB to JTAG front-end.

See <http://mbed.org/platforms/ST-Nucleo-L476RG> for more information
about these boards.

Development Environment
-----------------------

Either Linux or Cygwin on Windows can be used for the development
environment. The source has been built only using the GNU toolchain (see
below). Other toolchains will likely cause problems.

GNU Toolchain Options
---------------------

### Toolchain Configurations

The NuttX make system has been modified to support the following
different toolchain options.

1.  The NuttX buildroot Toolchain (see below), or
2.  Any generic arm-none-eabi GNU toolchain.

All testing has been conducted using the NuttX Codesourcery toolchain.
To use a different toolchain, you simply need to modify the
configuration. As an example:

    CONFIG_ARM_TOOLCHAIN_GNU_EABI : Generic arm-none-eabi toolchain

IDEs
----

NuttX is built using command-line make. It can be used with an IDE, but
some effort will be required to create the project.

### Makefile Build

Under Eclipse, it is pretty easy to set up an \"empty makefile project\"
and simply use the NuttX makefile to build the system. That is almost
for free under Linux. Under Windows, you will need to set up the
\"Cygwin GCC\" empty makefile project in order to work with Windows
(Google for \"Eclipse Cygwin\" -there is a lot of help on the internet).

Using Sourcery CodeBench from
<http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/overview>
Download and install the latest version (as of this writing it was
sourceryg++-2013.05-64-arm-none-eabi)

Import the project from git. File-\>import-\>Git-URI, then import a
Exiting code as a Makefile progject from the working directory the git
clone was done to.

Select the Sourcery CodeBench for ARM EABI. N.B. You must do one command
line build, before the make will work in CodeBench.

### Native Build

Here are a few tips before you start that effort:

1)  Select the toolchain that you will be using in your .config file
2)  Start the NuttX build at least one time from the Cygwin command line
    before trying to create your project. This is necessary to create
    certain auto-generated files and directories that will be needed.
3)  Set up include paths: You will need include/, arch/arm/src/stm32,
    arch/arm/src/common, arch/arm/src/armv7-m, and sched/.
4)  All assembly files need to have the definition option -D
    \_\_ASSEMBLY\_\_ on the command line.

Startup files will probably cause you some headaches. The NuttX startup
file is arch/arm/src/stm32/stm32\_vectors.S. With RIDE, I have to build
NuttX one time from the Cygwin command line in order to obtain the
pre-built startup object needed by RIDE.

NuttX EABI \"buildroot\" Toolchain
----------------------------------

A GNU GCC-based toolchain is assumed. The PATH environment variable
should be modified to point to the correct path to the Cortex-M3 GCC
toolchain (if different from the default in your PATH variable).

If you have no Cortex-M3 toolchain, one can be downloaded from the NuttX
Bitbucket download site
(<https://bitbucket.org/nuttx/buildroot/downloads/>). This GNU toolchain
builds and executes in the Linux or Cygwin environment.

1.  You must have already configured NuttX in \<some-dir\>/nuttx.:

         tools/configure.sh nucleo-l476rg:nsh
         make qconfig
         V=1 make context all 2>&1 | tee mout

2.  Download the latest buildroot package into \<some-dir\>

3.  unpack the buildroot tarball. The resulting directory may have
    versioning information on it like buildroot-x.y.z. If so, rename
    \<some-dir\>/buildroot-x.y.z to \<some-dir\>/buildroot.

4.  cd \<some-dir\>/buildroot

5.  cp boards/cortexm3-eabi-defconfig-4.6.3 .config

6.  make oldconfig

7.  make

8.  Make sure that the PATH variable includes the path to the newly
    built binaries.

See the file boards/README.txt in the buildroot source tree. That has
more details PLUS some special instructions that you will need to follow
if you are building a Cortex-M3 toolchain for Cygwin under Windows.

NOTE: Unfortunately, the 4.6.3 EABI toolchain is not compatible with the
the NXFLAT tools. See the top-level TODO file (under \"Binary loaders\")
for more information about this problem. If you plan to use NXFLAT,
please do not use the GCC 4.6.3 EABI toolchain; instead use the GCC
4.3.3 EABI toolchain.

NXFLAT Toolchain
----------------

If you are *not* using the NuttX buildroot toolchain and you want to use
the NXFLAT tools, then you will still have to build a portion of the
buildroot tools \-- just the NXFLAT tools. The buildroot with the NXFLAT
tools can be downloaded from the NuttX Bitbucket download site
(<https://bitbucket.org/nuttx/nuttx/downloads/>).

This GNU toolchain builds and executes in the Linux or Cygwin
environment.

1.  You must have already configured NuttX in \<some-dir\>/nuttx.

    > tools/configure.sh lpcxpresso-lpc1768:\<sub-dir\>

2.  Download the latest buildroot package into \<some-dir\>

3.  unpack the buildroot tarball. The resulting directory may have
    versioning information on it like buildroot-x.y.z. If so, rename
    \<some-dir\>/buildroot-x.y.z to \<some-dir\>/buildroot.

4.  cd \<some-dir\>/buildroot

5.  cp boards/cortexm3-defconfig-nxflat .config

6.  make oldconfig

7.  make

8.  Make sure that the PATH variable includes the path to the newly
    built NXFLAT binaries.

mbed
----

The Nucleo-L476RG includes boot loader from mbed:

> <https://mbed.org/platforms/ST-Nucleo-L476RG/>
> <https://mbed.org/handbook/Homepage>

Using the mbed loader:

1.  Connect the Nucleo-F4x1RE to the host PC using the USB connector.
2.  A new file system will appear called NUCLEO; open it with Windows
    Explorer (assuming that you are using Windows).
3.  Drag and drop nuttx.bin into the MBED window. This will load the
    nuttx.bin binary into the Nucleo-F4x1RE. The NUCLEO window will
    close then re-open and the Nucleo-F4x1RE will be running the new
    code.

Hardware
--------

### GPIO

    SERIAL_TX=PA_2    USER_BUTTON=PC_13
    SERIAL_RX=PA_3    LED1       =PA_5

    A0=PA_0  USART2RX D0=PA_3            D8 =PA_9
    A1=PA_1  USART2TX D1=PA_2            D9 =PC_7
    A2=PA_4           D2=PA_10   WIFI_CS=D10=PB_6 SPI_CS
    A3=PB_0  WIFI_INT=D3=PB_3            D11=PA_7 SPI_MOSI
    A4=PC_1      SDCS=D4=PB_5            D12=PA_6 SPI_MISO
    A5=PC_0   WIFI_EN=D5=PB_4       LED1=D13=PA_5 SPI_SCK
                 LED2=D6=PB_10  I2C1_SDA=D14=PB_9 Probe
                      D7=PA_8   I2C1_SCL=D15=PB_8 Probe

    From: https://mbed.org/platforms/ST-Nucleo-L476RG/

### Buttons

B1 USER: the user button is connected to the I/O PC13 (pin 2) of the
STM32 microcontroller.

### LEDs

The Nucleo L476RG provides a single user LED, LD2. LD2 is the green LED
connected to Arduino signal D13 corresponding to MCU I/O PA5 (pin 21) or
PB13 (pin 34) depending on the STM32target.

-   When the I/O is HIGH value, the LED is on.
-   When the I/O is LOW, the LED is off.

These LEDs are not used by the board port unless CONFIG\_ARCH\_LEDS is
defined. In that case, the usage by the board port is defined in
include/board.h and src/sam\_leds.c. The LEDs are used to encode
OS-related events as follows when the red LED (PE24) is available:

> +-------------------+-------------------------+-------------+
> | SYMBOL            | Meaning                 | LD2         |
> +===================+=========================+=============+
> | LED\_STARTED      | NuttX has been started  | > OFF       |
> +-------------------+-------------------------+-------------+
> | LED\_HEAPALLOCATE | Heap has been allocated | > OFF       |
> +-------------------+-------------------------+-------------+
> | LED\_IRQSENABLED  | Interrupts enabled      | > OFF       |
> +-------------------+-------------------------+-------------+
> | LED\_STACKCREATED | Idle stack created      | > ON        |
> +-------------------+-------------------------+-------------+
> | LED\_INIRQ        | In an interrupt         | > No change |
> +-------------------+-------------------------+-------------+
> | LED\_SIGNAL       | In a signal handler     | > No change |
> +-------------------+-------------------------+-------------+
> | LED\_ASSERTION    | An assertion failed     | > No change |
> +-------------------+-------------------------+-------------+
> | LED\_PANIC        | The system has crashed  | > Blinking  |
> +-------------------+-------------------------+-------------+
> | LED\_IDLE         | MCU is is sleep mode    | > Not used  |
> +-------------------+-------------------------+-------------+

Thus if LD2, NuttX has successfully booted and is, apparently, running
normally. If LD2 is flashing at approximately 2Hz, then a fatal error
has been detected and the system has halted.

Serial Consoles
---------------

### USART1

Pins and Connectors:

    RXD: PA11  CN10 pin 14
         PB7   CN7 pin 21
    TXD: PA10  CN9 pin 3, CN10 pin 33
         PB6   CN5 pin 3, CN10 pin 17

NOTE: You may need to edit the include/board.h to select different
USART1 pin selections.

TTL to RS-232 converter connection:

    Nucleo CN10 STM32F4x1RE
    ----------- ------------
    Pin 21 PA9  USART1_RX   *Warning you make need to reverse RX/TX on
    Pin 33 PA10 USART1_TX    some RS-232 converters
    Pin 20 GND
    Pin 8  U5V

To configure USART1 as the console:

    CONFIG_STM32_USART1=y
    CONFIG_USART1_SERIALDRIVER=y
    CONFIG_USART1_SERIAL_CONSOLE=y
    CONFIG_USART1_RXBUFSIZE=256
    CONFIG_USART1_TXBUFSIZE=256
    CONFIG_USART1_BAUD=115200
    CONFIG_USART1_BITS=8
    CONFIG_USART1_PARITY=0
    CONFIG_USART1_2STOP=0

### USART2

Pins and Connectors:

    RXD: PA3   CN9 pin 1 (See SB13, 14, 62, 63). CN10 pin 37
         PD6
    TXD: PA2   CN9 pin 2(See SB13, 14, 62, 63). CN10 pin 35
         PD5

UART2 is the default in all of these configurations.

TTL to RS-232 converter connection:

    Nucleo CN9  STM32F4x1RE
    ----------- ------------
    Pin 1  PA3  USART2_RX   *Warning you make need to reverse RX/TX on
    Pin 2  PA2  USART2_TX    some RS-232 converters

Solder Bridges. This configuration requires:

-   SB62 and SB63 Closed: PA2 and PA3 on STM32 MCU are connected to D1
    and D0 (pin 7 and pin 8) on Arduino connector CN9 and ST Morpho
    connector CN10 as USART signals. Thus SB13 and SB14 should be OFF.
-   SB13 and SB14 Open: PA2 and PA3 on STM32F103C8T6 (ST-LINK MCU) are
    disconnected to PA3 and PA2 on STM32 MCU.

To configure USART2 as the console:

    CONFIG_STM32_USART2=y
    CONFIG_USART2_SERIALDRIVER=y
    CONFIG_USART2_SERIAL_CONSOLE=y
    CONFIG_USART2_RXBUFSIZE=256
    CONFIG_USART2_TXBUFSIZE=256
    CONFIG_USART2_BAUD=115200
    CONFIG_USART2_BITS=8
    CONFIG_USART2_PARITY=0
    CONFIG_USART2_2STOP=0

### USART6

Pins and Connectors:

    RXD: PC7    CN5 pin2, CN10 pin 19
         PA12   CN10, pin 12
    TXD: PC6    CN10, pin 4
         PA11   CN10, pin 14

To configure USART6 as the console:

    CONFIG_STM32_USART6=y
    CONFIG_USART6_SERIALDRIVER=y
    CONFIG_USART6_SERIAL_CONSOLE=y
    CONFIG_USART6_RXBUFSIZE=256
    CONFIG_USART6_TXBUFSIZE=256
    CONFIG_USART6_BAUD=115200
    CONFIG_USART6_BITS=8
    CONFIG_USART6_PARITY=0
    CONFIG_USART6_2STOP=0

### Virtual COM Port

Yet another option is to use UART2 and the USB virtual COM port. This
option may be more convenient for long term development, but is painful
to use during board bring-up.

Solder Bridges. This configuration requires:

-   SB62 and SB63 Open: PA2 and PA3 on STM32 MCU are disconnected to D1
    and D0 (pin 7 and pin 8) on Arduino connector CN9 and ST Morpho
    connector CN10.
-   SB13 and SB14 Closed: PA2 and PA3 on STM32F103C8T6 (ST-LINK MCU) are
    connected to PA3 and PA2 on STM32 MCU to have USART communication
    between them. Thus SB61, SB62 and SB63 should be OFF.

Configuring USART2 is the same as given above.

Question: What BAUD should be configure to interface with the Virtual
COM port? 115200 8N1?

### Default

As shipped, SB62 and SB63 are open and SB13 and SB14 closed, so the
virtual COM port is enabled.

Shields
-------

### RS-232 from Cutedigi.com

Supports a single RS-232 connected via

>   Nucleo CN9   STM32F4x1RE   Cutedigi
>   ------------ ------------- ----------
>   Pin 1 PA3    USART2\_RX    RXD
>   Pin 2 PA2    USART2\_TX    TXD

Support for this shield is enabled by selecting USART2 and configuring
SB13, 14, 62, and 63 as described above under \"Serial Consoles\"

### Itead Joystick Shield

See <http://imall.iteadstudio.com/im120417014.html> for more information
about this joystick.

Itead Joystick Connection:

> +-----------+-------------------+-----------------------------------+
> | ARDUINO   | ITEAD             | NUCLEO=F4x1                       |
> +-----------+-------------------+-----------------------------------+
> | PIN NAME  | SIGNAL            | SIGNAL                            |
> +-----------+-------------------+-----------------------------------+
> | ========= | ================= | ================================= |
> +-----------+-------------------+-----------------------------------+
> | > D3      | Button E Output   | PB3                               |
> +-----------+-------------------+-----------------------------------+
> | > D4      | Button D Output   | PB5                               |
> +-----------+-------------------+-----------------------------------+
> | > D5      | Button C Output   | PB4                               |
> +-----------+-------------------+-----------------------------------+
> | > D6      | Button B Output   | PB10                              |
> +-----------+-------------------+-----------------------------------+
> | > D7      | Button A Output   | PA8                               |
> +-----------+-------------------+-----------------------------------+
> | > D8      | Button F Output   | PA9                               |
> +-----------+-------------------+-----------------------------------+
> | > D9      | Button G Output   | PC7                               |
> +-----------+-------------------+-----------------------------------+
> | > A0      | Joystick Y Output | PA0 ADC1\_0                       |
> +-----------+-------------------+-----------------------------------+
> | > A1      | Joystick X Output | PA1 ADC1\_1                       |
> +-----------+-------------------+-----------------------------------+

All buttons are pulled on the shield. A sensed low value indicates when
the button is pressed.

NOTE: Button F cannot be used with the default USART1 configuration
because PA9 is configured for USART1\_RX by default. Use select
different USART1 pins in the board.h file or select a different USART or
select CONFIG\_NUCLEO\_L476RG\_AJOY\_MINBUTTONS which will eliminate all
but buttons A, B, and C.

Itead Joystick Signal interpretation:

>   BUTTON     TYPE                     NUTTX ALIAS
>   ---------- ------------------------ -----------------
>   Button A   Large button A           JUMP/BUTTON 3
>   Button B   Large button B           FIRE/BUTTON 2
>   Button C   Joystick select button   SELECT/BUTTON 1
>   Button D   Tiny Button D            BUTTON 6
>   Button E   Tiny Button E            BUTTON 7
>   Button F   Large Button F           BUTTON 4
>   Button G   Large Button G           BUTTON 5

Itead Joystick configuration settings:

    System Type -> STM32 Peripheral Support
      CONFIG_STM32_ADC1=y              : Enable ADC1 driver support

    Drivers
      CONFIG_ANALOG=y                  : Should be automatically selected
      CONFIG_ADC=y                     : Should be automatically selected
      CONFIG_INPUT=y                   : Select input device support
      CONFIG_INPUT_AJOYSTICK=y         : Select analog joystick support

There is nothing in the configuration that currently uses the joystick.
For testing, you can add the following configuration options to enable
the analog joystick example at apps/examples/ajoystick:

    CONFIG_NSH_ARCHINIT=y
    CONFIG_EXAMPLES_AJOYSTICK=y
    CONFIG_EXAMPLES_AJOYSTICK_DEVNAME="/dev/ajoy0"

STATUS: 2014-12-04:

-   Without ADC DMA support, it is not possible to sample both X and Y
    with a single ADC. Right now, only one axis is being converted.
-   There is conflicts with some of the Arduino data pins and the
    default USART1 configuration. I am currently running with USART1 but
    with CONFIG\_NUCLEO\_L476RG\_AJOY\_MINBUTTONS to eliminate the
    conflict.
-   Current showstopper: I appear to be getting infinite interrupts as
    soon as joystick button interrupts are enabled.

Other External Hardware/Devices
-------------------------------

### Using external SPI SDCard

It is possible to use external SDCard over SPI with the
nucleo-stm32l476rg Cortex-M4. This option will or can broaden the
functionality in your project, solution or application.

In this NuttX project we attach an MH-SD Card Module (SPI).
\[<http://www.geeetech.com/wiki/index.php/Arduino_SD_card_Module>\]

Other solutions should also work.

>   Nucleo CN10   STM32L4x6RG
>   ------------- -------------
>   Pin 31 PB3    SLCK
>   Pin 27 PB4    MISO
>   Pin 29 PB5    MOSI
>   Pin 25 PB10   CS
>
>   Nucleo CN7   STM32L4x6RG
>   ------------ -------------
>   Pin 18 +5V   5V
>   Pin 22 GND   GND

On the board the pins are labeled and are corresponding with the
functions as written before. Configuring can be done by using
./tools/configure.sh nucleo-l476rg/spimmcsd

Configurations
--------------

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh for the
Nucleo-L476RG board. The Configuration enables the serial interfaces on
UART2. Support for builtin applications is enabled, but in the base
configuration no builtin applications are selected (see NOTES below).

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configuration using that tool, you should:

    a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
        see additional README.txt files in the NuttX tools repository.
    b.  Execute \'make menuconfig\' in nuttx/ in order to start the
        reconfiguration process.

2.  By default, this configuration uses the ARM EABI toolchain for
    Linux. That can easily be reconfigured, of course.:

    > CONFIG\_HOST\_LINUX=y : Builds under Linux
    > CONFIG\_ARM\_TOOLCHAIN\_GNU\_EABI=y : GNU EABI toolchain for Linux

3.  Although the default console is USART2 (which would correspond to
    the Virtual COM port) I have done all testing with the console
    device configured for USART1 (see instruction above under \"Serial
    Consoles). I have been using a TTL-to-RS-232 converter connected as
    shown below:

        Nucleo CN10 STM32F4x1RE
        ----------- ------------
        Pin 21 PA9  USART1_RX   *Warning you make need to reverse RX/TX on
        Pin 33 PA10 USART1_TX    some RS-232 converters
        Pin 20 GND
        Pin 8  U5V

### nxdemo

This is an NSH configuration that enables the NX graphics demo at
apps/examples/nxdemo. It uses the PCD8544 display on SPI1.
