ST Nucleo F302R8
================

::: {.tags}
chip:stm32, chip:stm32f3, chip:stm32f302
:::

The Nucleo F302R8 is a member of the Nucleo-64 board family.

Configurations
--------------

### ihm07m1\_f32 and ihm07m1\_b16:

These examples are dedicated for the X-NUCLEO-IHM07M1 expansion board
based on L6230 DMOS driver for three-phase brushless DC motors.

X-NUCLEO-IHM07M1 must be configured to work with FOC and 3-shunt
resistors. See ST documentation for details.

Pin configuration for the X-NUCLEO-IHM07M1 (TIM1 configuration):

>   Board Function                     Chip Function   Chip Pin Number
>   ---------------------------------- --------------- -----------------
>   Phase U high                       TIM1\_CH1       PA8
>   Phase U enable                     GPIO\_PC10      PC10
>   Phase V high                       TIM1\_CH2       PA9
>   Phase V enable                     GPIO\_PC11      PC11
>   Phase W high                       TIM1\_CH3       PA10
>   Phase W enable                     GPIO\_PC12      PC12
>   DIAG/EN                            GPIO\_PA11      PA11
>   Current U                          ADC1\_IN1       PA0
>   Current V                          ADC1\_IN7       PC1
>   Current W                          ADC1\_IN6       PC0
>   Temperature                        ADC1\_IN8       PC2
>   VBUS                               ADC1\_IN2       PA1
>   BEMF1                              (NU)            PC3
>   BEMF2                              (NU)            PB0
>   BEMF3                              (NU)            PA7
>   LED +3V3 (CN7\_16) GND (CN7\_20)   GPIO\_PB2       PB2
>   GPIO\_BEMF                         (NU)            PC9
>   ENCO\_A/HALL\_H1                   TIM2\_CH1       PA15
>   ENCO\_B/HALL\_H2                   TIM2\_CH2       PB3
>   ENCO\_Z/HALL\_H3                   TIM2\_CH3       PB10
>   GPIO1                              (NU)            PB13
>   GPIO2                              (NU)            PB5
>   GPIO3                              (NU)            PA5
>   CPOUT                              (NU)            PA12
>   BKIN1                              (NU)            PB14
>   POT                                ADC1\_IN12      PB1
>   CURR\_REF                          (NU)            PB4
>   DAC                                DAC1\_CH1       PA4
>   DEBUG0                             GPIO            PB8
>   DEBUG1                             GPIO            PB9
>   DEBUG2                             GPIO            PC6
>   DEBUG3                             GPIO            PC5
>   DEBUG4                             GPIO            PC8
>
> Current shunt resistance = 0.33 Current sense gain = -1.53 (inverted
> current) Vbus sense gain = 9.31k/(9.31k+169k) = 0.0522124390107 Vbus
> min = 8V Vbus max = 48V Iout max = 1.4A RMS
>
> IPHASE\_RATIO = 1/(R\_shunt\*gain) = -1.98 VBUS\_RATIO = 1/VBUS\_gain
> = 19.152
>
> For now only 3-shunt resistors configuration is supported.
