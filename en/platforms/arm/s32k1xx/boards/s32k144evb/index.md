NXP S32K144EVB
==============

[NXP
S32K144EVB-Q100](https://www.nxp.com/design/development-boards/automotive-development-platforms/s32k-mcu-platforms/s32k144-q100-general-purpose-evaluation-board:S32K144EVB)
is an evaluation board for the [NXP S32K144
MCU](https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32k-general-purpose-mcus/s32k1-microcontrollers-for-general-purpose:S32K1)
based on an Arm Cortex-M4F core.

Features
--------

-   

    NXP FS32K144HFT0VLLT MCU

    :   -   80 MHz Clock (Max.)
        -   512 Kb Flash
        -   64 Kb SRAM
        -   4 Kb EEPROM

-   NXP UJA1169TK/F System Basis Chip

-   

    Connectivity:

    :   -   OpenSDA UART (Console @ 115,200 baud)
        -   CAN 2.0 (Transceiver part of UJA1169 SBC)
        -   I/O headers with GPIO, I2C, SPI, etc.

Serial Console
--------------

By default, the serial console will be provided on the OpenSDA VCOM
port:

  ----------------- ------ -------------
  OpenSDA UART RX   PTC6   LPUART1\_RX
  OpenSDA UART TX   PTC7   LPUART1\_TX
  ----------------- ------ -------------

USB drivers for the PEmicro CDC Serial Port are available here:
<http://www.pemicro.com/opensda/>

LEDs and Buttons
----------------

### Leds

The S32K144EVB has one RGB LED:

  ---------- ------- ----------
  RedLED     PTD15   FTM0 CH0
  GreenLED   PTD16   FTM0 CH1
  BlueLED    PTD0    FTM0 CH2
  ---------- ------- ----------

An output of \'0\' illuminates the LED.

If CONFIG\_ARCH\_LEDS is not defined, then the user can control the LEDs
in any way. The following definitions are used to access individual RGB
components (see s32k144evb.h):

-   GPIO\_LED\_R
-   GPIO\_LED\_G
-   GPIO\_LED\_B

The RGB components could, alternatively, be controlled through PWM using
the common RGB LED driver.

If CONFIG\_ARCH\_LEDs is defined, then NuttX will control the LEDs on
board the S32K144EVB. The following definitions describe how NuttX
controls the LEDs:

  State                                                     Description                                                                  RED     GREEN   BLUE
  --------------------------------------------------------- ---------------------------------------------------------------------------- ------- ------- ------
  LED\_STARTED                                              NuttX has been started                                                       OFF     OFF     OFF
  LED\_HEAPALLOCATE                                         Heap has been allocated                                                      OFF     OFF     ON
  LED\_IRQSENABLED                                          Interrupts enabled                                                           OFF     OFF     ON
  LED\_STACKCREATED LED\_INIRQ LED\_SIGNAL LED\_ASSERTION   Idle stack created In an interrupt In a signal handler An assertion failed   OFF     ON      OFF
  LED\_PANIC LED\_IDLE                                      The system has crashed S32K144 in sleep mode                                 FLASH   OFF     OFF

### Buttons

The S32K144EVB supports two buttons:

  ----- -------
  SW2   PTC12
  SW3   PTC13
  ----- -------

OpenSDA Notes
-------------

-   USB drivers for the PEmicro CDC Serial Port are available here:
    <http://www.pemicro.com/opensda/>
-   The drag\'n\'drog interface expects files in .srec format.
-   Using Segger J-Link: Easy\... but remember to use the SWD connector
    J14 near the touch electrodes and not the OpenSDA connector near the
    OpenSDA USB connector J7.

Configurations
--------------

Each S32K144EVB configuration is maintained in a sub-directory and can
be selected as follows:

    tools/configure.sh s32k144evb:<subdir>

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
