Waveshare OpenH743I
===================

chip:stm32, chip:stm32h7, chip:stm32h743

The OpenH743I-C is an STM32 development board with STM32H743IIT6. It
comes with a rich expansion interface to support access to various
peripheral modules.

Note

This board has very poor signal integrity.

Peripherals
-----------

### SDMMC

The SDMMC1 interface seems not to work correctly with clock frequencies
higher than 20 MHz.

### USBHS

The reset pin on the ULPI port must be connected to the PE2 pin of the
MCU. If it\'s not connected, ULPI interface may not work correctly
without power reset.
