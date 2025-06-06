Olimex STM32-P207
=================

chip:stm32, chip:stm32f4, chip:stm32f405

The NuttX configuration for the Olimex STM32-H405 is based on the
configuration Olimex STM32-P207.

It was tested with the NuttX EABI \"buildroot\" Toolchain.

Debugging with OpenOCD via an Olimex ARM-USB-TINY-H works. Note that
CONFIG\_DEBUG\_SYMBOLS and
CONFIG\_STM32\_DISABLE\_IDLE\_SLEEP\_DURING\_DEBUG are enabled so that
the JTAG connection is not disconnected by the idle loop.

Make sure that \'\# CONFIG\_NSH\_CONDEV is not set\' is in the .config
file - it defaults to \'/dev/console\' which makes problems with the
shell over USB.

The following peripherals are enabled in this configuration. - LED:
Shows the system status

-   Button: Built in app \'buttons\' works.
-   ADC: ADC1 samples ADC\_IN1. Built in app \'adc\' works.
-   USB-FS-OTG: The console is running on the virtual serial port. Note
    that you have to press enter three times until NSH appears.
-   CAN:Built in app \'can\' is enabled but not tested, since no CAN
    transceiver is on board.
