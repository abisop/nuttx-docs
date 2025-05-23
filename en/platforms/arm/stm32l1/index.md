# ST STM32L1

## Supported MCUs

TODO

## Peripheral Support

The following list indicates peripherals supported in NuttX:

| Peripheral                                                                                                 | Support                                                                     | Notes |
| ---------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- | ----- |
| FLASH PM RCC GPIO SYSCFG EXTI DMA ADC DAC COMP OPAMP LCD TIM RTC IWDG WWDG AES USB FSMC I2C USART SPI SDIO | Yes ? Yes Yes ? Yes Yes Yes Yes ? ? ? Yes Yes Yes Yes ? ? ? Yes Yes Yes Yes |       |

### Memory

  - CONFIG\_RAM\_SIZE - Describes the installed DRAM (SRAM in this case)
  - CONFIG\_RAM\_START - The start address of installed DRAM
  - CONFIG\_STM32\_CCMEXCLUDE - Exclude CCM SRAM from the HEAP
  - CONFIG\_ARCH\_INTERRUPTSTACK - This architecture supports an
    interrupt stack. If defined, this symbol is the size of the
    interrupt stack in bytes. If not defined, the user task stacks will
    be used during interrupt handling.
  - CONFIG\_ARCH\_STACKDUMP - Do stack dumps after assertions

### Clock

  - CONFIG\_ARCH\_BOARD\_STM32\_CUSTOM\_CLOCKCONFIG - Enables special
    STM32 clock configuration features.:
    
        CONFIG_ARCH_BOARD_STM32_CUSTOM_CLOCKCONFIG=n

  - CONFIG\_ARCH\_LOOPSPERMSEC - Must be calibrated for correct
    operation of delay loops

### Timers

Timer devices may be used for different purposes. One special purpose is
to generate modulated outputs for such things as motor control. If
CONFIG\_STM32\_TIMn is defined (as above) then the following may also be
defined to indicate that the timer is intended to be used for pulsed
output modulation, ADC conversion, or DAC conversion. Note that ADC/DAC
require two definition: Not only do you have to assign the timer (n) for
used by the ADC or DAC, but then you also have to configure which ADC or
DAC (m) it is assigned to.

  - CONFIG\_STM32\_TIMn\_PWM Reserve timer n for use by PWM, n=1,..,14
  - CONFIG\_STM32\_TIMn\_ADC Reserve timer n for use by ADC, n=1,..,14
  - CONFIG\_STM32\_TIMn\_ADCm Reserve timer n to trigger ADCm,
    n=1,..,14, m=1,..,3
  - CONFIG\_STM32\_TIMn\_DAC Reserve timer n for use by DAC, n=1,..,14
  - CONFIG\_STM32\_TIMn\_DACm Reserve timer n to trigger DACm,
    n=1,..,14, m=1,..,2

For each timer that is enabled for PWM usage, we need the following
additional configuration settings:

> CONFIG\_STM32\_TIMx\_CHANNEL - Specifies the timer output channel
> {1,..,4}

NOTE: The STM32 timers are each capable of generating different signals
on each of the four channels with different duty cycles. That capability
is not supported by this driver: Only one output channel per timer.

### JTAG

JTAG Enable settings (by default JTAG-DP and SW-DP are disabled):

  - CONFIG\_STM32\_JTAG\_FULL\_ENABLE - Enables full SWJ (JTAG-DP +
    SW-DP)
  - CONFIG\_STM32\_JTAG\_NOJNTRST\_ENABLE - Enables full SWJ (JTAG-DP +
    SW-DP) but without JNTRST.
  - CONFIG\_STM32\_JTAG\_SW\_ENABLE - Set JTAG-DP disabled and SW-DP
    enabled

### USART

Options:

  - CONFIG\_U\[S\]ARTn\_SERIAL\_CONSOLE - selects the USARTn (n=1,2,3)
    or UARTm (m=4,5) for the console and ttys0 (default is the USART1).
  - CONFIG\_U\[S\]ARTn\_RXBUFSIZE - Characters are buffered as received.
    This specific the size of the receive buffer
  - CONFIG\_U\[S\]ARTn\_TXBUFSIZE - Characters are buffered before being
    sent. This specific the size of the transmit buffer
  - CONFIG\_U\[S\]ARTn\_BAUD - The configure BAUD of the UART. Must be
  - CONFIG\_U\[S\]ARTn\_BITS - The number of bits. Must be either 7 or
    8.
  - CONFIG\_U\[S\]ARTn\_PARTIY - 0=no parity, 1=odd parity, 2=even
    parity
  - CONFIG\_U\[S\]ARTn\_2STOP - Two stop bits

### SPI

  - CONFIG\_STM32\_SPI\_INTERRUPTS - Select to enable interrupt driven
    SPI support. Non-interrupt-driven, poll-waiting is recommended if
    the interrupt rate would be to high in the interrupt driven case.
  - CONFIG\_STM32\_SPIx\_DMA - Use DMA to improve SPIx transfer
    performance. Cannot be used with CONFIG\_STM32\_SPI\_INTERRUPT.

### USB

TODO

### SLCD

To enable SLCD support:

    Board Selection:
      CONFIG_ARCH_LEDS=n                      : Disable board LED support
    
    Library Routines:
      CONFIG_LIBC_SLCDCODEC=y                  : Enable the SLCD CODEC
    
    System Type -> STM32 Peripheral Support:
      CONFIG_STM32_LCD=y                      : Enable the Segment LCD

To enable LCD debug output:

    Device Drivers:
      CONFIG_LCD=y                            : (Needed to enable LCD debug)
    
    Build Setup -> Debug Options:
      CONFIG_DEBUG_FEATURES=y                 : Enable debug features
      CONFIG_DEBUG_INFO=y                     : Enable LCD debug

NOTE: At this point in time, testing of the SLCD is very limited because
there is not much in apps/examples/slcd. Certainly there are more bugs
to be found. There are also many segment-encoded glyphs in stm32\_lcd.c
But there is a basically functional driver with a working test setup
that can be extended if you want a fully functional SLCD driver.

## Supported Boards

> boards/*/*
