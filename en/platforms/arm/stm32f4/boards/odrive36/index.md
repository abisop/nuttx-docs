# ODrive V3.6

<div class="tags">

chip:stm32, chip:stm32f4, chip:stm32f405

</div>

ODrive V3.6 is an open-source dual-motor FOC controller based on the
STMicro STM32F405RG and TI DRV8301 gate drivers.

See <https://odriverobotics.com/shop/odrive-v36> for further
information.

For now we support only ODrive V3.6 56V.

## Pin configuration

<table>
<thead>
<tr class="header">
<th>Board Pin</th>
<th>Chip Function</th>
<th>Chip Pin</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>GPIO_1 GPIO_2</p></td>
<td></td>
<td><p>PA0 PA1</p></td>
<td></td>
</tr>
<tr class="even">
<td>GPIO_3</td>
<td>USART2_TX</td>
<td>PA2</td>
<td>Serial TX</td>
</tr>
<tr class="odd">
<td><p>GPIO_4 M1_TEMP AUX_TEMP VBUS_S M1_AL M0_AH M0_BH M0_CH USB_DM USB_DP SWDIO SWCLK GPIO_7</p></td>
<td><p>USART2_RX ADC1_IN4 ADC1_IN5 ADC1_IN6 TIM8 CH1N TIM1 CH1 TIM1 CH2 TIM1 CH3 USB DM USB DP</p></td>
<td><p>PA3 PA4 PA5 PA6 PA7 PA8 PA9 PA10 PA11 PA12 PA13 PA14 PA15</p></td>
<td><p>Serial RX</p></td>
</tr>
<tr class="even">
<td>M0_SO1</td>
<td>ADC2_IN10</td>
<td>PC0</td>
<td>M0 current 1</td>
</tr>
<tr class="odd">
<td>M0_SO2</td>
<td>ADC2_IN11</td>
<td>PC1</td>
<td>M0 current 2</td>
</tr>
<tr class="even">
<td>M1_SO2</td>
<td>ADC3_IN12</td>
<td>PC2</td>
<td>M1 current 2</td>
</tr>
<tr class="odd">
<td><p>M1_SO1 GPIO_5 M0_TEMP M1_AH M1_BH M1_CH M0_ENC_Z</p></td>
<td><p>ADC3_IN13</p>
<p>ADC1_IN15 TIM8 CH1 TIM8 CH2 TIM8 CH3</p></td>
<td><p>PC3 PC4 PC5 PC6 PC7 PC8 PC9</p></td>
<td><p>M1 current 1</p></td>
</tr>
<tr class="even">
<td>SPI_SCK</td>
<td>SPI3_SCK</td>
<td>PC10</td>
<td>DRV8301 M0/M1</td>
</tr>
<tr class="odd">
<td>SPI_MISO</td>
<td>SPI3_MISO</td>
<td>PC11</td>
<td>DRV8301 M0/M1</td>
</tr>
<tr class="even">
<td>SPI_MOSI</td>
<td>SPI3_MOSI</td>
<td>PC12</td>
<td>DRV8301 M0/M1</td>
</tr>
<tr class="odd">
<td>M0_NCS</td>
<td>SPI CS</td>
<td>PC13</td>
<td>DRV8301 M0 CS</td>
</tr>
<tr class="even">
<td><p>M1_NCS M1_ENC_Z M1_BL M1_CL GPIO_6 GPIO_8 M0_ENC_A M0_ENC_B M1_ENC_A M1_ENC_B CAN_R CAN_D AUX_L AUX_H</p></td>
<td><p>SPI CS</p>
<p>TIM8 CH2N TIM8 CH3N</p>
<p>TIM3_CH1IN_2 TIM3_CH2IN_2 TIM4_CH1IN_1 TIM4_CH2IN_1 CAN_R CAN_D</p></td>
<td><p>PC14 PC15 PB0 PB1 PB2 PB3 PB4 PB5 PB6 PB7 PB8 PB9 PB10 PB11</p></td>
<td><p>DRV8301 M1 CS</p></td>
</tr>
<tr class="odd">
<td><p>EN_GATE M0_AL M0_BL M0_CL N_FAULT</p></td>
<td><p>OUT TIM1 CH1N TIM1 CH2N TIM1 CH3N</p></td>
<td><p>PB12 PB13 PB14 PB15 PD2</p></td>
<td><p>M0/M1 DRV8301</p>
<p>M0/M1 DRV8301 N_FAULT</p></td>
</tr>
</tbody>
</table>

## Board hardware configuration

|                            |                              |
| -------------------------- | ---------------------------- |
| Current shunt resistance   | 0.0005                       |
| Current sense gain         | 10/20/40/80                  |
| Vbus min                   | 12V                          |
| Vbus max                   | 24V or 56V                   |
| Iout max                   | 40A (no cooling for MOSFETs) |
| IPHASE\_RATIO              | 1/(R\_shunt\*gain)           |
| VBUS\_RATIO = 1/VBUS\_gain | 11 or 19                     |

## Configurations

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. The
Configuration enables the serial interfaces on USART2. Support for
builtin applications is enabled, but in the base configuration no
builtin applications are selected.

### usbnsh

This is another NSH example. If differs from other 'nsh' configurations
in that this configurations uses a USB serial device for console I/O.
