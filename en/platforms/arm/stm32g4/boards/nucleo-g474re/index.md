ST Nucleo G474RE
================

chip:stm32, chip:stm32g4, chip:stm32g474

This is the page for a port of NuttX to the ST Micro Nucleo G474RE board
with STM32G474RE MCU. For more information about this board, see:

> <https://www.st.com/en/evaluation-tools/nucleo-g474re.html>

Development Environment
-----------------------

### Toolchains

An appropriate ARM toolchain is needed, such as the one built with the
customized NuttX buildroot or the ready-made GNU Tools for Arm Embedded
Processors.

### Debugging

The board incorporates a STLINK-V3E programmer/debugger accessible via
the Micro-USB Type B connector.

To debug with OpenOCD and arm-nuttx-eabi-gdb:

-   Use \'make menuconfig\' to set CONFIG\_DEBUG\_SYMBOLS and
    CONFIG\_DEBUG\_NOOPT. To see debug output, e.g., the \"ABCDE\"
    printed in \_\_start(), also set CONFIG\_DEBUG\_FEATURES.

-   Build NuttX.

-   Flash the code using:

         openocd -f interface/stlink.cfg -f target/stm32g4x.cfg -c init \
        -c "reset halt" -c "flash write_image erase nuttx.bin 0x08000000"

-   Start GDB with:

         arm-nuttx-eabi-gdb -tui nuttx

-   In GDB:

        (gdb) target remote localhost:3333
        (gdb) monitor reset halt
        (gdb) load

Hardware
--------

### MCU Clocking

By default, the MCU on this board is clocked from the MCU\'s internal
HSI clock, and only this option is supported by software at this time.

If software support is added for it, the MCU could be clocked from the
following other sources: a 24 MHz oscillator on X2, MCO from STLINK-V3E,
or external clock from connector CN9, pin 26.

### GPIOs

### Buttons

The board has 1 user button.

### LEDs

The board has 1 user LED.

Serial Consoles
---------------

The MCU\'s USART3 is exposed to the pin 1 and 2 of the \"Morpho
connector\" CN7 on the board.

FLASH Bootloader Support
------------------------

If implementing a FLASH bootloader, turn on Kconfig option
CONFIG\_STM32\_DFU. This option activates an alternate linker script,
scripts/ld.script.dfu, which causes NuttX to leave a gap at the start of
FLASH, leaving that space for the FLASH bootloader. See
scripts/ld.script.dfu for details. It also causes NuttX to relocate its
vector table and possibly make other adjustments.

One possible bootloader is STmicro\'s OpenBootloader \"middleware\"
supplied with STM32CubeG4 version 1.3.0. On the host (PC), it should be
possible to use STmicro\'s STM32CubeProgrammer or the stm32loader.py
script from <https://github.com/jsnyder/stm32loader>. That script can be
invoked with parameters such as:

    stm32loader.py -p /dev/ttyACM0 -a 0x08006000 -e -w -v -g 0x08006000 nuttx.bin

where the given address (0x08006000 in this case) must match the
starting address in scripts/ld.script.dfu.
