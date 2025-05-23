# ST STM32L4

## Supported MCUs

This is a port of NuttX to the STM32L4 Family

Used development boards are the Nucleo L476RG, Nucleo L496ZG, Nucleo
L452RE, Nucleo L432KC, STM32L4VG Discovery and Motorola MDK.

Most code is copied and adapted from the STM32 and STM32F7 ports.

The various supported STM32L4 families are:

| MCU                 | Support | Manual        | Note                               |
| ------------------- | ------- | ------------- | ---------------------------------- |
| STM32L471xx         | No      | RM0392        |                                    |
| STM32L4X1           | Yes     | RM0394        | Subset of STM32L4\_STM32L4X3 \[1\] |
| STM32L4X2 STM32L4X3 | Yes Yes | RM0394 RM0394 | Subset of STM32L4\_STM32L4X3 \[1\] |
| STM32L4X5 STM32L4X6 | Yes Yes | RM0351 RM0351 | (was RM0395 in past)               |
| STM32L4XR           | Yes     | RM0432        | (STM32L4+)                         |

\[1\]: Please avoid depending on CONFIG\_STM32L4\_STM32L4X1 and
CONFIG\_STM32L4\_STM32L4X2 as the MCUs are of the same subfamily as
CONFIG\_STM32L4\_STM32L4X3.

## Peripheral Support

The following list indicates peripherals supported in NuttX:

| Peripheral                                                                               | Support                                                                   | Notes                   |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ----------------------- |
| IRQs GPIO EXTI HSI HSE                                                                   | Yes Yes Yes Yes Yes                                                       |                         |
| PLL MSI LSE RCC SYSCTL USART DMA SRAM2 SPI I2C RTC QSPI CAN OTGFS Timers PM FSMC AES RNG | Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes No No Yes | Works @ 80 MHz          |
| CRC WWDG IWDG SDMMC ADC DAC DMA2D                                                        | No No Yes Yes Yes Yes No                                                  | configurable polynomial |

| Peripheral                                                              | Support                                       | Notes                          |
| ----------------------------------------------------------------------- | --------------------------------------------- | ------------------------------ |
| FIREWALL TSC SWP LPUART LPTIM OPAMP COMP DFSDM LCD SAIPLL SAI HASH DCMI | Yes No No Yes Yes No Yes Yes No Yes Yes No No | requires support from ldscript |

New peripherals only in STM32L4+:

| Peripheral                                 | Support            | Notes |
| ------------------------------------------ | ------------------ | ----- |
| DMAMUX1 DSI GFXMMU LTDC OCTOSPI OCTOSPIIOM | Yes No No No No No |       |

## Flashing and Debugging

NuttX firmware Flashing with STLink probe and OpenOCD:

    openocd -f  interface/stlink.cfg -f target/stm32l4x.cfg -c 'program nuttx.bin 0x08000000; reset run; exit'

Remote target Reset with STLink probe and OpenOCD:

    openocd -f interface/stlink.cfg -f target/stm32l4x.cfg -c 'init; reset run; exit'

Remote target Debug with STLink probe and OpenOCD:

> 1.  You need to have NuttX built with debug symbols, see `debugging`.
> 
> 2.  Launch the OpenOCD GDB server:
>     
>         openocd -f interface/stlink.cfg -f target/stm32l4x.cfg -c 'init; reset halt'
> 
> 3.  You can now attach to remote OpenOCD GDB server with your favorite
>     debugger, for instance gdb:
>     
>         arm-none-eabi-gdb --tui nuttx -ex 'target extended-remote localhost:3333'
>         (gdb) monitor reset halt
>         (gdb) breakpoint nsh_main
>         (gdb) continue

## Supported Boards

> boards/*/*
