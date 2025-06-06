Olimex STM32-P207
=================

chip:stm32, chip:stm32f2, chip:stm32f207

The NuttX configuration for the Olimex STM32-P207 is assembled mainly
from the configurations stm32f4discovery and stm3240g-eval.

It was tested with the NuttX EABI \"buildroot\" Toolchain.

Debugging with OpenOCD via an Olimex ARM-USB-TINY-H works. Note that
CONFIG\_DEBUG\_SYMBOLS and
CONFIG\_STM32\_DISABLE\_IDLE\_SLEEP\_DURING\_DEBUG are enabled so that
the JTAG connection is not disconnected by the idle loop.

The following peripherals are enabled in this configuration.

-   LEDs: show the system status
-   Buttons: TAMPER-button, WKUP-button, J1-Joystick (consists of
    RIGHT-, UP-, LEFT-, DOWN-, and CENTER-button). Built in app
    \'buttons\' works.
-   ADC: ADC1 samples the red trim potentiometer AN\_TR Built in app
    \'adc\' works.
-   USB-FS-OTG: Enabled but not really tested, since there is only a
    USB-A-connector (host) connected to the full speed STM32 inputs.
-   USB-HS\_OTG:The other connector (device) is connected to the high
    speed STM32 inputs (not enabled).
-   CAN: Built in app \'can\' works, but apart from that not really
    tested.
-   Ethernet: Ping to other station on the network works.
