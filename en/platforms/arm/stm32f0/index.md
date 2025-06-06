ST STM32F0
==========

Supported MCUs
--------------

The following list includes MCUs from STM32F0 series and indicates
whether they are supported in NuttX

  MCU         Support   Note
  ----------- --------- ------------------
  STM32F0x0   Yes       Value line
  STM32F0x1   Yes       Access line
  STM32F0x2   Yes       USB line
  STM32F0x8   Yes       Low-voltage line

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

  Peripheral                                                                                                              Support                                                                                   Notes
  ----------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------- -------
  FLASH CRC PM RCC CSR GPIO SYSCFG DMA EXTI ADC DAC COMP TSC TIM IRTIM IWDG WWDG RTC I2C USART SPI I2S CAN USB HDMI-CEC   No No No Yes No Yes Yes Yes Yes Yes No No No Yes No Yes Yes No Yes Yes Yes No No Yes No   

Flashing and Debugging
----------------------

NuttX firmware Flashing with STLink probe and OpenOCD:

    openocd -f  interface/stlink.cfg -f target/stm32f0x.cfg -c 'program nuttx.bin 0x08000000; reset run; exit'

Remote target Reset with STLink probe and OpenOCD:

    openocd -f interface/stlink.cfg -f target/stm32f0x.cfg -c 'init; reset run; exit'

Remote target Debug with STLink probe and OpenOCD:

> 1.  You need to have NuttX built with debug symbols, see
>     `debugging`{.interpreted-text role="ref"}.
>
> 2.  Launch the OpenOCD GDB server:
>
>         openocd -f interface/stlink.cfg -f target/stm32f0x.cfg -c 'init; reset halt'
>
> 3.  You can now attach to remote OpenOCD GDB server with your favorite
>     debugger, for instance gdb:
>
>         arm-none-eabi-gdb --tui nuttx -ex 'target extended-remote localhost:3333'
>         (gdb) monitor reset halt
>         (gdb) breakpoint nsh_main
>         (gdb) continue

Supported Boards
----------------

> boards/*/*
