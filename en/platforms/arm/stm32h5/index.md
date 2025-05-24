ST STM32H5
==========

This is a port of the STM32H5 family. The STM32H5 is a chip based on the
ARM Cortex-M33. Most code is adapted from legacy STM32 and STM32H7.

Development primarily using the Nucleo-H563ZI as of Feb 5th, 2025.
Therefore, at this time only the STM32H563 is truly supported. However,
much of the current support should work for all MCUs. Kconfig will need
updates to support MCUs besides the STM32H563.

Supported MCUs
--------------

+------------------------------+----------------------+------+
| MCU                          | Support              | Note |
+==============================+======================+======+
| STM32H503 STM32H523          | > No No No No Yes No |      |
| STM32H533 STM32H562          |                      |      |
| STM32H563 STM32H573          |                      |      |
+------------------------------+----------------------+------+

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

+----------------------+----------------------+----------------------+
| Peripheral           | Support              | Notes                |
+======================+======================+======================+
| ADC ETH              | Yes Yes              |                      |
+----------------------+----------------------+----------------------+
| FLASH FDCAN GPIO I2C | Yes Yes Yes Yes Yes  | Hardware defines     |
| ICACHE RCC USART     | Yes Yes Yes          | only.                |
| LPUART               |                      |                      |
+----------------------+----------------------+----------------------+
| OCTOSPI              | Yes                  | Implemented as QSPI. |
+----------------------+----------------------+----------------------+
| PWR SPI TIM          | Yes Yes Yes          | Partial.             |
+----------------------+----------------------+----------------------+
| USB\_FS              | Yes                  | USB Device Support.  |
|                      |                      |                      |
| AES CEC CORDIC CRC   | No No No No No No No |                      |
| CRS DAC DBG DCACHE   | No No No No No No No |                      |
| DCMI DLYB DTS EXTI   | No No No No No No No |                      |
| FMAC FSMC GPDMA GTZC | No No No No No No No |                      |
| HASH I3C IWDG LPTIM  | No No No No No No    |                      |
| OTFDEC PKA PSSI      |                      |                      |
| RAMCFG SBS SDMMC RNG |                      |                      |
| RTC SAES SAI TAMP    |                      |                      |
| UCPD VREFBUF WWDG    |                      |                      |
+----------------------+----------------------+----------------------+

References
----------

\[RM0481\] Reference Manual: STM32H523/33xx, STM32H562/63xx, and
STM32H573xx Arm® -based 32-bit MCUs

Support
-------

Supported Boards
----------------

> boards/*/*
