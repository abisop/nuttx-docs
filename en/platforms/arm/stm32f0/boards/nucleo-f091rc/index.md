ST Nucleo F091RC
================

chip:stm32, chip:stm32f0, chip:stm32f091

That board features the STM32F091RCT6 MCU with 256KiB of FLASH and 32KiB
of SRAM.

LEDs
----

The Nucleo-64 board has one user controllable LED, User LD2. This green
LED is a user LED connected to Arduino signal D13 corresponding to STM32
I/O PA5 (PB13 on other some other Nucleo-64 boards).

-   When the I/O is HIGH value, the LED is on
-   When the I/O is LOW, the LED is off

These LEDs are not used by the board port unless CONFIG\_ARCH\_LEDS is
defined. In that case, the usage by the board port is defined in
include/board.h and src/stm32\_autoleds.c. The LEDs are used to encode
OS-related events as follows when the red LED (PE24) is available:

>   SYMBOL              Meaning                   LD2
>   ------------------- ------------------------- -----------
>   LED\_STARTED        NuttX has been started    OFF
>   LED\_HEAPALLOCATE   Heap has been allocated   OFF
>   LED\_IRQSENABLED    Interrupts enabled        OFF
>   LED\_STACKCREATED   Idle stack created        ON
>   LED\_INIRQ          In an interrupt           No change
>   LED\_SIGNAL         In a signal handler       No change
>   LED\_ASSERTION      An assertion failed       No change
>   LED\_PANIC          The system has crashed    Blinking
>   LED\_IDLE           MCU is is sleep mode      Not used

Thus if LD2, NuttX has successfully booted and is, apparently, running
normally. If LD2 is flashing at approximately 2Hz, then a fatal error
has been detected and the system has halted.

Buttons
-------

B1 USER: the user button is connected to the I/O PC13 (pin 2) of the
STM32 microcontroller.

Serial Console
--------------

### USART1

Pins and Connectors:

    RXD: PA10  D3  CN9 pin 3, CN10 pin 33
         PB7                  CN7  pin 21
    TXD: PA9   D8  CN5 pin 1, CN10 pin 21
         PB6   D10 CN5 pin 3, CN10 pin 17

NOTE: You may need to edit the include/board.h to select different
USART1 pin selections.

TTL to RS-232 converter connection:

>   Nucleo CN10                        STM32F091RC
>   ---------------------------------- -------------
>   Pin 21 PA9                         USART1\_TX
>   Pin 33 PA10 Pin 20 GND Pin 8 U5V   USART1\_RX

Warning: you make need to reverse RX/TX on some RS-232 converters

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

    RXD: PA3  To be provided
         PA15
         PD6
    TXD: PA2
         PA14
         PD5

### USART3

Pins and Connectors:

    RXD: PB11 To be provided
         PC5
         PC11
         D9
    TXD: PB10
         PC4
         PC10
         D8

See \"Virtual COM Port\" and \"RS-232 Shield\" below.

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

### RS-232 Shield

Supports a single RS-232 connected via

>   Nucleo      STM32F4x1RE       Shield
>   ----------- ----------------- --------
>   CN9 Pin 1   PA3 USART2\_RXD   RXD
>   CN9 Pin 2   PA2 USART2\_TXD   TXD

Support for this shield is enabled by selecting USART2 and configuring
SB13, 14, 62, and 63 as described above under \"Virtual COM Port\"

Configurations
--------------

### Information Common to All Configurations

Each configuration is maintained in a sub-directory and can be selected
as follow:

    tools/configure.sh nucleo-f091rc:<subdir>

Before building, make sure the PATH environment variable includes the
correct path to the directory than holds your toolchain binaries.

And then build NuttX by simply typing the following. At the conclusion
of the make, the nuttx binary will reside in an ELF file called, simply,
nuttx.:

    make oldconfig
    make

The \<subdir\> that is provided above as an argument to the
tools/configure.sh must be is one of the following.

NOTES:

1.  These configurations use the mconf-based configuration tool. To
    change any of these configurations using that tool, you should:

    a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
        see additional README.txt files in the NuttX tools repository.
    b.  Execute \'make menuconfig\' in nuttx/ in order to start the
        reconfiguration process.

2.  Unless stated otherwise, all configurations generate console output
    on USART2, as described above under \"Serial Console\". The elevant
    configuration settings are listed below:

        CONFIG_STM32_USART2=y
        CONFIG_STM32_USART2_SERIALDRIVER=y
        CONFIG_STM32_USART=y

        CONFIG_USART2_SERIALDRIVER=y
        CONFIG_USART2_SERIAL_CONSOLE=y

        CONFIG_USART2_RXBUFSIZE=256
        CONFIG_USART2_TXBUFSIZE=256
        CONFIG_USART2_BAUD=115200
        CONFIG_USART2_BITS=8
        CONFIG_USART2_PARITY=0
        CONFIG_USART2_2STOP=0

3.  All of these configurations are set up to build under Linux using
    the \"GNU Tools for ARM Embedded Processors\" that is maintained by
    ARM (unless stated otherwise in the description of the
    configuration).

    > <https://developer.arm.com/open-source/gnu-toolchain/gnu-rm>

    That toolchain selection can easily be reconfigured using \'make
    menuconfig\'. Here are the relevant current settings:

    Build Setup:

        CONFIG_HOST_LINUX=y                 : Linux environment

    System Type -\> Toolchain:

        CONFIG_ARM_TOOLCHAIN_GNU_EABI=y  : GNU ARM EABI toolchain

### nsh:

Configures the NuttShell (nsh) located at examples/nsh. This
configuration is focused on low level, command-line driver testing.
