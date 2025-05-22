ESP32-PICO-KIT V4
=================

::: {.tags}
chip:esp32, chip:esp32picod4
:::

This guide shows how to get started with the ESP32-PICO-KIT V4/V4.1 mini
development board.

This particular description covers ESP32-PICO-KIT V4 and V4.1. The
difference is the upgraded USB-UART bridge from CP2102 in V4 with up to
1 Mbps transfer rates to CP2102N in V4.1 with up to 3 Mbps transfer
rates.

What You Need
-------------

-   `ESP32-PICO-KIT mini development board <get-started-pico-kit-v4-board-front>`{.interpreted-text
    role="ref"}
-   USB 2.0 A to Micro B cable
-   Computer running Windows, Linux, or macOS

Overview
--------

ESP32-PICO-KIT is an ESP32-based mini development board produced by
[Espressif](https://espressif.com).

The core of this board is ESP32-PICO-D4 - a System-in-Package (SiP)
module with complete Wi-Fi and Bluetooth functionalities. Compared to
other ESP32 modules, ESP32-PICO-D4 integrates the following peripheral
components in one single package, which otherwise would need to be
installed separately:

-   40 MHz crystal oscillator
-   4 MB flash
-   Filter capacitors
-   RF matching links

This setup reduces the costs of additional external components as well
as the cost of assembly and testing and also increases the overall
usability of the product.

The development board features a USB-UART Bridge circuit which allows
developers to connect the board to a computer\'s USB port for flashing
and debugging.

All the IO signals and system power on ESP32-PICO-D4 are led out to two
rows of 20 x 0.1\" header pads on both sides of the development board
for easy access. For compatibility with Dupont wires, 2 x 17 header pads
are populated with two rows of male pin headers. The remaining 2 x 3
header pads beside the antenna are not populated. These pads may be
populated later by the user if required.

::: {.note}
::: {.title}
Note
:::

1.  There are two versions of ESP32-PICO-KIT boards, respectively with
    male headers and female headers. In this guide, the male header
    version is taken as an example.
2.  The 2 x 3 pads not populated with pin headers are connected to the
    flash memory embedded in the ESP32-PICO-D4 SiP module. For more
    details, see module\'s datasheet in [Related
    Documents](#related-documents).
:::

Functionality Overview
----------------------

The block diagram below shows the main components of ESP32-PICO-KIT and
their interconnections.

![ESP32-PICO-KIT block
diagram](esp32-pico-kit-v4-functional-block-diagram.png){.align-centeralign-center}

Functional Description
----------------------

The following figure and the table below describe the key components,
interfaces, and controls of the ESP32-PICO-KIT board.

::: {#get-started-pico-kit-v4-board-front}
![ESP32-PICO-KIT board layout (with female
headers)](esp32-pico-kit-v4.1-f-layout.jpeg){.align-centeralign-center}
:::

Below is the description of the items identified in the figure starting
from the top left corner and going clockwise.

  -----------------------------------------------------------------------
  Key Component     Description
  ----------------- -----------------------------------------------------
  ESP32-PICO-D4     Standard ESP32-PICO-D4 module soldered to the
                    ESP32-PICO-KIT board. The complete ESP32 system on a
                    chip (ESP32 SoC) has been integrated into the SiP
                    module, requiring only an external antenna with LC
                    matching network, decoupling capacitors, and a
                    pull-up resistor for EN signals to function properly.

  LDO               5V-to-3.3V Low dropout voltage regulator (LDO).

  USB-UART bridge   Single-chip USB-UART bridge: CP2102 in V4 provides up
                    to 1 Mbps transfer rates and CP2102N in V4.1 offers
                    up to 3 Mbps transfers rates.

  Micro USB Port    USB interface. Power supply for the board as well as
                    the communication interface between a computer and
                    the board.

  5V Power On LED   This red LED turns on when power is supplied to the
                    board. For details, see the schematics in [Related
                    Documents](#related-documents).

  I/O               All the pins on ESP32-PICO-D4 are broken out to pin
                    headers. You can program ESP32 to enable multiple
                    functions, such as PWM, ADC, DAC, I2C, I2S, SPI, etc.
                    For details, please see Section [Pin
                    Descriptions](#pin-descriptions).

  BOOT Button       Download button. Holding down **Boot** and then
                    pressing **EN** initiates Firmware Download mode for
                    downloading firmware through the serial port.

  EN Button         Reset button.
  -----------------------------------------------------------------------

Power Supply Options
--------------------

There are three mutually exclusive ways to provide power to the board:

-   Micro USB port, default power supply
-   5V / GND header pins
-   3V3 / GND header pins

::: {.warning}
::: {.title}
Warning
:::

The power supply must be provided using **one and only one of the
options above**, otherwise the board and/or the power supply source can
be damaged.
:::

Pin Descriptions
----------------

The two tables below provide the **Name** and **Function** of I/O header
pins on both sides of the board, see
`get-started-pico-kit-v4-board-front`{.interpreted-text role="ref"}. The
pin numbering and header names are the same as in the schematic given in
[Related Documents](#related-documents).

### Header J2

+-----+-------------------+------+--------------------------+
| No. | Name              | Type | Function                 |
+=====+===================+======+==========================+
| 1   | FLASH\_SD1 (FSD1) | I/O  | | GPIO8, SD\_DATA1,      |
|     |                   |      |   SPID, HS1\_DATA1       |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U2CTS    |
+-----+-------------------+------+--------------------------+
| 2   | FLASH\_SD3 (FSD3) | I/O  | | GPIO7, SD\_DATA0,      |
|     |                   |      |   SPIQ, HS1\_DATA0       |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U2RTS    |
+-----+-------------------+------+--------------------------+
| 3   | FLASH\_CLK (FCLK) | I/O  | | GPIO6, SD\_CLK,        |
|     |                   |      |   SPICLK, HS1\_CLK       |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U1CTS    |
+-----+-------------------+------+--------------------------+
| 4   | IO21              | I/O  | | GPIO21, VSPIHD,        |
|     |                   |      |   EMAC\_TX\_EN           |
+-----+-------------------+------+--------------------------+
| 5   | IO22              | I/O  | | GPIO22, VSPIWP, U0RTS, |
|     |                   |      |   EMAC\_TXD1             |
+-----+-------------------+------+--------------------------+
| 6   | IO19              | I/O  | | GPIO19, VSPIQ, U0CTS,  |
|     |                   |      |   EMAC\_TXD0             |
+-----+-------------------+------+--------------------------+
| 7   | IO23              | I/O  | | GPIO23, VSPID,         |
|     |                   |      |   HS1\_STROBE            |
+-----+-------------------+------+--------------------------+
| 8   | IO18              | I/O  | | GPIO18, VSPICLK,       |
|     |                   |      |   HS1\_DATA7             |
+-----+-------------------+------+--------------------------+
| 9   | IO5               | I/O  | | GPIO5, VSPICS0,        |
|     |                   |      |   HS1\_DATA6,            |
|     |                   |      |   EMAC\_RX\_CLK          |
+-----+-------------------+------+--------------------------+
| 10  | IO10              | I/O  | | GPIO10, SD\_DATA3,     |
|     |                   |      |   SPIWP, HS1\_DATA3,     |
|     |                   |      |   U1TXD                  |
+-----+-------------------+------+--------------------------+
| 11  | IO9               | I/O  | | GPIO9, SD\_DATA2,      |
|     |                   |      |   SPIHD, HS1\_DATA2,     |
|     |                   |      |   U1RXD                  |
+-----+-------------------+------+--------------------------+
| 12  | RXD0              | I/O  | | GPIO3, U0RXD           |
|     |                   |      |   `(See 3) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} ,          |
|     |                   |      |   CLK\_OUT2              |
+-----+-------------------+------+--------------------------+
| 13  | TXD0              | I/O  | | GPIO1, U0TXD           |
|     |                   |      |   `(See 3) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} ,          |
|     |                   |      |   CLK\_OUT3, EMAC\_RXD2  |
+-----+-------------------+------+--------------------------+
| 14  | IO35              | I    | | ADC1\_CH7, RTC\_GPIO5  |
+-----+-------------------+------+--------------------------+
| 15  | IO34              | I    | | ADC1\_CH6, RTC\_GPIO4  |
+-----+-------------------+------+--------------------------+
| 16  | IO38              | I    | | GPIO38, ADC1\_CH2,     |
|     |                   |      |   RTC\_GPIO2             |
+-----+-------------------+------+--------------------------+
| 17  | IO37              | I    | | GPIO37, ADC1\_CH1,     |
|     |                   |      |   RTC\_GPIO1             |
+-----+-------------------+------+--------------------------+
| 18  | EN                | I    | | CHIP\_PU               |
+-----+-------------------+------+--------------------------+
| 19  | GND               | P    | | Ground                 |
+-----+-------------------+------+--------------------------+
| 20  | VDD33 (3V3)       | P    | | 3.3V power supply      |
+-----+-------------------+------+--------------------------+

### Header J3

+-----+-------------------+------+--------------------------+
| No. | Name              | Type | Function                 |
+=====+===================+======+==========================+
| 1   | FLASH\_CS (FCS)   | I/O  | | GPIO16, HS1\_DATA4     |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U2RXD,   |
|     |                   |      |   EMAC\_CLK\_OUT         |
+-----+-------------------+------+--------------------------+
| 2   | FLASH\_SD0 (FSD0) | I/O  | | GPIO17, HS1\_DATA5     |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U2TXD,   |
|     |                   |      |   EMAC\_CLK\_OUT\_180    |
+-----+-------------------+------+--------------------------+
| 3   | FLASH\_SD2 (FSD2) | I/O  | | GPIO11, SD\_CMD,       |
|     |                   |      |   SPICS0, HS1\_CMD       |
|     |                   |      |   `(See 1) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , U1RTS    |
+-----+-------------------+------+--------------------------+
| 4   | SENSOR\_VP (FSVP) | I    | | GPIO36, ADC1\_CH0,     |
|     |                   |      |   RTC\_GPIO0             |
+-----+-------------------+------+--------------------------+
| 5   | SENSOR\_VN (FSVN) | I    | | GPIO39, ADC1\_CH3,     |
|     |                   |      |   RTC\_GPIO3             |
+-----+-------------------+------+--------------------------+
| 6   | IO25              | I/O  | | GPIO25, DAC\_1,        |
|     |                   |      |   ADC2\_CH8, RTC\_GPIO6, |
|     |                   |      |   EMAC\_RXD0             |
+-----+-------------------+------+--------------------------+
| 7   | IO26              | I/O  | | GPIO26, DAC\_2,        |
|     |                   |      |   ADC2\_CH9, RTC\_GPIO7, |
|     |                   |      |   EMAC\_RXD1             |
+-----+-------------------+------+--------------------------+
| 8   | IO32              | I/O  | | 32K\_XP                |
|     |                   |      |   `(See 2a) <get-s       |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} ,          |
|     |                   |      |   ADC1\_CH4, TOUCH9,     |
|     |                   |      |   RTC\_GPIO9             |
+-----+-------------------+------+--------------------------+
| 9   | IO33              | I/O  | | 32K\_XN                |
|     |                   |      |   `(See 2b) <get-s       |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} ,          |
|     |                   |      |   ADC1\_CH5, TOUCH8,     |
|     |                   |      |   RTC\_GPIO8             |
+-----+-------------------+------+--------------------------+
| 10  | IO27              | I/O  | | GPIO27, ADC2\_CH7,     |
|     |                   |      |   TOUCH7, RTC\_GPIO17    |
|     |                   |      | | EMAC\_RX\_DV           |
+-----+-------------------+------+--------------------------+
| 11  | IO14              | I/O  | | ADC2\_CH6, TOUCH6,     |
|     |                   |      |   RTC\_GPIO16, MTMS,     |
|     |                   |      |   HSPICLK,               |
|     |                   |      | | HS2\_CLK, SD\_CLK,     |
|     |                   |      |   EMAC\_TXD2             |
+-----+-------------------+------+--------------------------+
| 12  | IO12              | I/O  | | ADC2\_CH5, TOUCH5,     |
|     |                   |      |   RTC\_GPIO15, MTDI      |
|     |                   |      |   `(See 4) <get-s        |
|     |                   |      | tarted-pico-kit-v4-pin-n |
|     |                   |      | otes>`{.interpreted-text |
|     |                   |      |   role="ref"} , HSPIQ,   |
|     |                   |      | | HS2\_DATA2, SD\_DATA2, |
|     |                   |      |   EMAC\_TXD3             |
+-----+-------------------+------+--------------------------+
| 13  | IO13              | I/O  | | ADC2\_CH4, TOUCH4,     |
|     |                   |      |   RTC\_GPIO14, MTCK,     |
|     |                   |      |   HSPID,                 |
|     |                   |      | | HS2\_DATA3, SD\_DATA3, |
|     |                   |      |   EMAC\_RX\_ER           |
+-----+-------------------+------+--------------------------+
| 14  | IO15              | I/O  | | ADC2\_CH3, TOUCH3,     |
|     |                   |      |   RTC\_GPIO13, MTDO,     |
|     |                   |      |   HSPICS0                |
|     |                   |      | | HS2\_CMD, SD\_CMD,     |
|     |                   |      |   EMAC\_RXD3             |
+-----+-------------------+------+--------------------------+
| 15  | IO2               | I/O  | | ADC2\_CH2, TOUCH2,     |
|     |                   |      |   RTC\_GPIO12, HSPIWP,   |
|     |                   |      | | HS2\_DATA0, SD\_DATA0  |
+-----+-------------------+------+--------------------------+
| 16  | IO4               | I/O  | | ADC2\_CH0, TOUCH0,     |
|     |                   |      |   RTC\_GPIO10, HSPIHD,   |
|     |                   |      | | HS2\_DATA1, SD\_DATA1, |
|     |                   |      |   EMAC\_TX\_ER           |
+-----+-------------------+------+--------------------------+
| 17  | IO0               | I/O  | | ADC2\_CH1, TOUCH1,     |
|     |                   |      |   RTC\_GPIO11, CLK\_OUT1 |
|     |                   |      | | EMAC\_TX\_CLK          |
+-----+-------------------+------+--------------------------+
| 18  | VDD33 (3V3)       | P    | | 3.3V power supply      |
+-----+-------------------+------+--------------------------+
| 19  | GND               | P    | | Ground                 |
+-----+-------------------+------+--------------------------+
| 20  | EXT\_5V (5V)      | P    | | 5V power supply        |
+-----+-------------------+------+--------------------------+

::: {#get-started-pico-kit-v4-pin-notes}
::: {.note}
::: {.title}
Note
:::

1.  This pin is connected to the flash pin of ESP32-PICO-D4.
2.  32.768 kHz crystal oscillator: a) input, b) output.
3.  This pin is connected to the pin of the USB bridge chip on the
    board.
4.  The operating voltage of ESP32-PICO-KIT's embedded SPI flash is
    3.3 V. Therefore, the strapping pin MTDI should hold bit zero during
    the module power-on reset. If connected, please make sure that this
    pin is not held up on reset.
:::
:::

#### Pin Layout

![ESP32-PICO-KIT Pin Layout (click to
enlarge)](esp32-pico-kit-v4-pinout.png){.align-center}

Board Dimensions
----------------

The dimensions are 52 x 20.3 x 10 mm (2.1\" x 0.8\" x 0.4\").

![ESP32-PICO-KIT dimensions - back (with male
headers)](esp32-pico-kit-v4.1-dimensions-back.jpg){.align-centeralign-center}

![ESP32-PICO-KIT dimensions - side (with male
headers)](esp32-pico-kit-v4-dimensions-side.jpg){.align-centeralign-center}

For the board physical construction details, please refer to its
Reference Design listed below.

Related Documents
-----------------

-   [ESP32-PICO-KIT V4
    schematic](https://dl.espressif.com/dl/schematics/esp32-pico-kit-v4_schematic.pdf)
    (PDF)
-   [ESP32-PICO-KIT V4.1
    schematic](https://dl.espressif.com/dl/schematics/esp32-pico-kit-v4.1_schematic.pdf)
    (PDF)
-   [ESP32-PICO-KIT Reference
    Design](https://www.espressif.com/sites/default/files/documentation/esp32-pico-kit_v4.1_20180314_en.zip)
    containing OrCAD schematic, PCB layout, gerbers and BOM
-   [ESP32-PICO-D4
    Datasheet](https://espressif.com/sites/default/files/documentation/esp32-pico-d4_datasheet_en.pdf)
    (PDF)

Configurations
--------------

All of the configurations presented below can be tested by running the
following commands:

    $ ./tools/configure.sh esp32-pico-kit:<config_name>
    $ make flash ESPTOOL_PORT=/dev/ttyUSB0 -j

Where \<config\_name\> is the name of board configuration you want to
use, i.e.: nsh, buttons, wifi\... Then use a serial console terminal
like `picocom` configured to 115200 8N1.

### nsh

Basic NuttShell configuration (console enabled in UART0, exposed via USB
connection by means of CP2102 converter, at 115200 bps).
