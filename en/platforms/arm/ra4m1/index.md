# Renesas RA4M1

## Supported MCUs

The following list includes MCUs from RA4M1 series and indicates whether
they are supported in NuttX

| MCU                                                                                               | Support                 | Note |
| ------------------------------------------------------------------------------------------------- | ----------------------- | ---- |
| R7FA4M1ABxCFP R7FA4M1ABxCLJ R7FA4M1ABxCFM R7FA4M1ABxCNB R7FA4M1ABxCFL R7FA4M1ABxCNE R7FA4M1ABxCNF | Yes No Yes No Yes No No |      |

## Peripheral Support

The following list indicates peripherals supported in NuttX:

<table>
<thead>
<tr class="header">
<th>Peripheral</th>
<th>Support</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>FLASH</td>
<td>No</td>
<td></td>
</tr>
<tr class="even">
<td><p>CLOCK ICU KINT ELC DTC DMAC GPT AGT RTC WDT IWDT</p></td>
<td><p>Yes Yes No No No No No No No No No</p></td>
<td><p>Partially, just internal clock (HOCO)</p></td>
</tr>
<tr class="odd">
<td><p>SCI IIC SPI SSIE QSPI SDHI CAN USBFS ADC14 DAC12 DAC8 ACMPLP OPAMP TSN SLCDC CTSU CRC DOC GPIO</p></td>
<td><p>Yes No No No No No No No No No No No No No No No No No Yes</p></td>
<td><blockquote>
<p>Just UART</p>
</blockquote></td>
</tr>
</tbody>
</table>

### SCI

The Serial Communications Interface (SCI) is configurable to support
several serial communication modes: Asynchronous (UART), Clock
synchronous, Simple SPI Smart card interface, Simple IIC (master-only).
Nuttx driver support UART mode (No-FIFO).

### GPIO

Pins can be configured/operated using `ra_gpio_*` functions.

## Supported Boards

> boards/*/*
