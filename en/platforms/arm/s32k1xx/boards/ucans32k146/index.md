NXP UCANS32K146
===============

[NXP
UCANS32K146](https://www.nxp.com/design/development-boards/automotive-development-platforms/s32k-mcu-platforms/s32k146-uavcan-v1-and-mavcan-development-system:UCANS32K146)
is a CAN Node reference design and development platform for mobile
robotics applications, such as drones and rovers. It features the [NXP
S32K146
MCU](https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32k-general-purpose-mcus/s32k1-microcontrollers-for-general-purpose:S32K1)
based on an Arm Cortex-M4F core. There exist a few different
revisions/variants of this board. All variants with the S32K146
microcontroller are supported.

Features
--------

-   

    NXP FS32K146UAT0VLHT MCU

    :   -   112 MHz Clock (Max.)
        -   1024 Kb Flash
        -   128 Kb SRAM
        -   4 Kb EEPROM

-   NXP UJA1169TK/F System Basis Chip

-   

    Connectivity:

    :   -   Console UART (Console @ 115,200 baud)
        -   2x CAN FD
        -   I/O headers with GPIO, I2C, SPI, etc.

Serial Console
--------------

By default, the serial console will be provided on the DCD-LZ UART
(available on the 7-pin DCD-LZ debug connector P6):

  ---------------- ------ -------------
  DCD-LZ UART RX   PTC6   LPUART1\_RX
  DCD-LZ UART TX   PTC7   LPUART1\_TX
  ---------------- ------ -------------

LEDs and Buttons
----------------

### Leds

The UCANS32K146 has one RGB LED:

  ---------- ------- ----------
  RedLED     PTD15   FTM0 CH0
  GreenLED   PTD16   FTM0 CH1
  BlueLED    PTD0    FTM0 CH2
  ---------- ------- ----------

An output of \'0\' illuminates the LED.

If CONFIG\_ARCH\_LEDS is not defined, then the user can control the LEDs
in any way. The following definitions are used to access individual RGB
components (see ucans32k146.h):

-   GPIO\_LED\_R
-   GPIO\_LED\_G
-   GPIO\_LED\_B

The RGB components could, alternatively, be controlled through PWM using
the common RGB LED driver.

If CONFIG\_ARCH\_LEDs is defined, then NuttX will control the LEDs on
board the UCANS32K146. The following definitions describe how NuttX
controls the LEDs:

  State                                                     Description                                                                  RED     GREEN   BLUE
  --------------------------------------------------------- ---------------------------------------------------------------------------- ------- ------- ------
  LED\_STARTED                                              NuttX has been started                                                       OFF     OFF     OFF
  LED\_HEAPALLOCATE                                         Heap has been allocated                                                      OFF     OFF     ON
  LED\_IRQSENABLED                                          Interrupts enabled                                                           OFF     OFF     ON
  LED\_STACKCREATED LED\_INIRQ LED\_SIGNAL LED\_ASSERTION   Idle stack created In an interrupt In a signal handler An assertion failed   OFF     ON      OFF
  LED\_PANIC LED\_IDLE                                      The system has crashed S32K146 in sleep mode                                 FLASH   OFF     OFF

### Buttons

The UCANS32K146 supports one button:

  SW3     PTC14
  ------- -----------
          
  Confi   gurations

Each UCANS32K146 configuration is maintained in a sub-directory and can
be selected as follows:

    tools/configure.sh ucans32k146:<subdir>

Where \<subdir\> is one of the sub-directories listed in the next
paragraph.

NOTES (common for all configurations):

1.  

    This configuration uses the mconf-based configuration tool. To change this configuration using that tool, you should:

    :   a.  Build and install the kconfig-mconf tool. See
            nuttx/README.txt. Also see additional README.txt files in
            the NuttX tools repository.
        b.  Execute \'make menuconfig\' in nuttx/ in order to start the
            reconfiguration process.

2.  Unless otherwise stated, the serial console used is LPUART1 at
    115,200 8N1.

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. Support for
builtin applications is enabled, but in the base configuration the only
application selected is the \"Hello, World!\" example.

### can

Besides the NuttShell this configuration also enables (Socket)CAN
support, as well as I2C and SPI support. It includes the SLCAN and
can-utils applications for monitoring and debugging CAN applications.
