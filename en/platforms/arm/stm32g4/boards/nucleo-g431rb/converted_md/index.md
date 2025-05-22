ST Nucleo G431RB
================

::: {.tags}
chip:stm32, chip:stm32g4, chip:stm32g431
:::

The Nucleo G431RB is a member of the Nucleo-64 board family.

Configurations
--------------

### ihm16m1\_f32 and ihm16m1\_b16:

These examples are dedicated for the X-NUCLEO-IHM16M1 expansion board
based on STSPIN830 driver for three-phase brushless DC motors.

X-NUCLEO-IHM16M1 must be configured to work with FOC and 3-shunt
resistors. See ST documentation for details.

Pin configuration for the X-NUCLEO-IHM16M1 (TIM1 configuration):

> +------------------------+------------------------+-----------------+
> | Board Function         | Chip Function          | Chip Pin Number |
> +========================+========================+=================+
> | Phase U high           | TIM1\_CH1              | PA8             |
> +------------------------+------------------------+-----------------+
> | Phase U enable         | GPIO\_PB13             | PB13            |
> +------------------------+------------------------+-----------------+
> | Phase V high           | TIM1\_CH2              | PA9             |
> +------------------------+------------------------+-----------------+
> | Phase V enable         | GPIO\_PB14             | PB14            |
> +------------------------+------------------------+-----------------+
> | Phase W high           | TIM1\_CH3              | PA10            |
> +------------------------+------------------------+-----------------+
> | Phase W enable         | GPIO\_PB15             | PB15            |
> +------------------------+------------------------+-----------------+
> | EN\_FAULT              | GPIO\_PB12             | PB12            |
> +------------------------+------------------------+-----------------+
> | Current U              | GPIO\_ADC1\_IN2        | PA1             |
> +------------------------+------------------------+-----------------+
> | Current V              | GPIO\_ADC1\_IN12       | PB1             |
> +------------------------+------------------------+-----------------+
> | Current W              | GPIO\_ADC1\_IN15       | PB0             |
> +------------------------+------------------------+-----------------+
> | Temperature            | ?                      | PC4             |
> +------------------------+------------------------+-----------------+
> | VBUS BEMF1 BEMF2 BEMF3 | GPIO\_ADC1\_IN1 NU NU  | PA0             |
> | LED +3V3 (CN7\_16) GND | (NU)                   |                 |
> | (CN7\_20) GPIO\_BEMF   |                        |                 |
> | ENCO\_A/HALL\_H1       | (NU)                   |                 |
> | ENCO\_B/HALL\_H2       |                        |                 |
> | ENCO\_Z/HALL\_H3 GPIO1 | (NU) (NU) (NU) (NU)    |                 |
> | GPIO2 GPIO3 CPOUT      | (NU)                   |                 |
> | BKIN1                  |                        |                 |
> +------------------------+------------------------+-----------------+
> | POT CURR\_REF DAC      | GPIO\_ADC1\_IN8 (NU)   | PC2             |
> |                        | (NU)                   |                 |
> +------------------------+------------------------+-----------------+
>
> Current shunt resistance = 0.33 Current sense gain = -1.53 (inverted
> current) Vbus sense gain = 9.31k/(9.31k+169k) = 0.0522124390107 Vbus
> min = 7V Vbus max = 45V Iout max = 1.5A RMS
>
> IPHASE\_RATIO = 1/(R\_shunt\*gain) = -1.98 VBUS\_RATIO = 1/VBUS\_gain
> = 16
>
> For now only 3-shunt resistors configuration is supported.
