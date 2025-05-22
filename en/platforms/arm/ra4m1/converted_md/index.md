Renesas RA4M1
=============

Supported MCUs
--------------

The following list includes MCUs from RA4M1 series and indicates whether
they are supported in NuttX

  MCU                                                                                                 Support                   Note
  --------------------------------------------------------------------------------------------------- ------------------------- ------
  R7FA4M1ABxCFP R7FA4M1ABxCLJ R7FA4M1ABxCFM R7FA4M1ABxCNB R7FA4M1ABxCFL R7FA4M1ABxCNE R7FA4M1ABxCNF   Yes No Yes No Yes No No   

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

+----------------------+----------------------+----------------------+
| Peripheral           | Support              | Notes                |
+======================+======================+======================+
| FLASH                | No                   |                      |
+----------------------+----------------------+----------------------+
| CLOCK ICU KINT ELC   | Yes Yes No No No No  | Partially, just      |
| DTC DMAC GPT AGT RTC | No No No No No       | internal clock       |
| WDT IWDT             |                      | (HOCO)               |
+----------------------+----------------------+----------------------+
| SCI IIC SPI SSIE     | Yes No No No No No   | > Just UART          |
| QSPI SDHI CAN USBFS  | No No No No No No No |                      |
| ADC14 DAC12 DAC8     | No No No No No Yes   |                      |
| ACMPLP OPAMP TSN     |                      |                      |
| SLCDC CTSU CRC DOC   |                      |                      |
| GPIO                 |                      |                      |
+----------------------+----------------------+----------------------+

### SCI

The Serial Communications Interface (SCI) is configurable to support
several serial communication modes: Asynchronous (UART), Clock
synchronous, Simple SPI Smart card interface, Simple IIC (master-only).
Nuttx driver support UART mode (No-FIFO).

### GPIO

Pins can be configured/operated using `ra_gpio_*` functions.

Supported Boards
----------------

::: {.toctree glob="" maxdepth="1"}
boards/*/*
:::
