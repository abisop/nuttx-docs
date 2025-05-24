STM32 Tiny
==========

chip:stm32, chip:stm32f1, chip:stm32f103

This page discusses issues unique to NuttX configurations for the STM32
Tiny development board.

This board is available from several vendors on the net, and may be sold
under different names. It is based on a STM32 F103C8T6 MCU, and is
(always ?) bundled with a nRF24L01 wireless communication module.

LEDs
----

The STM32Tiny board has only one software controllable LED. This LED can
be used by the board port when CONFIG\_ARCH\_LEDS option is enabled.

If enabled the LED is simply turned on when the board boots
successfully, and is blinking on panic / assertion failed.

PWM
---

The STM32 Tiny has no real on-board PWM devices, but the board can be
configured to output a pulse train using TIM3 CH2 on the GPIO line B.5
(connected to the LED). Please note that the
CONFIG\_STM32\_TIM3\_PARTIAL\_REMAP option must be enabled in this case.

UARTs
-----

### UART/USART PINS

    USART1
      RX      PA10
      TX      PA9
    USART2
      CK      PA4
      CTS     PA0*
      RTS     PA1
      RX      PA3
      TX      PA2
    USART3
      CK      PB12*
      CTS     PB13*
      RTS     PB14*
      RX      PB11
      TX      PB10

-   these IO lines are intended to be used by the wireless module on the
    board.

### Default USART/UART Configuration

USART1 (RX & TX only) is available through the RS-232 port on the board.
A MAX232 chip converts voltage to RS-232 level. This serial port can be
used to flash a firmware using the boot loader integrated in the MCU.

Timer Inputs/Outputs
--------------------

TIM1

:   CH1 PA8 CH2 PA9\* CH3 PA10\* CH4 PA11\*

TIM2

:   CH1 PA0\*, PA15, PA5 CH2 PA1, PB3 CH3 PA2, PB10\* CH4 PA3, PB11

TIM3

:   CH1 PA6, PB4 CH2 PA7, PB5\* CH3 PB0 CH4 PB1\*

TIM4

:   CH1 PB6\* CH2 PB7 CH3 PB8 CH4 PB9\*

    \* Indicates pins that have other on-board functions and should be used only

    :   with care (See board datasheet).

STM32 Tiny - specific Configuration Options
-------------------------------------------

Configurations
--------------

Each STM32Tiny configuration is maintained in a sub-directory and can be
selected as follow:

> tools/configure.sh STM32Tiny:\<subdir\>

Where \<subdir\> is one of the following:

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. This
configuration enables a console on UART1. Support for builtin
applications is enabled, but in the base configuration no builtin
applications are selected (see NOTES below).

NOTES:

### usbnsh

This is another NSH example. If differs from other \'nsh\'
configurations in that this configurations uses a USB serial device for
console I/O.

NOTES:
