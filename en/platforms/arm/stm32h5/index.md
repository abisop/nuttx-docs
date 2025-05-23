# ST STM32H5

This is a port of the STM32H5 family. The STM32H5 is a chip based on the
ARM Cortex-M33. Most code is adapted from legacy STM32 and STM32H7.

Development primarily using the Nucleo-H563ZI as of Feb 5th, 2025.
Therefore, at this time only the STM32H563 is truly supported. However,
much of the current support should work for all MCUs. Kconfig will need
updates to support MCUs besides the STM32H563.

## Supported MCUs

<table>
<thead>
<tr class="header">
<th>MCU</th>
<th>Support</th>
<th>Note</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>STM32H503 STM32H523 STM32H533 STM32H562 STM32H563 STM32H573</p></td>
<td><blockquote>
<p>No No No No Yes No</p>
</blockquote></td>
<td></td>
</tr>
</tbody>
</table>

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
<td><p>ADC ETH</p></td>
<td><p>Yes Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>FLASH FDCAN GPIO I2C ICACHE RCC USART LPUART</p></td>
<td><p>Yes Yes Yes Yes Yes Yes Yes Yes</p></td>
<td><p>Hardware defines only.</p></td>
</tr>
<tr class="odd">
<td>OCTOSPI</td>
<td>Yes</td>
<td>Implemented as QSPI.</td>
</tr>
<tr class="even">
<td><p>PWR SPI TIM</p></td>
<td><p>Yes Yes Yes</p></td>
<td><p>Partial.</p></td>
</tr>
<tr class="odd">
<td><p>USB_FS</p>
<p>AES CEC CORDIC CRC CRS DAC DBG DCACHE DCMI DLYB DTS EXTI FMAC FSMC GPDMA GTZC HASH I3C IWDG LPTIM OTFDEC PKA PSSI RAMCFG SBS SDMMC RNG RTC SAES SAI TAMP UCPD VREFBUF WWDG</p></td>
<td><p>Yes</p>
<p>No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No</p></td>
<td><p>USB Device Support.</p></td>
</tr>
</tbody>
</table>

## References

\[RM0481\] Reference Manual: STM32H523/33xx, STM32H562/63xx, and
STM32H573xx Arm® -based 32-bit MCUs

## Support

## Supported Boards

> boards/*/*
