ST STM32F3
==========

Supported MCUs
--------------

TODO

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

  Peripheral                                                                                                                            Support                                                                                            Notes
  ------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------- -------
  FLASH CRC PM RCC GPIO SYSCFG DMA EXTI ADC SDADC DAC COMP OPAMP TSC TIM HRTIM IRTIM IWDG WWDG RTC I2C USART SPI I2S CAN USB HDMI-CEC   Yes Yes ? Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes No Yes Yes No ? ? Yes Yes Yes Yes ? Yes Yes No   

### Memory

-   CONFIG\_RAM\_SIZE - Describes the installed DRAM (SRAM in this case)
-   CONFIG\_RAM\_START - The start address of installed DRAM
-   CONFIG\_STM32\_CCMEXCLUDE - Exclude CCM SRAM from the HEAP
-   CONFIG\_ARCH\_INTERRUPTSTACK - This architecture supports an
    interrupt stack. If defined, this symbol is the size of the
    interrupt stack in bytes. If not defined, the user task stacks will
    be used during interrupt handling.
-   CONFIG\_ARCH\_STACKDUMP - Do stack dumps after assertions

### Clock

-   CONFIG\_ARCH\_BOARD\_STM32\_CUSTOM\_CLOCKCONFIG - Enables special
    STM32 clock configuration features.:

        CONFIG_ARCH_BOARD_STM32_CUSTOM_CLOCKCONFIG=n

-   CONFIG\_ARCH\_LOOPSPERMSEC - Must be calibrated for correct
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

-   CONFIG\_STM32\_TIMn\_PWM Reserve timer n for use by PWM, n=1,..,14
-   CONFIG\_STM32\_TIMn\_ADC Reserve timer n for use by ADC, n=1,..,14
-   CONFIG\_STM32\_TIMn\_ADCm Reserve timer n to trigger ADCm,
    n=1,..,14, m=1,..,3
-   CONFIG\_STM32\_TIMn\_DAC Reserve timer n for use by DAC, n=1,..,14
-   CONFIG\_STM32\_TIMn\_DACm Reserve timer n to trigger DACm,
    n=1,..,14, m=1,..,2

For each timer that is enabled for PWM usage, we need the following
additional configuration settings:

-   CONFIG\_STM32\_TIMx\_CHANNEL - Specifies the timer output channel
    {1,..,4}

NOTE: The STM32 timers are each capable of generating different signals
on each of the four channels with different duty cycles. That capability
is not supported by this driver: Only one output channel per timer.

### JTAG

JTAG Enable settings (by default JTAG-DP and SW-DP are disabled):

-   CONFIG\_STM32\_JTAG\_FULL\_ENABLE - Enables full SWJ (JTAG-DP +
    SW-DP)
-   CONFIG\_STM32\_JTAG\_NOJNTRST\_ENABLE - Enables full SWJ (JTAG-DP +
    SW-DP) but without JNTRST.
-   CONFIG\_STM32\_JTAG\_SW\_ENABLE - Set JTAG-DP disabled and SW-DP
    enabled

### USART

Options:

-   CONFIG\_U\[S\]ARTn\_SERIAL\_CONSOLE - selects the USARTn (n=1,2,3)
    or UARTm (m=4,5) for the console and ttys0 (default is the USART1).
-   CONFIG\_U\[S\]ARTn\_RXBUFSIZE - Characters are buffered as received.
    This specific the size of the receive buffer
-   CONFIG\_U\[S\]ARTn\_TXBUFSIZE - Characters are buffered before being
    sent. This specific the size of the transmit buffer
-   CONFIG\_U\[S\]ARTn\_BAUD - The configure BAUD of the UART. Must be
-   CONFIG\_U\[S\]ARTn\_BITS - The number of bits. Must be either 7
    or 8.
-   CONFIG\_U\[S\]ARTn\_PARTIY - 0=no parity, 1=odd parity, 2=even
    parity
-   CONFIG\_U\[S\]ARTn\_2STOP - Two stop bits

### CAN character device

-   CONFIG\_CAN - Enables CAN support (one or both of
    CONFIG\_STM32\_CAN1 or CONFIG\_STM32\_CAN2 must also be defined)
-   CONFIG\_CAN\_EXTID - Enables support for the 29-bit extended ID.
    Default Standard 11-bit IDs.
-   CONFIG\_CAN\_TXFIFOSIZE - The size of the circular tx buffer of CAN
    messages. Default: 8
-   CONFIG\_CAN\_RXFIFOSIZE - The size of the circular rx buffer of CAN
    messages. Default: 8
-   CONFIG\_CAN\_NPENDINGRTR - The size of the list of pending RTR
    requests. Default: 4
-   CONFIG\_CAN\_LOOPBACK - A CAN driver may or may not support a
    loopback mode for testing. The STM32 CAN driver does support
    loopback mode.
-   CONFIG\_STM32\_CAN1\_BAUD - CAN1 BAUD rate. Required if
    CONFIG\_STM32\_CAN1 is defined.
-   CONFIG\_STM32\_CAN2\_BAUD - CAN1 BAUD rate. Required if
    CONFIG\_STM32\_CAN2 is defined.
-   CONFIG\_STM32\_CAN\_TSEG1 - The number of CAN time quanta in segment
    1. Default: 6
-   CONFIG\_STM32\_CAN\_TSEG2 - the number of CAN time quanta in segment
    2. Default: 7
-   CONFIG\_STM32\_CAN\_REGDEBUG - If CONFIG\_DEBUG\_FEATURES is set,
    this will generate an dump of all CAN registers.

### CAN SocketCAN

TODO

### SPI

-   CONFIG\_STM32\_SPI\_INTERRUPTS - Select to enable interrupt driven
    SPI support. Non-interrupt-driven, poll-waiting is recommended if
    the interrupt rate would be to high in the interrupt driven case.
-   CONFIG\_STM32\_SPIx\_DMA - Use DMA to improve SPIx transfer
    performance. Cannot be used with CONFIG\_STM32\_SPI\_INTERRUPT.

### USB FS

TODO

FPU
---

### FPU Configuration Options

There are two version of the FPU support built into the STM32 port.

1.  Non-Lazy Floating Point Register Save

    In this configuration floating point register save and restore is
    implemented on interrupt entry and return, respectively. In this
    case, you may use floating point operations for interrupt handling
    logic if necessary. This FPU behavior logic is enabled by default
    with:

        CONFIG_ARCH_FPU=y

2.  Lazy Floating Point Register Save.

    An alternative mplementation only saves and restores FPU registers
    only on context switches. This means: (1) floating point registers
    are not stored on each context switch and, hence, possibly better
    interrupt performance. But, (2) since floating point registers are
    not saved, you cannot use floating point operations within interrupt
    handlers.

    This logic can be enabled by simply adding the following to your
    .config file:

        CONFIG_ARCH_FPU=y

Flashing and Debugging
----------------------

NuttX firmware Flashing with STLink probe and OpenOCD:

    openocd -f  interface/stlink.cfg -f target/stm32f3x.cfg -c 'program nuttx.bin 0x08000000; reset run; exit'

Remote target Reset with STLink probe and OpenOCD:

    openocd -f interface/stlink.cfg -f target/stm32f3x.cfg -c 'init; reset run; exit'

Remote target Debug with STLink probe and OpenOCD:

> 1.  You need to have NuttX built with debug symbols, see
>     `debugging`{.interpreted-text role="ref"}.
>
> 2.  Launch the OpenOCD GDB server:
>
>         openocd -f interface/stlink.cfg -f target/stm32f3x.cfg -c 'init; reset halt'
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

::: {.toctree glob="" maxdepth="1"}
boards/*/*
:::
