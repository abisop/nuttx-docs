# ST Nucleo G431RB

<div class="tags">

chip:stm32, chip:stm32g4, chip:stm32g431

</div>

The Nucleo G431RB is a member of the Nucleo-64 board family.

## Configurations

### ihm16m1\_f32 and ihm16m1\_b16:

These examples are dedicated for the X-NUCLEO-IHM16M1 expansion board
based on STSPIN830 driver for three-phase brushless DC motors.

X-NUCLEO-IHM16M1 must be configured to work with FOC and 3-shunt
resistors. See ST documentation for details.

Pin configuration for the X-NUCLEO-IHM16M1 (TIM1 configuration):

> 
> 
> <table>
> <thead>
> <tr class="header">
> <th>Board Function</th>
> <th>Chip Function</th>
> <th>Chip Pin Number</th>
> </tr>
> </thead>
> <tbody>
> <tr class="odd">
> <td>Phase U high</td>
> <td>TIM1_CH1</td>
> <td>PA8</td>
> </tr>
> <tr class="even">
> <td>Phase U enable</td>
> <td>GPIO_PB13</td>
> <td>PB13</td>
> </tr>
> <tr class="odd">
> <td>Phase V high</td>
> <td>TIM1_CH2</td>
> <td>PA9</td>
> </tr>
> <tr class="even">
> <td>Phase V enable</td>
> <td>GPIO_PB14</td>
> <td>PB14</td>
> </tr>
> <tr class="odd">
> <td>Phase W high</td>
> <td>TIM1_CH3</td>
> <td>PA10</td>
> </tr>
> <tr class="even">
> <td>Phase W enable</td>
> <td>GPIO_PB15</td>
> <td>PB15</td>
> </tr>
> <tr class="odd">
> <td>EN_FAULT</td>
> <td>GPIO_PB12</td>
> <td>PB12</td>
> </tr>
> <tr class="even">
> <td>Current U</td>
> <td>GPIO_ADC1_IN2</td>
> <td>PA1</td>
> </tr>
> <tr class="odd">
> <td>Current V</td>
> <td>GPIO_ADC1_IN12</td>
> <td>PB1</td>
> </tr>
> <tr class="even">
> <td>Current W</td>
> <td>GPIO_ADC1_IN15</td>
> <td>PB0</td>
> </tr>
> <tr class="odd">
> <td>Temperature</td>
> <td>?</td>
> <td>PC4</td>
> </tr>
> <tr class="even">
> <td><p>VBUS BEMF1 BEMF2 BEMF3 LED +3V3 (CN7_16) GND (CN7_20) GPIO_BEMF ENCO_A/HALL_H1 ENCO_B/HALL_H2 ENCO_Z/HALL_H3 GPIO1 GPIO2 GPIO3 CPOUT BKIN1</p></td>
> <td><p>GPIO_ADC1_IN1 NU NU (NU)</p>
> <p>(NU)</p>
> <p>(NU) (NU) (NU) (NU) (NU)</p></td>
> <td><p>PA0</p></td>
> </tr>
> <tr class="odd">
> <td><p>POT CURR_REF DAC</p></td>
> <td><p>GPIO_ADC1_IN8 (NU) (NU)</p></td>
> <td><p>PC2</p></td>
> </tr>
> </tbody>
> </table>
> 
> Current shunt resistance = 0.33 Current sense gain = -1.53 (inverted
> current) Vbus sense gain = 9.31k/(9.31k+169k) = 0.0522124390107 Vbus
> min = 7V Vbus max = 45V Iout max = 1.5A RMS
> 
> IPHASE\_RATIO = 1/(R\_shunt\*gain) = -1.98 VBUS\_RATIO = 1/VBUS\_gain
> = 16
> 
> For now only 3-shunt resistors configuration is supported.
