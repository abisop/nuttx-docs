# ST STM32H7

## Supported MCUs

Dual-core lines:

| MCU                                     | Support           | Note             |
| --------------------------------------- | ----------------- | ---------------- |
| STM32H747 STM32H757 STM32H745 STM32H755 | Partial No Yes No | Only STM32H747XI |

Single-core lines:

| MCU                                                                             | Support                        | Note             |
| ------------------------------------------------------------------------------- | ------------------------------ | ---------------- |
| STM32H7A3                                                                       | No                             |                  |
| STM32H7B3 STM32H743 STM32H753 STM32H742 STM32H725 STM32H735 STM32H723 STM32H733 | Partial Yes Yes No No No No No | Only STM32H7B3LI |

Value lines:

| MCU                           | Support  | Note |
| ----------------------------- | -------- | ---- |
| STM32H7B0 STM32H750 STM32H730 | No No No |      |

## Peripheral Support

The following list indicates peripherals supported in NuttX:

| Peripheral                                                                                                                                                                                                                                                                  | Support                                                                                                                                                                      | Notes |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| RAMECC FLASH SMM PM RCC CRS HSEM GPIO SYSCFG MDMA DMA BDMA DMA2D EXTI CRC FMC QUADSPI DLYB ADC DAC VREFBUF COMP OPAMP DFSDM DCMI LTDC JPEG RNG CRYP HASH HRTIM TIM LPTIM IWDG WWDG RTC I2C USART SPI I2S SAI SPIDIFRX SWPMI MDIOS SDMMC FDCAN OTG\_FS OTG\_HS ETH HDMI\_CEC | No Yes No ? Yes No Yes Yes Yes ? Yes Yes Yes Yes Yes Yes Yes No Yes Yes No No No No No Yes No Yes No ? No Yes No Yes Yes Yes Yes Yes Yes ? No No No ? Yes Yes Yes Yes Yes No |       |

## Dual-core support

Some of the STM32H7 chips have an additional Cortex-M4 core built-in.
The selection of the core for which the image is build is made using
options:

>   - `CONFIG_ARCH_CHIP_STM32H7_CORTEXM7` - selects Cortex-M7 core
>   - `CONFIG_ARCH_CHIP_STM32H7_CORTEXM4` - selects Cortex-M4 core

Support for the CM7 core is always enabled, support for the CM4 core is
controlled with the `CONFIG_STM32H7_CORTEXM4_ENABLED` option.

Interprocessor communication between cores is realized with the NuttX
RPTUN device based on the OpenAMP framework. `HSEM` is used for
synchronization and notification between cores.

32kB of the SRAM3 is reserved for shared memory and this is the only
available option at the moment.

## Supported Boards

> boards/*/*
