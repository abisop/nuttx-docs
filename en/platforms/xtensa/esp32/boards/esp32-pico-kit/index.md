# ESP32-PICO-KIT V4

<div class="tags">

chip:esp32, chip:esp32picod4

</div>

This guide shows how to get started with the ESP32-PICO-KIT V4/V4.1 mini
development board.

This particular description covers ESP32-PICO-KIT V4 and V4.1. The
difference is the upgraded USB-UART bridge from CP2102 in V4 with up to
1 Mbps transfer rates to CP2102N in V4.1 with up to 3 Mbps transfer
rates.

## What You Need

  - `ESP32-PICO-KIT mini development board
    <get-started-pico-kit-v4-board-front>`
  - USB 2.0 A to Micro B cable
  - Computer running Windows, Linux, or macOS

## Overview

ESP32-PICO-KIT is an ESP32-based mini development board produced by
[Espressif](https://espressif.com).

The core of this board is ESP32-PICO-D4 - a System-in-Package (SiP)
module with complete Wi-Fi and Bluetooth functionalities. Compared to
other ESP32 modules, ESP32-PICO-D4 integrates the following peripheral
components in one single package, which otherwise would need to be
installed separately:

  - 40 MHz crystal oscillator
  - 4 MB flash
  - Filter capacitors
  - RF matching links

This setup reduces the costs of additional external components as well
as the cost of assembly and testing and also increases the overall
usability of the product.

The development board features a USB-UART Bridge circuit which allows
developers to connect the board to a computer's USB port for flashing
and debugging.

All the IO signals and system power on ESP32-PICO-D4 are led out to two
rows of 20 x 0.1" header pads on both sides of the development board for
easy access. For compatibility with Dupont wires, 2 x 17 header pads are
populated with two rows of male pin headers. The remaining 2 x 3 header
pads beside the antenna are not populated. These pads may be populated
later by the user if required.

<div class="note">

<div class="title">

Note

</div>

1.  There are two versions of ESP32-PICO-KIT boards, respectively with
    male headers and female headers. In this guide, the male header
    version is taken as an example.
2.  The 2 x 3 pads not populated with pin headers are connected to the
    flash memory embedded in the ESP32-PICO-D4 SiP module. For more
    details, see module's datasheet in [Related
    Documents](#related-documents).

</div>

## Functionality Overview

The block diagram below shows the main components of ESP32-PICO-KIT and
their interconnections.

![ESP32-PICO-KIT block
diagram](esp32-pico-kit-v4-functional-block-diagram.png)

## Functional Description

The following figure and the table below describe the key components,
interfaces, and controls of the ESP32-PICO-KIT board.

![ESP32-PICO-KIT board layout (with female
headers)](esp32-pico-kit-v4.1-f-layout.jpeg)

Below is the description of the items identified in the figure starting
from the top left corner and going clockwise.

| Key Component   | Description                                                                                                                                                                                                                                                                                                  |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ESP32-PICO-D4   | Standard ESP32-PICO-D4 module soldered to the ESP32-PICO-KIT board. The complete ESP32 system on a chip (ESP32 SoC) has been integrated into the SiP module, requiring only an external antenna with LC matching network, decoupling capacitors, and a pull-up resistor for EN signals to function properly. |
| LDO             | 5V-to-3.3V Low dropout voltage regulator (LDO).                                                                                                                                                                                                                                                              |
| USB-UART bridge | Single-chip USB-UART bridge: CP2102 in V4 provides up to 1 Mbps transfer rates and CP2102N in V4.1 offers up to 3 Mbps transfers rates.                                                                                                                                                                      |
| Micro USB Port  | USB interface. Power supply for the board as well as the communication interface between a computer and the board.                                                                                                                                                                                           |
| 5V Power On LED | This red LED turns on when power is supplied to the board. For details, see the schematics in [Related Documents](#related-documents).                                                                                                                                                                       |
| I/O             | All the pins on ESP32-PICO-D4 are broken out to pin headers. You can program ESP32 to enable multiple functions, such as PWM, ADC, DAC, I2C, I2S, SPI, etc. For details, please see Section [Pin Descriptions](#pin-descriptions).                                                                           |
| BOOT Button     | Download button. Holding down **Boot** and then pressing **EN** initiates Firmware Download mode for downloading firmware through the serial port.                                                                                                                                                           |
| EN Button       | Reset button.                                                                                                                                                                                                                                                                                                |

## Power Supply Options

There are three mutually exclusive ways to provide power to the board:

  - Micro USB port, default power supply
  - 5V / GND header pins
  - 3V3 / GND header pins

<div class="warning">

<div class="title">

Warning

</div>

The power supply must be provided using **one and only one of the
options above**, otherwise the board and/or the power supply source can
be damaged.

</div>

## Pin Descriptions

The two tables below provide the **Name** and **Function** of I/O header
pins on both sides of the board, see
`get-started-pico-kit-v4-board-front`. The pin numbering and header
names are the same as in the schematic given in [Related
Documents](#related-documents).

### Header J2

<table>
<thead>
<tr class="header">
<th>No.</th>
<th>Name</th>
<th>Type</th>
<th>Function</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>FLASH_SD1 (FSD1)</td>
<td>I/O</td>
<td><div class="line-block">GPIO8, SD_DATA1, SPID, HS1_DATA1 <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U2CTS</div></td>
</tr>
<tr class="even">
<td>2</td>
<td>FLASH_SD3 (FSD3)</td>
<td>I/O</td>
<td><div class="line-block">GPIO7, SD_DATA0, SPIQ, HS1_DATA0 <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U2RTS</div></td>
</tr>
<tr class="odd">
<td>3</td>
<td>FLASH_CLK (FCLK)</td>
<td>I/O</td>
<td><div class="line-block">GPIO6, SD_CLK, SPICLK, HS1_CLK <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U1CTS</div></td>
</tr>
<tr class="even">
<td>4</td>
<td>IO21</td>
<td>I/O</td>
<td><div class="line-block">GPIO21, VSPIHD, EMAC_TX_EN</div></td>
</tr>
<tr class="odd">
<td>5</td>
<td>IO22</td>
<td>I/O</td>
<td><div class="line-block">GPIO22, VSPIWP, U0RTS, EMAC_TXD1</div></td>
</tr>
<tr class="even">
<td>6</td>
<td>IO19</td>
<td>I/O</td>
<td><div class="line-block">GPIO19, VSPIQ, U0CTS, EMAC_TXD0</div></td>
</tr>
<tr class="odd">
<td>7</td>
<td>IO23</td>
<td>I/O</td>
<td><div class="line-block">GPIO23, VSPID, HS1_STROBE</div></td>
</tr>
<tr class="even">
<td>8</td>
<td>IO18</td>
<td>I/O</td>
<td><div class="line-block">GPIO18, VSPICLK, HS1_DATA7</div></td>
</tr>
<tr class="odd">
<td>9</td>
<td>IO5</td>
<td>I/O</td>
<td><div class="line-block">GPIO5, VSPICS0, HS1_DATA6, EMAC_RX_CLK</div></td>
</tr>
<tr class="even">
<td>10</td>
<td>IO10</td>
<td>I/O</td>
<td><div class="line-block">GPIO10, SD_DATA3, SPIWP, HS1_DATA3, U1TXD</div></td>
</tr>
<tr class="odd">
<td>11</td>
<td>IO9</td>
<td>I/O</td>
<td><div class="line-block">GPIO9, SD_DATA2, SPIHD, HS1_DATA2, U1RXD</div></td>
</tr>
<tr class="even">
<td>12</td>
<td>RXD0</td>
<td>I/O</td>
<td><div class="line-block">GPIO3, U0RXD <code class="interpreted-text" role="ref">(See 3) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , CLK_OUT2</div></td>
</tr>
<tr class="odd">
<td>13</td>
<td>TXD0</td>
<td>I/O</td>
<td><div class="line-block">GPIO1, U0TXD <code class="interpreted-text" role="ref">(See 3) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , CLK_OUT3, EMAC_RXD2</div></td>
</tr>
<tr class="even">
<td>14</td>
<td>IO35</td>
<td>I</td>
<td><div class="line-block">ADC1_CH7, RTC_GPIO5</div></td>
</tr>
<tr class="odd">
<td>15</td>
<td>IO34</td>
<td>I</td>
<td><div class="line-block">ADC1_CH6, RTC_GPIO4</div></td>
</tr>
<tr class="even">
<td>16</td>
<td>IO38</td>
<td>I</td>
<td><div class="line-block">GPIO38, ADC1_CH2, RTC_GPIO2</div></td>
</tr>
<tr class="odd">
<td>17</td>
<td>IO37</td>
<td>I</td>
<td><div class="line-block">GPIO37, ADC1_CH1, RTC_GPIO1</div></td>
</tr>
<tr class="even">
<td>18</td>
<td>EN</td>
<td>I</td>
<td><div class="line-block">CHIP_PU</div></td>
</tr>
<tr class="odd">
<td>19</td>
<td>GND</td>
<td>P</td>
<td><div class="line-block">Ground</div></td>
</tr>
<tr class="even">
<td>20</td>
<td>VDD33 (3V3)</td>
<td>P</td>
<td><div class="line-block">3.3V power supply</div></td>
</tr>
</tbody>
</table>

### Header J3

<table>
<thead>
<tr class="header">
<th>No.</th>
<th>Name</th>
<th>Type</th>
<th>Function</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>FLASH_CS (FCS)</td>
<td>I/O</td>
<td><div class="line-block">GPIO16, HS1_DATA4 <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U2RXD, EMAC_CLK_OUT</div></td>
</tr>
<tr class="even">
<td>2</td>
<td>FLASH_SD0 (FSD0)</td>
<td>I/O</td>
<td><div class="line-block">GPIO17, HS1_DATA5 <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U2TXD, EMAC_CLK_OUT_180</div></td>
</tr>
<tr class="odd">
<td>3</td>
<td>FLASH_SD2 (FSD2)</td>
<td>I/O</td>
<td><div class="line-block">GPIO11, SD_CMD, SPICS0, HS1_CMD <code class="interpreted-text" role="ref">(See 1) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , U1RTS</div></td>
</tr>
<tr class="even">
<td>4</td>
<td>SENSOR_VP (FSVP)</td>
<td>I</td>
<td><div class="line-block">GPIO36, ADC1_CH0, RTC_GPIO0</div></td>
</tr>
<tr class="odd">
<td>5</td>
<td>SENSOR_VN (FSVN)</td>
<td>I</td>
<td><div class="line-block">GPIO39, ADC1_CH3, RTC_GPIO3</div></td>
</tr>
<tr class="even">
<td>6</td>
<td>IO25</td>
<td>I/O</td>
<td><div class="line-block">GPIO25, DAC_1, ADC2_CH8, RTC_GPIO6, EMAC_RXD0</div></td>
</tr>
<tr class="odd">
<td>7</td>
<td>IO26</td>
<td>I/O</td>
<td><div class="line-block">GPIO26, DAC_2, ADC2_CH9, RTC_GPIO7, EMAC_RXD1</div></td>
</tr>
<tr class="even">
<td>8</td>
<td>IO32</td>
<td>I/O</td>
<td><div class="line-block">32K_XP <code class="interpreted-text" role="ref">(See 2a) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , ADC1_CH4, TOUCH9, RTC_GPIO9</div></td>
</tr>
<tr class="odd">
<td>9</td>
<td>IO33</td>
<td>I/O</td>
<td><div class="line-block">32K_XN <code class="interpreted-text" role="ref">(See 2b) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , ADC1_CH5, TOUCH8, RTC_GPIO8</div></td>
</tr>
<tr class="even">
<td><p>10</p></td>
<td><p>IO27</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">GPIO27, ADC2_CH7, TOUCH7, RTC_GPIO17<br />
EMAC_RX_DV</div></td>
</tr>
<tr class="odd">
<td><p>11</p></td>
<td><p>IO14</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH6, TOUCH6, RTC_GPIO16, MTMS, HSPICLK,<br />
HS2_CLK, SD_CLK, EMAC_TXD2</div></td>
</tr>
<tr class="even">
<td><p>12</p></td>
<td><p>IO12</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH5, TOUCH5, RTC_GPIO15, MTDI <code class="interpreted-text" role="ref">(See 4) &lt;get-started-pico-kit-v4-pin-notes&gt;</code> , HSPIQ,<br />
HS2_DATA2, SD_DATA2, EMAC_TXD3</div></td>
</tr>
<tr class="odd">
<td><p>13</p></td>
<td><p>IO13</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH4, TOUCH4, RTC_GPIO14, MTCK, HSPID,<br />
HS2_DATA3, SD_DATA3, EMAC_RX_ER</div></td>
</tr>
<tr class="even">
<td><p>14</p></td>
<td><p>IO15</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH3, TOUCH3, RTC_GPIO13, MTDO, HSPICS0<br />
HS2_CMD, SD_CMD, EMAC_RXD3</div></td>
</tr>
<tr class="odd">
<td><p>15</p></td>
<td><p>IO2</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH2, TOUCH2, RTC_GPIO12, HSPIWP,<br />
HS2_DATA0, SD_DATA0</div></td>
</tr>
<tr class="even">
<td><p>16</p></td>
<td><p>IO4</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH0, TOUCH0, RTC_GPIO10, HSPIHD,<br />
HS2_DATA1, SD_DATA1, EMAC_TX_ER</div></td>
</tr>
<tr class="odd">
<td><p>17</p></td>
<td><p>IO0</p></td>
<td><p>I/O</p></td>
<td><div class="line-block">ADC2_CH1, TOUCH1, RTC_GPIO11, CLK_OUT1<br />
EMAC_TX_CLK</div></td>
</tr>
<tr class="even">
<td>18</td>
<td>VDD33 (3V3)</td>
<td>P</td>
<td><div class="line-block">3.3V power supply</div></td>
</tr>
<tr class="odd">
<td>19</td>
<td>GND</td>
<td>P</td>
<td><div class="line-block">Ground</div></td>
</tr>
<tr class="even">
<td>20</td>
<td>EXT_5V (5V)</td>
<td>P</td>
<td><div class="line-block">5V power supply</div></td>
</tr>
</tbody>
</table>

<div class="note">

<div class="title">

Note

</div>

1.  This pin is connected to the flash pin of ESP32-PICO-D4.
2.  32.768 kHz crystal oscillator: a) input, b) output.
3.  This pin is connected to the pin of the USB bridge chip on the
    board.
4.  The operating voltage of ESP32-PICO-KIT’s embedded SPI flash is 3.3
    V. Therefore, the strapping pin MTDI should hold bit zero during the
    module power-on reset. If connected, please make sure that this pin
    is not held up on reset.

</div>

#### Pin Layout

![ESP32-PICO-KIT Pin Layout (click to
enlarge)](esp32-pico-kit-v4-pinout.png)

## Board Dimensions

The dimensions are 52 x 20.3 x 10 mm (2.1" x 0.8" x 0.4").

![ESP32-PICO-KIT dimensions - back (with male
headers)](esp32-pico-kit-v4.1-dimensions-back.jpg)

![ESP32-PICO-KIT dimensions - side (with male
headers)](esp32-pico-kit-v4-dimensions-side.jpg)

For the board physical construction details, please refer to its
Reference Design listed below.

## Related Documents

  - [ESP32-PICO-KIT V4
    schematic](https://dl.espressif.com/dl/schematics/esp32-pico-kit-v4_schematic.pdf)
    (PDF)
  - [ESP32-PICO-KIT V4.1
    schematic](https://dl.espressif.com/dl/schematics/esp32-pico-kit-v4.1_schematic.pdf)
    (PDF)
  - [ESP32-PICO-KIT Reference
    Design](https://www.espressif.com/sites/default/files/documentation/esp32-pico-kit_v4.1_20180314_en.zip)
    containing OrCAD schematic, PCB layout, gerbers and BOM
  - [ESP32-PICO-D4
    Datasheet](https://espressif.com/sites/default/files/documentation/esp32-pico-d4_datasheet_en.pdf)
    (PDF)

## Configurations

All of the configurations presented below can be tested by running the
following commands:

     ./tools/configure.sh esp32-pico-kit:<config_name>
     make flash ESPTOOL_PORT=/dev/ttyUSB0 -j

Where \<config\_name\> is the name of board configuration you want to
use, i.e.: nsh, buttons, wifi... Then use a serial console terminal like
`picocom` configured to 115200 8N1.

### nsh

Basic NuttShell configuration (console enabled in UART0, exposed via USB
connection by means of CP2102 converter, at 115200 bps).
