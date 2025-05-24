ST B-G431B-ESC
==============

chip:stm32, chip:stm32g4, chip:stm32g431

The B-G431B-ESC board is based on the STM32G431CB microcontroller, the
L6387 driver and STL180N6F7 power MOSFETs.

UART/USART PINS
---------------

USART2 is accessible through J3 pads and ST LINK Virtual Console:

    USART2_TX - PB3
    USART2_RX - PB4

Configuration Sub-directories
-----------------------------

nsh:
----

Configures the NuttShell (nsh) located at apps/examples/nsh. The
Configuration enables the serial interfaces on USART2.

foc\_f32 and foc\_b16:
----------------------

FOC examples based on hardware on board.

Pin configuration:

>   Board Function                 Chip Function   Chip Pin Number
>   ------------------------------ --------------- -----------------
>   Phase U high                   TIM1\_CH1       PA8
>   Phase U low                    TIM1\_CH1N      PC13
>   Phase V high                   TIM1\_CH2       PA9
>   Phase V low                    TIM1\_CH2N      PA12
>   Phase W high                   TIM1\_CH3       PA10
>   Phase W low                    TIM1\_CH3N      PB15
>   Current U +                    OPAMP1\_VINP    PA1
>   Current U -                    OPAMP1\_VINM    PA3
>   Current V +                    OPAMP2\_VINP    PA7
>   Current V -                    OPAMP2\_VINM    PA5
>   Current W +                    OPAMP3\_VINP    PB0
>   Current W -Temperature         OPAMP3\_VINM    PB2 PB14
>   VBUS                           ADC1\_IN1       PA0
>   POT                            ADC1\_IN11      PB12
>   LED                            GPIO\_PC6       PC6
>   ENCO\_A/HALL\_H1               TIM4\_CH1       PB6
>   ENCO\_B/HALL\_H2               TIM4\_CH2       PB7
>   ENCO\_Z/HALL\_H3               TIM4\_CH3       PB8
>   BUTTON PWM                     GPIO\_PC10      PC10 PA15
>   CAN\_RX                        FDCAN1\_RX      PA11
>   CAN\_TX CAN\_TERM GPIO\_BEMF   FDCAN1\_TX      PB9 PC14 PB5
>   BEMF1                          ADC2\_IN17      PA4
>   BEMF2                          ADC2\_IN5       PC4
>   BEMF3                          ADC2\_IN14      PB11
>
> Current shunt resistance = 0.003 PGA gain = 16 Current sense gain =
> -9.14 (inverted current) Vbus sense gain = 18k/(18k+169k) = 0.0962
> Vbus min = ? Vbus max = 25V Iout max = 40A peak BEMF sense gain =
> 2.2k/(10k+2.2k) = 0.18
>
> IPHASE\_RATIO = 1/(R\_shunt\*gain) = -36.47 VBUS\_RATIO = 1/VBUS\_gain
> = 10.4
