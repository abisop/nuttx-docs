# NXP S32K1XX

The [S32K1XX
series](https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32k-general-purpose-mcus/s32k1-microcontrollers-for-general-purpose:S32K1)
is a family of automotive-grade general-purpose microcontrollers from
NXP Semiconductors. The lower end of the family is based on an Arm
Cortex-M0+ core and can run at clockspeeds up to 48 MHz. The higher end
chips are based on the Arm Cortex-M4F core which runs at up to 80 or 112
MHz.

## Supported MCUs

The following list includes MCUs from the S32K1XX series and indicates
whether they are supported in NuttX:

<table>
<thead>
<tr class="header">
<th>MCU</th>
<th>Support</th>
<th>Core</th>
<th>Frequency</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>S32K116</td>
<td>Yes*</td>
<td>Cortex-M0+</td>
<td><blockquote>
<p>48 MHz</p>
</blockquote></td>
</tr>
<tr class="even">
<td>S32K118</td>
<td>Yes*</td>
<td>Cortex-M0+</td>
<td><blockquote>
<p>48 MHz</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>S32K142</td>
<td>Yes*</td>
<td>Cortex-M4F</td>
<td>112 MHz</td>
</tr>
<tr class="even">
<td>S32K144</td>
<td>Yes</td>
<td>Cortex-M4F</td>
<td>112 MHz</td>
</tr>
<tr class="odd">
<td>S32K146</td>
<td>Yes</td>
<td>Cortex-M4F</td>
<td>112 MHz</td>
</tr>
<tr class="even">
<td>S32K148</td>
<td>Yes</td>
<td>Cortex-M4F</td>
<td>112 MHz</td>
</tr>
<tr class="odd">
<td>S32K142W</td>
<td>No**</td>
<td>Cortex-M4F</td>
<td><blockquote>
<p>80 MHz</p>
</blockquote></td>
</tr>
<tr class="even">
<td>S32K144W</td>
<td>No**</td>
<td>Cortex-M4F</td>
<td><blockquote>
<p>80 MHz</p>
</blockquote></td>
</tr>
</tbody>
</table>

\* Supported but (mostly) untested.  
\*\* Not supported (yet), but it is expected that existing code can be
adapted with limited effort.

## Supported Modules & Peripherals

The following list indicates modules and peripherals supported in NuttX.
Note that this list does not include all MCU modules. Please refer to
the S32K1XX Reference Manual for a complete overview of its features.

| Peripheral                      | Support               | Comments                   |
| ------------------------------- | --------------------- | -------------------------- |
| ADC CMP eDMA                    | No No No              |                            |
| EEPROM ENET                     | Yes Yes               | EEPROM emulated by FlexRAM |
| FlexCAN                         | Yes                   | SocketCAN-compatible       |
| FlexIO                          | Yes                   | Emulated I2C Master driver |
| FTM GPIO                        | Yes Yes               | PWM driver only            |
| LPI2C LPSPI LPUART QSPI RTC SAI | Yes Yes Yes No Yes No | I2C Master and Slave       |

### ADC

12-Bit Successive Approximation (SAR) Analog-to-Digital Converter (ADC).
No driver support (yet).

### CMP

Analog Comparator. No driver support (yet).

### eDMA

Enhanced Direct Memory Access module. There is a driver that was copied
from the i.MX RT port, but this was not tested on S32K1XX.

### EEPROM

Emulated EEPROM (implemented by FlexRAM module). A basic block driver is
available to read and write data.

### ENET

10/100 Mbit/s Ethernet MAC. Only available on S32K148. Driver is
available.

### FlexCAN

The S32K1XX family has up to 3x FlexCAN modules (which may not all have
CAN FD support). A SocketCAN-compatible driver is available.

### FlexIO

A configurable module providing a range of functionality like emulation
of a variety of serial/parallel communication protocols, flexible 16-bit
timers or programmable logic blocks.

The `s32k1xx_flexio_i2c.c` driver implements an emulated I2C master
using FlexIO. Albeit the current implementation has some limitations:

  - Max I2C speed of 400KHz
  - Max transfer of 12 bytes (Could be extended by utilizing EDMA)
  - No abort on NACK reception, shifter simplies continues on
  - No multi-master support
  - No restart support

### FTM

A PWM driver based on FlexTimer (FTM) is available.

### GPIO

Pins can be configured using :c`s32k1xx_pinconfig` function. Writing to
pins is done by :c`s32k1xx_gpiowrite` function and reading is done by
:c`s32k1xx_gpioread`.

### LPI2C

Low-Power Inter-Integrated Circuit (I2C) module supporting an interface
to an I2C bus as master and/or as a slave. The lower-half of this driver
is initialize by calling :c`s32k1xx_i2cbus_initialize`.

### LPSPI

Low-Power Serial Peripheral Interface (SPI) module that supports an
interface to an SPI bus as a master and/or a slave. The lower-half of
this driver is initialize by calling :c`s32k1xx_lpspibus_initialize`.

### LPUART

Low-Power Universal Asynchronous Receiver/Transmitter (UART) module.
UART is initialized automatically during MCU boot.

### QSPI

QuadSPI memory interface for external serial flash devices. No driver
implemented.

### RTC

Real-Time Clock module. A basic driver has been implemented.

### SAI

The Synchronous Audio Interface for digital audio over I2S (Inter-IC
Sound) is only available on S32K148. No driver implemented.

## Supported Boards

> boards/*/*
