# NXP RDDRONE-BMS772

[NXP
RDDRONE-BMS772](https://www.nxp.com/design/designs/smart-battery-management-for-mobile-robotics:RDDRONE-BMS772)
is a Battery Management System (BMS) reference design for mobile
robotics, such as drones and rovers. Design files are available on the
NXP website and may be used to develop your own BMS. RDDRONE-BMS772 is
configurable and supports batteries of 3 to 6 cells, which it can
monitor individually. The board features the [NXP
S32K144](https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32k-general-purpose-mcus/s32k1-microcontrollers-for-general-purpose:S32K1)
MCU, which can monitor the [NXP
MC33772B](https://www.nxp.com/products/power-management/battery-management/battery-cell-controllers/6-channel-li-ion-battery-cell-controller-ic:MC33772B)
Battery Cell Controller (BCC) and may communicates with the Vehicle
Management Unit (VMU). When faults are detected the battery output can
be disconnected to prevent further damage. Status information may be
communicated over I2C/SMBus, CAN or NFC.

NuttX contains basic board support RDDRONE-BMS772, which allows the
S32K144 MCU to be initialized. A NuttX-compatible smart battery
application for RDDRONE-BMS772 is also available. It contains additional
drivers and example software to use most features of the battery
management system. This application is currently published in a
[separate repository](https://github.com/NXPHoverGames/RDDRONE-BMS772),
but (parts) may eventually be upstreamed to Apache NuttX.

## Features

  -   - NXP FS32K144HAT0MLFT MCU
        
          - 80 MHz Clock (Max.)
          - 512 Kb Flash
          - 64 Kb SRAM
          - 4 Kb EEPROM

  - NXP MC33772BSP1AE Battery Cell Controller

  - NXP UJA1169TK/F/3 System Basis Chip

  -   - Connectivity:
        
          - UART (Console @ 115,200 baud)
          - CAN 2.0 (Transceiver part of UJA1169 SBC)
          - I2C Master header to connect a display (e.g. small
            SSD1306-based OLEDs)
          - I2C/SMBus Slave
          - NFC (NTAG5 Boost)

## Serial Console

By default, the serial console will be provided on the DCD-LZ UART
(available on the 7-pin DCD-LZ debug connector J19):

|                |      |             |
| -------------- | ---- | ----------- |
| DCD-LZ UART RX | PTC6 | LPUART1\_RX |
| DCD-LZ UART TX | PTC7 | LPUART1\_TX |

## LEDs

The RDDRONE-BMS772 has one RGB LED:

|          |       |          |
| -------- | ----- | -------- |
| RedLED   | PTD16 | FTM0 CH1 |
| GreenLED | PTB13 | FTM0 CH1 |
| BlueLED  | PTD15 | FTM0 CH0 |

An output of '0' illuminates the LED.

If CONFIG\_ARCH\_LEDS is not defined, then the user can control the LEDs
in any way. The following definitions are used to access individual RGB
components (see rddrone-bms772.h):

  - GPIO\_LED\_R
  - GPIO\_LED\_G
  - GPIO\_LED\_B

The RGB components could, alternatively, be controlled through PWM using
the common RGB LED driver.

If CONFIG\_ARCH\_LEDs is defined, then NuttX will control the LEDs on
board the RDDRONE-BMS772. The following definitions describe how NuttX
controls the LEDs:

| State                                                   | Description                                                                | RED   | GREEN | BLUE |
| ------------------------------------------------------- | -------------------------------------------------------------------------- | ----- | ----- | ---- |
| LED\_STARTED                                            | NuttX has been started                                                     | OFF   | OFF   | OFF  |
| LED\_HEAPALLOCATE                                       | Heap has been allocated                                                    | OFF   | OFF   | ON   |
| LED\_IRQSENABLED                                        | Interrupts enabled                                                         | OFF   | OFF   | ON   |
| LED\_STACKCREATED LED\_INIRQ LED\_SIGNAL LED\_ASSERTION | Idle stack created In an interrupt In a signal handler An assertion failed | OFF   | ON    | OFF  |
| LED\_PANIC LED\_IDLE                                    | The system has crashed S32K144 in sleep mode                               | FLASH | OFF   | OFF  |

## Configurations

Each RDDRONE-BMS772 configuration is maintained in a sub-directory and
can be selected as follows:

    tools/configure.sh rddrone-bms772:<subdir>

Where \<subdir\> is one of the sub-directories listed in the next
paragraph.

NOTES (common for all configurations):

1.    - This configuration uses the mconf-based configuration tool. To
        change this configuration using that tool, you should:
        
        1.  Build and install the kconfig-mconf tool. See
            nuttx/README.txt. Also see additional README.txt files in
            the NuttX tools repository.
        2.  Execute 'make menuconfig' in nuttx/ in order to start the
            reconfiguration process.

2.  Unless otherwise stated, the serial console used is LPUART1 at
    115,200 8N1.

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. Support for
builtin applications is enabled, but in the base configuration the only
application selected is the "Hello, World\!" example.
