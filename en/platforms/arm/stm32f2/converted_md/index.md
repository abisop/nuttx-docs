ST STM32F2
==========

Supported MCUs
--------------

TODO

Peripheral Support
------------------

The following list indicates peripherals supported in NuttX:

  Peripheral                                                                                                                           Support                                                                                                  Notes
  ------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------------------------------- -------
  FLASH CRC PM RCC GPIO SYSCFG EXTI DMA ADC DAC DCMI TIM IWDG WWDG CRYP RNG HASH RTC I2C USART SPI SDIO CAN ETH OTG\_FS OTG\_HS FSMC   Yes Yes ? Yes Yes Yes Yes Yes Yes Yes No Yes Yes Yes Yes Yes ? Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes   

### Memory

-   CONFIG\_RAM\_SIZE - Describes the installed DRAM (SRAM in this case)
-   CONFIG\_RAM\_START - The start address of installed DRAM

In addition to internal SRAM, SRAM may also be available through the
FSMC. In order to use FSMC SRAM, the following additional things need to
be present in the NuttX configuration file:

-   CONFIG\_STM32\_EXTERNAL\_RAM - Indicates that SRAM is available via
    the FSMC (as opposed to an LCD or FLASH).
-   CONFIG\_HEAP2\_BASE - The base address of the SRAM in the FSMC
    address space (hex)
-   CONFIG\_HEAP2\_SIZE - The size of the SRAM in the FSMC address space
    (decimal)
-   CONFIG\_ARCH\_LEDS - Use LEDs to show state. Unique to boards that
    have LEDs
-   CONFIG\_ARCH\_INTERRUPTSTACK - This architecture supports an
    interrupt stack. If defined, this symbol is the size of the
    interrupt stack in bytes. If not defined, the user task stacks will
    be used during interrupt handling.
-   CONFIG\_ARCH\_STACKDUMP - Do stack dumps after assertions
-   CONFIG\_ARCH\_LEDS - Use LEDs to show state. Unique to board
    architecture.

### Clock

-   CONFIG\_ARCH\_BOARD\_STM32\_CUSTOM\_CLOCKCONFIG - Enables special
    STM32 clock configuration features.:

        CONFIG_ARCH_BOARD_STM32_CUSTOM_CLOCKCONFIG=n

-   CONFIG\_ARCH\_LOOPSPERMSEC - Must be calibrated for correct
    operation of delay loops

### CAN

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
-   CONFIG\_STM32\_CAN1 - Enable support for CAN1
-   CONFIG\_STM32\_CAN2 - Enable support for CAN2
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

### FSMC SRAM

Internal SRAM is available in all members of the STM32 family. In
addition to internal SRAM, SRAM may also be available through the FSMC.
In order to use FSMC SRAM, the following additional things need to be
present in the NuttX configuration file:

-   CONFIG\_STM32\_FSMC=y - Enables the FSMC
-   CONFIG\_STM32\_EXTERNAL\_RAM=y - Indicates that SRAM is available
    via the FSMC (as opposed to an LCD or FLASH).
-   CONFIG\_HEAP2\_BASE - The base address of the SRAM in the FSMC
    address space
-   CONFIG\_HEAP2\_SIZE - The size of the SRAM in the FSMC address space
-   CONFIG\_MM\_REGIONS - Must be set to a large enough value to include
    the FSMC SRAM

### Timers

Timer devices may be used for different purposes. One special purpose is
to generate modulated outputs for such things as motor control. If
CONFIG\_STM32\_TIMn is defined (as above) then the following may also be
defined to indicate that the timer is intended to be used for pulsed
output modulation, ADC conversion, or DAC conversion. Note that ADC/DAC
require two definition: Not only do you have to assign the timer (n) for
used by the ADC or DAC, but then you also have to configure which ADC or
DAC (m) it is assigned to.:

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

### SPI

-   CONFIG\_STM32\_SPI\_INTERRUPTS - Select to enable interrupt driven
    SPI support. Non-interrupt-driven, poll-waiting is recommended if
    the interrupt rate would be to high in the interrupt driven case.
-   CONFIG\_STM32\_SPIx\_DMA - Use DMA to improve SPIx transfer
    performance. Cannot be used with CONFIG\_STM32\_SPI\_INTERRUPT.

### SDIO

Options:

-   CONFIG\_SDIO\_DMA - Support DMA data transfers. Requires
    CONFIG\_STM32\_SDIO and CONFIG\_STM32\_DMA2.
-   CONFIG\_STM32\_SDIO\_PRI - Select SDIO interrupt priority. Default:
    128
-   CONFIG\_STM32\_SDIO\_DMAPRIO - Select SDIO DMA interrupt priority.
    Default: Medium
-   CONFIG\_STM32\_SDIO\_WIDTH\_D1\_ONLY - Select 1-bit transfer mode.
    Default: 4-bit transfer mode.

### ETH

Options:

-   CONFIG\_STM32\_PHYADDR - The 5-bit address of the PHY on the board
-   CONFIG\_STM32\_MII - Support Ethernet MII interface
-   CONFIG\_STM32\_MII\_MCO1 - Use MCO1 to clock the MII interface
-   CONFIG\_STM32\_MII\_MCO2 - Use MCO2 to clock the MII interface
-   CONFIG\_STM32\_RMII - Support Ethernet RMII interface
-   CONFIG\_STM32\_AUTONEG - Use PHY autonegotiation to determine speed
    and mode
-   CONFIG\_STM32\_ETHFD - If CONFIG\_STM32\_AUTONEG is not defined,
    then this may be defined to select full duplex mode. Default:
    half-duplex
-   CONFIG\_STM32\_ETH100MBPS - If CONFIG\_STM32\_AUTONEG is not
    defined, then this may be defined to select 100 MBps speed. Default:
    10 Mbps
-   CONFIG\_STM32\_PHYSR - This must be provided if
    CONFIG\_STM32\_AUTONEG is defined. The PHY status register address
    may diff from PHY to PHY. This configuration sets the address of the
    PHY status register.
-   CONFIG\_STM32\_PHYSR\_SPEED - This must be provided if
    CONFIG\_STM32\_AUTONEG is defined. This provides bit mask indicating
    10 or 100MBps speed.
-   CONFIG\_STM32\_PHYSR\_100MBPS - This must be provided if
    CONFIG\_STM32\_AUTONEG is defined. This provides the value of the
    speed bit(s) indicating 100MBps speed.
-   CONFIG\_STM32\_PHYSR\_MODE - This must be provided if
    CONFIG\_STM32\_AUTONEG is defined. This provide bit mask indicating
    full or half duplex modes.
-   CONFIG\_STM32\_PHYSR\_FULLDUPLEX - This must be provided if
    CONFIG\_STM32\_AUTONEG is defined. This provides the value of the
    mode bits indicating full duplex mode.
-   CONFIG\_STM32\_ETH\_PTP - Precision Time Protocol (PTP). Not
    supported but some hooks are indicated with this condition.

### USB OTG FS

STM32 USB OTG FS Host Driver Support

Pre-requisites:

-   CONFIG\_USBHOST - Enable general USB host support
-   CONFIG\_STM32\_OTGFS - Enable the STM32 USB OTG FS block
-   CONFIG\_STM32\_SYSCFG - Needed
-   CONFIG\_STM32\_OTGFS\_RXFIFO\_SIZE - Size of the RX FIFO in 32-bit
    words. Default 128 (512 bytes)
-   CONFIG\_STM32\_OTGFS\_NPTXFIFO\_SIZE - Size of the non-periodic Tx
    FIFO in 32-bit words. Default 96 (384 bytes)
-   CONFIG\_STM32\_OTGFS\_PTXFIFO\_SIZE - Size of the periodic Tx FIFO
    in 32-bit words. Default 96 (384 bytes)
-   CONFIG\_STM32\_OTGFS\_DESCSIZE - Maximum size of a descriptor.
    Default: 128
-   CONFIG\_STM32\_OTGFS\_SOFINTR - Enable SOF interrupts. Why would you
    ever want to do that?
-   CONFIG\_STM32\_USBHOST\_REGDEBUG - Enable very low-level register
    access debug. Depends on CONFIG\_DEBUG\_FEATURES.
-   CONFIG\_STM32\_USBHOST\_PKTDUMP - Dump all incoming and outgoing USB
    packets. Depends on CONFIG\_DEBUG\_FEATURES.

Supported Boards
----------------

::: {.toctree glob="" maxdepth="1"}
boards/*/*
:::
