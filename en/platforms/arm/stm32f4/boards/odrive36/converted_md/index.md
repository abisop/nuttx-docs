ODrive V3.6
===========

::: {.tags}
chip:stm32, chip:stm32f4, chip:stm32f405
:::

ODrive V3.6 is an open-source dual-motor FOC controller based on the
STMicro STM32F405RG and TI DRV8301 gate drivers.

See <https://odriverobotics.com/shop/odrive-v36> for further
information.

For now we support only ODrive V3.6 56V.

Pin configuration
-----------------

+----------------+----------------+----------------+----------------+
| Board Pin      | Chip Function  | Chip Pin       | Notes          |
+================+================+================+================+
| GPIO\_1        |                | PA0 PA1        |                |
| GPIO\_2        |                |                |                |
+----------------+----------------+----------------+----------------+
| GPIO\_3        | USART2\_TX     | PA2            | Serial TX      |
+----------------+----------------+----------------+----------------+
| GPIO\_4        | USART2\_RX     | PA3 PA4 PA5    | Serial RX      |
| M1\_TEMP       | ADC1\_IN4      | PA6 PA7 PA8    |                |
| AUX\_TEMP      | ADC1\_IN5      | PA9 PA10 PA11  |                |
| VBUS\_S M1\_AL | ADC1\_IN6 TIM8 | PA12 PA13 PA14 |                |
| M0\_AH M0\_BH  | CH1N TIM1 CH1  | PA15           |                |
| M0\_CH USB\_DM | TIM1 CH2 TIM1  |                |                |
| USB\_DP SWDIO  | CH3 USB DM USB |                |                |
| SWCLK GPIO\_7  | DP             |                |                |
+----------------+----------------+----------------+----------------+
| M0\_SO1        | ADC2\_IN10     | PC0            | M0 current 1   |
+----------------+----------------+----------------+----------------+
| M0\_SO2        | ADC2\_IN11     | PC1            | M0 current 2   |
+----------------+----------------+----------------+----------------+
| M1\_SO2        | ADC3\_IN12     | PC2            | M1 current 2   |
+----------------+----------------+----------------+----------------+
| M1\_SO1        | ADC3\_IN13     | PC3 PC4 PC5    | M1 current 1   |
| GPIO\_5        |                | PC6 PC7 PC8    |                |
| M0\_TEMP       | ADC1\_IN15     | PC9            |                |
| M1\_AH M1\_BH  | TIM8 CH1 TIM8  |                |                |
| M1\_CH         | CH2 TIM8 CH3   |                |                |
| M0\_ENC\_Z     |                |                |                |
+----------------+----------------+----------------+----------------+
| SPI\_SCK       | SPI3\_SCK      | PC10           | DRV8301 M0/M1  |
+----------------+----------------+----------------+----------------+
| SPI\_MISO      | SPI3\_MISO     | PC11           | DRV8301 M0/M1  |
+----------------+----------------+----------------+----------------+
| SPI\_MOSI      | SPI3\_MOSI     | PC12           | DRV8301 M0/M1  |
+----------------+----------------+----------------+----------------+
| M0\_NCS        | SPI CS         | PC13           | DRV8301 M0 CS  |
+----------------+----------------+----------------+----------------+
| M1\_NCS        | SPI CS         | PC14 PC15 PB0  | DRV8301 M1 CS  |
| M1\_ENC\_Z     |                | PB1 PB2 PB3    |                |
| M1\_BL M1\_CL  | TIM8 CH2N TIM8 | PB4 PB5 PB6    |                |
| GPIO\_6        | CH3N           | PB7 PB8 PB9    |                |
| GPIO\_8        |                | PB10 PB11      |                |
| M0\_ENC\_A     | TIM3\_CH1IN\_2 |                |                |
| M0\_ENC\_B     | TIM3\_CH2IN\_2 |                |                |
| M1\_ENC\_A     | TIM4\_CH1IN\_1 |                |                |
| M1\_ENC\_B     | TIM4\_CH2IN\_1 |                |                |
| CAN\_R CAN\_D  | CAN\_R CAN\_D  |                |                |
| AUX\_L AUX\_H  |                |                |                |
+----------------+----------------+----------------+----------------+
| EN\_GATE       | OUT TIM1 CH1N  | PB12 PB13 PB14 | M0/M1 DRV8301  |
| M0\_AL M0\_BL  | TIM1 CH2N TIM1 | PB15 PD2       |                |
| M0\_CL         | CH3N           |                | M0/M1 DRV8301  |
| N\_FAULT       |                |                | N\_FAULT       |
+----------------+----------------+----------------+----------------+

Board hardware configuration
----------------------------

  ---------------------------- ------------------------------
  Current shunt resistance     0.0005
  Current sense gain           10/20/40/80
  Vbus min                     12V
  Vbus max                     24V or 56V
  Iout max                     40A (no cooling for MOSFETs)
  IPHASE\_RATIO                1/(R\_shunt\*gain)
  VBUS\_RATIO = 1/VBUS\_gain   11 or 19
  ---------------------------- ------------------------------

Configurations
--------------

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. The
Configuration enables the serial interfaces on USART2. Support for
builtin applications is enabled, but in the base configuration no
builtin applications are selected.

### usbnsh

This is another NSH example. If differs from other \'nsh\'
configurations in that this configurations uses a USB serial device for
console I/O.
