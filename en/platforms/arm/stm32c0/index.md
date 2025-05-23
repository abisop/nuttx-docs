# ST STM32C0

## Supported MCUs

| MCU                 | Support | Note                    |
| ------------------- | ------- | ----------------------- |
| STM32C051           | Yes     |                         |
| STM32C071 STM32C091 | Yes Yes | USB not supported yet   |
| STM32C092           | Yes     | FDCAN not supported yet |

## Peripheral Support

The following list indicates peripherals supported in NuttX:

| Peripheral                                                                                       | Support                                                                 | Notes |
| ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- | ----- |
| FLASH PM RCC CSR GPIO SYSCFG DMA DMAMUX EXTI CRC ADC TIM IRTIM IWDG WWDG I2C USART SPI FDCAN USB | No No Yes No Yes No Yes Yes Yes No Yes Yes No Yes Yes Yes Yes Yes No No |       |

## Supported Boards

> boards/*/*
