# i.MX RT1050 EVK

[i.MX RT1050
EVK](https://www.nxp.com/design/development-boards/i-mx-evaluation-and-development-boards/i-mx-rt1050-evaluation-kit:MIMXRT1050-EVK)
is an evaluation kit by NXP company. This kit uses the i.MX RT1050
crossover MCU with ARM Cortex M7 core.

## Features

  -   - Processor
        
          - MIMXRT1052DVL6A processor

  -   - Memory
        
          - 256 Mb SDRAM memory
          - 512 Mb Hyper Flash
          - Footprint for QSPI Flash
          - TF socket for SD card

  -   - Display and Audio
        
          - Parallel LCD connector
          - Camera connector
          - Audio CODEC
          - 4-pole audio headphone jack
          - External speaker connection
          - Microphone
          - SPDIF connector

  -   - Connectivity
        
          - Micro USB host and OTG connectors
          - Ethernet (10/100T) connector
          - CAN transceivers
          - Arduino® interface

## Serial Console

Virtual console port provided by OpenSDA:

|            |                  |             |
| ---------- | ---------------- | ----------- |
| UART1\_TXD | GPIO\_AD\_B0\_12 | LPUART1\_TX |
| UART1\_RXD | GPIO\_AD\_B0\_13 | LPUART1\_RX |

Arduino RS-232 Shield:

|     |    |          |                  |             |
| --- | -- | -------- | ---------------- | ----------- |
| J22 | D0 | UART\_RX | GPIO\_AD\_B1\_07 | LPUART3\_RX |
| J22 | D1 | UART\_TX | GPIO\_AD\_B1\_06 | LPUART3\_TX |

## LEDs and buttons

### LEDs

There are four LED status indicators located on the EVK Board. The
functions of these LEDs include:

| Pin | Description  |
| --- | ------------ |
| D3  | Power Supply |
| D15 | Reset LED    |
| D16 | OpenSDA      |
| D18 | User LED     |

Only a single LED, D18, is under software control. It connects to
GPIO\_AD\_B0\_09 which is shared with JTAG\_TDI and ENET\_RST

This LED is not used by the board port unless CONFIG\_ARCH\_LEDS is
defined. In that case, the usage by the board port is defined in
include/board.h and src/imxrt\_autoleds.c. The LED is used to encode
OS-related events as follows:

| SYMBOL            | Meaning                 | LED   |
| ----------------- | ----------------------- | ----- |
| LED\_STARTED      | NuttX has been started  | OFF   |
| LED\_HEAPALLOCATE | Heap has been allocated | OFF   |
| LED\_IRQSENABLED  | Interrupts enabled      | OFF   |
| LED\_STACKCREATED | Idle stack created      | ON    |
| LED\_INIRQ        | In an interrupt         | N/C   |
| LED\_SIGNAL       | In a signal handler     | N/C   |
| LED\_ASSERTION    | An assertion failed     | N/C   |
| LED\_PANIC        | The system has crashed  | FLASH |

Thus if the LED is statically on, NuttX has successfully booted and is,
apparently, running normally. If the LED is flashing at approximately
2Hz, then a fatal error has been detected and the system has halted.

### Buttons

There are four user interface switches on the MIMXRT1050 EVK Board:

>   - SW1: Power Switch (slide switch)
>   - SW2: ON/OFF Button
>   - SW3: Reset button
>   - SW8: User button

Only the user button is available to the software. It is sensed on the
WAKEUP pin which will be pulled low when the button is pressed.

## Configurations

### knsh

This is identical to the nsh configuration below except that NuttX is
built as a protected mode, monolithic module and the user applications
are built separately. For further information about compiling and
running this configuration please refer to imxrt1064-evk documentation.

### netnsh

This configuration is similar to the nsh configuration except that is
has networking enabled, both IPv4 and IPv6. This NSH configuration is
focused on network-related testing.

### nsh

Configures the NuttShell (nsh) located at examples/nsh. This NSH
configuration is focused on low level, command-line driver testing.
Built-in applications are supported, but none are enabled. This
configuration does not support a network.
