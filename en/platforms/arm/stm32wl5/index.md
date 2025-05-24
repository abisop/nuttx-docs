ST STM32WL5
===========

The STM32WL5 is a dual CPU (not core!) chip based on ARM Cortex-M4 and
Cortex-M0 with integrated sub-GHz radio for LoRa (G)FSK, (G)MSK and BPSK
modulations.

Only Cortex-M0 has access to radio peripheral. Pipe between CPUs exists
so that radio packets can be exchanged between CPUs. Chip was designed
so that Cortex-M0 cpu handles radio traffic while Cortex-M4 cpu handles
actions based on traffic received. All other peripherals are shared
(like uart, spi, i2c) and both CPUs can initiate them, but it\'s
required to be done only by one of them.

Supported MCUs
--------------

STM32WL5 has only two chips in family. STM32WL55 and STM32WL54. Only
difference between them is that STM32WL55 has support for LoRa while
Stm32WL54 does not.

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

  Peripheral                                                                              Support                                               Notes
  --------------------------------------------------------------------------------------- ----------------------------------------------------- ---------------------------------------------------------------------
  IRQs GPIO EXTI HSE                                                                      Yes Yes Yes Yes                                       
  PLL                                                                                     Yes                                                   Tested @ 48MHz
  HSI                                                                                     Yes                                                   Not tested
  MSI                                                                                     Yes                                                   Not tested
  LSE                                                                                     Yes                                                   Not tested
  RCC                                                                                     Yes                                                   All registers defined, not all peripherals enabled
  SYSCFG USART                                                                            Yes Yes                                               All registers defined, GPIO EXTI works, remapping not tested
  LPUART                                                                                  Yes                                                   full speed with HSE works, low power mode with LSE not implemented
  FLASH DMA SRAM2 SPI I2C RTC Timers PM AES RNG CRC WWDG IWDG ADC DAC IPCC <Radio@CPU0>   Yes No No No No No No No No No No No No No No No No   Progmem implementation - mtd filesystems like smartfs or nxffs work

### PLL

PLL is a module that allows MCU to generate higher (or lower) clocks
than provided by the source. For example it can be used to drive system
clock with 48MHz when 8MHz HSE crystal is installed.

### LSE

Low speed external crystal. Can be used to clock RTC and/or independent
watchdog (IWDG). LSE is usually 32768Hz high precision crystal.

### HSI

High speed internal clock. Can be used as a source for sysclk and
internal buses (APB, AHB). This clock source is not as precise or as
stable as HSE, but it cuts down costs by avoiding external hardware
(crystal and capacitors) and is usually good enough if operating
temperatures are stable. It\'s clock is fixed at 16MHz.

### MSI

Adjustable internal clock. Can be adjusted by software, but it\'s
accuracy and stability is even lower than HSI.

### HSE

High speed external crystal. Can be used to clock sysclk and internal
buses (APB, AHB). External crystal is more precise and more stable than
HSI.

### RCC

Reset and clock control. Enables or disables specific peripherals.

### SYSCFG

System configuration controller. Can be used to remap memory or manage
GPIO multiplexer for EXTI.

### GPIO

Pins can be configured using :c`stm32wl5_configgpio`{.interpreted-text
role="func"} function. Writing to pins is done by
:c`stm32wl5_gpiowrite`{.interpreted-text role="func"} function and
reading is done by :c`stm32wl5_gpioread`{.interpreted-text role="func"}.

### UART

Universal Asynchronous Receiver/Transmitter module. UART is initialized
automatically during MCU boot.

### IPCC

Inter-processor communication controller. IPCC is used to exchange data
between Cortex-M4 and Cortex-M0 CPUs.

### EXTI

Extended interrupts and event controller. Extends interrupts not
provided by NVIC. For example, there is only one interrupt for GPIO5..9
in NVIC, but thanks to EXTI we can differentiate which GPIO caused
interrupt. Such interrupt first goes through EXTI and is then forwarded
to main NVIC.

EXTI for gpio can be enabled via [stm32wl5\_gpiosetevent]{.title-ref}
function.

### FLASH

Place where program code lives. Part of flash can also be used to create
small filesystems like nxffs or smartfs to hold persistent data between
reboots without the need of attaching external flash or mmc card. Since
flash has limited number of erases (writes) it\'s best to hold there
only data that is no frequently updated (so, configuration is ok, logs
are not).

Supported Boards
----------------

> boards/*/*
