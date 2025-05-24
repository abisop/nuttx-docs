README.txt
==========

This is the README file for the port of NuttX to the Freescale Kinetis
TWR-K60N512. Refer to the Freescale web site for further information
about this part:
http://www.freescale.com/webapp/sps/site/prod\_summary.jsp?code=TWR-K60N512-KIT

The TWR-K60N51 includes with the FreeScale Tower System which provides
(among other things) a simple UART connection.

Contents
========

o Kinetis TWR-K60N512 Features o Kinetis TWR-K60N512 Pin Configuration -
On-Board Connections - Connections via the General Purpose Tower Plug-in
(TWRPI) Socket - Connections via the Tower Primary Connector Side A -
Connections via the Tower Primary Connector Side B - TWR-SER Serial
Board Connection o LEDs o TWR-K60N512-specific Configuration Options o
Configurations

Kinetis TWR-K60N512 Features:
=============================

o K60N512 in 144 MAPBGA, K60N512VMD100 o Capacitive Touch Pads o
Integrated, Open-Source JTAG o SD Card Slot o MMA7660 3-axis
accelerometer o Tower Plug-In (TWRPI) Socket for expansion (sensors,
etc.) o Touch TWRPI Socket adds support for various capacitive touch
boards (e.g. keypads, rotary dials, sliders, etc.) o Tower connectivity
for access to USB, Ethernet, RS232/RS485, CAN, SPI, I²C, Flexbus, etc. o
Plus: Potentiometer, 4 LEDs, 2 pushbuttons, infrared port

Kinetis TWR-K60N512 Pin Configuration
=====================================

  On-Board Connections                           
  ---------------------- ------------ ---------- --------------
  FEATURE                CONNECTION   PORT/PIN   PIN FUNCTION

OSJTAG USB-to-serial OSJTAG Bridge RX Data PTE9 UART5\_RX Bridge OSJTAG
Bridge TX Data PTE8 UART5\_TX SD Card Slot SD Clock PTE2 SDHC0\_DCLK SD
Command PTE3 SDHC0\_CMD SD Data0 PTE1 SDHC0\_D0 SD Data1 PTE0 SDHC0\_D1
SD Data2 PTE5 SDHC0\_D2 SD Data3 PTE4 SDHC0\_D3 SD Card Detect PTE28
PTE28 SD Write Protect PTE27 PTE27 Infrared Port IR Transmit PTD7
CMT\_IRO IR Receive PTC6 CMP0\_IN0 Pushbuttons SW1 (IRQ0) PTA19 PTA19
SW2 (IRQ1) PTE26 PTE26 SW3 (RESET) RESET\_b RESET\_b Touch Pads E1 /
Touch PTA4 TSI0\_CH5 E2 / Touch PTB3 TSI0\_CH8 E3 / Touch PTB2 TSI0\_CH7
E4 / Touch PTB16 TSI0\_CH9 LEDs E1 / Orange LED PTA11 PTA11 E2 / Yellow
LED PTA28 PTA28 E3 / Green LED PTA29 PTA29 E4 / Blue LED PTA10 PTA10
Potentiometer Potentiometer (R71) ? ADC1\_DM1 Accelerometer I2C SDA PTD9
I2C0\_SDA I2C SCL PTD8 I2C0\_SCL IRQ PTD10 PTD10 Touch Pad / Segment
Electrode 0 (J3 Pin 3) PTB0 TSI0\_CH0 LCD TWRPI Socket Electrode 1 (J3
Pin 5) PTB1 TSI0\_CH6 Electrode 2 (J3 Pin 7) PTB2 TSI0\_CH7 Electrode 3
(J3 Pin 8) PTB3 TSI0\_CH8 Electrode 4 (J3 Pin 9) PTC0 TSI0\_CH13
Electrode 5 (J3 Pin 10) PTC1 TSI0\_CH14 Electrode 6 (J3 Pin 11) PTC2
TSI0\_CH15 Electrode 7 (J3 Pin 12) PTA4 TSI0\_CH5 Electrode 8 (J3 Pin
13) PTB16 TSI0\_CH9 Electrode 9 (J3 Pin 14) PTB17 TSI0\_CH10 Electrode
10 (J3 Pin 15) PTB18 TSI0\_CH11 Electrode 11 (J3 Pin 16) PTB19
TSI0\_CH12 TWRPI ID0 (J3 Pin 17) ? ADC1\_DP1 TWRPI ID1 (J3 Pin 18) ?
ADC1\_SE16

  Connections via the G   eneral Purpose Tower Plug-   in (TWRPI   ) Socket
  ----------------------- ---------------------------- ----------- --------------
  FEATURE C               ONNECTION                    PORT/PIN    PIN FUNCTION

General Purpose TWRPI AN0 (J4 Pin 8) ? ADC0\_DP0/ADC1\_DP3 TWRPI Socket
TWRPI AN1 (J4 Pin 9) ? ADC0\_DM0/ADC1\_DM3 TWRPI AN2 (J4 Pin 12) ?
ADC1\_DP0/ADC0\_DP3 TWRPI ID0 (J4 Pin 17) ? ADC0\_DP1 TWRPI ID1 (J4 Pin
18) ? ADC0\_DM1 TWRPI I2C SCL (J5 Pin 3) PTD8 I2C0\_SCL TWRPI I2C SDA
(J5 Pin 4) PTD9 I2C0\_SDA TWRPI SPI MISO (J5 Pin 9) PTD14 SPI2\_SIN
TWRPI SPI MOSI (J5 Pin 10) PTD13 SPI2\_SOUT TWRPI SPI SS (J5 Pin 11)
PTD15 SPI2\_PCS0 TWRPI SPI CLK (J5 Pin 12) PTD12 SPI2\_SCK TWRPI GPIO0
(J5 Pin 15) PTD10 PTD10 TWRPI GPIO1 (J5 Pin 16) PTB8 PTB8 TWRPI GPIO2
(J5 Pin 17) PTB9 PTB9 TWRPI GPIO3 (J5 Pin 18) PTA19 PTA19 TWRPI GPIO4
(J5 Pin 19) PTE26 PTE26

The TWR-K60N512 features two expansion card-edge connectors that
interface to the Primary and Secondary Elevator boards in a Tower
system. The Primary Connector (comprised of sides A and B) is utilized
by the TWR-K60N512 while the Secondary Connector (comprised of sides C
and D) only makes connections to the GND pins.

  Conn   ections via the Tower    Primary Connector Side A
  ------ ----------------------- --------------------------
  PIN    NAME                              USAGE

A7 SCL0 PTD8 A8 SDA0 PTD9 A9 GPIO9 / CTS1 PTC19 A10 GPIO8 / SDHC\_D2
PTE5 A11 GPIO7 / SD\_WP\_DET PTE27 A13 ETH\_MDC PTB1 A14 ETH\_MDIO PTB0
A16 ETH\_RXDV PTA14 A19 ETH\_RXD1 PTA12 A20 ETH\_RXD0 PTA13 A21
SSI\_MCLK PTE6 A22 SSI\_BCLK PTE12 A23 SSI\_FS PTE11 A24 SSI\_RXD PTE7
A25 SSI\_TXD PTE10 A27 AN3 PGA0\_DP/ADC0\_DP0/ADC1\_DP3 A28 AN2
PGA0\_DM/ADC0\_DM0/ADC1\_DM3 A29 AN1 PGA1\_DP/ADC1\_DP0/ADC0\_DP3 A30
AN0 PGA1\_DM/ADC1\_DM0/ADC0\_DM3 A33 TMR1 PTA9 A34 TMR0 PTA8 A35 GPIO6
PTB9 A37 PWM3 PTA6 A38 PWM2 PTC3 A39 PWM1 PTC2 A40 PWM0 PTC1 A41 RXD0
PTE25 A42 TXD0 PTE24 A43 RXD1 PTC16 A44 TXD1 PTC17 A64 CLKOUT0 PTC3 A66
EBI\_AD14 PTC0 A67 EBI\_AD13 PTC1 A68 EBI\_AD12 PTC2 A69 EBI\_AD11 PTC4
A70 EBI\_AD10 PTC5 A71 EBI\_AD9 PTC6 A71 EBI\_R/W\_b PTC11 A72 EBI\_AD8
PTC7 A73 EBI\_AD7 PTC8 A74 EBI\_AD6 PTC9 A75 EBI\_AD5 PTC10 A76 EBI\_AD4
PTD2 A77 EBI\_AD3 PTD3 A78 EBI\_AD2 PTD4 A79 EBI\_AD1 PTD5 A80 EBI\_AD0
PTD6

  Conn   ections via the Tower    Primary Connector Side B
  ------ ----------------------- --------------------------
  PIN    NAME                              USAGE

B7 SDHC\_CLK / SPI1\_CLK PTE2 B9 SDHC\_D3 / SPI1\_CS0\_b PTE4 B10
SDHC\_CMD / SPI1\_MOSI PTE1 B11 SDHC\_D0 / SPI1\_MISO PTE3 B13 ETH\_RXER
PTA5 B15 ETH\_TXEN PTA15 B19 ETH\_TXD1 PTA17 B20 ETH\_TXD0 PTA16 B21
GPIO1 / RTS1 PTC18 B22 GPIO2 / SDHC\_D1 PTE0 B23 GPIO3 PTE28 B24 CLKIN0
PTA18 B25 CLKOUT1 PTE26 B27 AN7 PTB7 B28 AN6 PTB6 B29 AN5 PTB5 B30 AN4
PTB4 B34 TMR2 PTD6 B35 GPIO4 PTB8 B37 PWM7 PTA2 B38 PWM6 PTA1 B39 PWM5
PTD5 B40 PWM4 PTA7 B41 CANRX0 PTE25 B42 CANTX0 PTE24 B44 SPI0\_MISO
PTD14 B45 SPI0\_MOSI PTD13 B46 SPI0\_CS0\_b PTD11 B47 SPI0\_CS1\_b PTD15
B48 SPI0\_CLK PTD12 B50 SCL1 PTD8 B51 SDA1 PTD9 B52 GPIO5 /
SD\_CARD\_DET PTE28 B55 IRQ\_H PTA24 B56 IRQ\_G PTA24 B57 IRQ\_F PTA25
B58 IRQ\_E PTA25 B59 IRQ\_D PTA26 B60 IRQ\_C PTA26 B61 IRQ\_B PTA27 B62
IRQ\_A PTA27 B63 EBI\_ALE / EBI\_CS1\_b PTD0 B64 EBI\_CS0\_b PTD1 B66
EBI\_AD15 PTB18 B67 EBI\_AD16 PTB17 B68 EBI\_AD17 PTB16 B69 EBI\_AD18
PTB11 B70 EBI\_AD19 PTB10 B72 EBI\_OE\_b PTB19 B73 EBI\_D7 PTB20 B74
EBI\_D6 PTB21 B75 EBI\_D5 PTB22 B76 EBI\_D4 PTB23 B77 EBI\_D3 PTC12 B78
EBI\_D2 PTC13 B79 EBI\_D1 PTC14 B80 EBI\_D0 PTC15

TWR-SER Serial Board Connection
===============================

The serial board connects into the tower and then maps to the tower pins
to yet other functions (see TWR-SER.pdf).

For the serial port, the following jumpers are required:

J15: 1-2 (default) J17: 1-2 (default) J18: 1-2 (default) J19: 1-2
(default)

The two connections map as follows:

A41 RXD0 - Not connected A42 TXD0 - Not connected A43 RXD1 - ELE\_RXD
(connects indirectory to DB-9 connector J8) A44 TXD1 - ELE\_TXD
(connects indirectory to DB-9 connector J8)

Finally, we can conclude that:

UART4 (PTE24/25) is not connected, and UART3 (PTC16/17) is associated
with the DB9 connector

NOTE: UART5 is associated with OSJTAG bridge and may also be usable.

LEDs
====

The TWR-K60N100 board has four LEDs labeled D2..D4 on the board. Usage
of these LEDs is defined in include/board.h and src/up\_leds.c. They are
encoded as follows:

    SYMBOL                Meaning                  LED1*    LED2    LED3    LED4
    -------------------   -----------------------  -------  ------- ------- ------
    LED_STARTED           NuttX has been started   ON       OFF     OFF     OFF
    LED_HEAPALLOCATE      Heap has been allocated  OFF      ON      OFF     OFF
    LED_IRQSENABLED       Interrupts enabled       ON       ON      OFF     OFF
    LED_STACKCREATED      Idle stack created       OFF      OFF     ON      OFF
    LED_INIRQ             In an interrupt**        ON       N/C     N/C     OFF
    LED_SIGNAL            In a signal handler***   N/C      ON      N/C     OFF
    LED_ASSERTION         An assertion failed      ON       ON      N/C     OFF
    LED_PANIC             The system has crashed   N/C      N/C      N/C    ON
    LED_IDLE              STM32 is is sleep mode   (Optional, not used)

-   If LED1, LED2, LED3 are statically on, then NuttX probably failed to
    boot and these LEDs will give you some indication of where the
    failure was \*\* The normal state is LED3 ON and LED1 faintly
    glowing. This faint glow is because of timer interrupts that result
    in the LED being illuminated on a small proportion of the time.
    \*\*\* LED2 may also flicker normally if signals are processed.

TWR-K60N512-specific Configuration Options
==========================================

    CONFIG_ARCH - Identifies the arch/ subdirectory.  This should
       be set to:

       CONFIG_ARCH=arm

    CONFIG_ARCH_family - For use in C code:

       CONFIG_ARCH_ARM=y

    CONFIG_ARCH_architecture - For use in C code:

       CONFIG_ARCH_CORTEXM4=y

    CONFIG_ARCH_CHIP - Identifies the arch/*/chip subdirectory

       CONFIG_ARCH_CHIP=k40

    CONFIG_ARCH_CHIP_name - For use in C code to identify the exact
       chip:

       CONFIG_ARCH_CHIP_MK60N512VMD100

    CONFIG_ARCH_BOARD - Identifies the boards/ subdirectory and
       hence, the board that supports the particular chip or SoC.

       CONFIG_ARCH_BOARD=twr-k60n512 (for the TWR-K60N512 development board)

    CONFIG_ARCH_BOARD_name - For use in C code

       CONFIG_ARCH_BOARD_TWR_K60N512=y

    CONFIG_ARCH_LOOPSPERMSEC - Must be calibrated for correct operation
       of delay loops

    CONFIG_ENDIAN_BIG - define if big endian (default is little
       endian)

    CONFIG_RAM_SIZE - Describes the installed DRAM (SRAM in this case):

       CONFIG_RAM_SIZE=0x00010000 (64Kb)

    CONFIG_RAM_START - The start address of installed DRAM

       CONFIG_RAM_START=0x20000000

    CONFIG_ARCH_LEDS - Use LEDs to show state. Unique to boards that
       have LEDs

    CONFIG_ARCH_INTERRUPTSTACK - This architecture supports an interrupt
       stack. If defined, this symbol is the size of the interrupt
        stack in bytes.  If not defined, the user task stacks will be
      used during interrupt handling.

    CONFIG_ARCH_STACKDUMP - Do stack dumps after assertions

    CONFIG_ARCH_LEDS -  Use LEDs to show state. Unique to board architecture.

Individual subsystems can be enabled:

    CONFIG_KINETIS_TRACE    -- Enable trace clocking on power up.
    CONFIG_KINETIS_FLEXBUS  -- Enable flexbus clocking on power up.
    CONFIG_KINETIS_UART0    -- Support UART0
    CONFIG_KINETIS_UART1    -- Support UART1
    CONFIG_KINETIS_UART2    -- Support UART2
    CONFIG_KINETIS_UART3    -- Support UART3
    CONFIG_KINETIS_UART4    -- Support UART4
    CONFIG_KINETIS_UART5    -- Support UART5
    CONFIG_KINETIS_ENET     -- Support Ethernet (K60 only)
    CONFIG_KINETIS_RNGB     -- Support the random number generator(K60 only)
    CONFIG_KINETIS_FLEXCAN0 -- Support FlexCAN0
    CONFIG_KINETIS_FLEXCAN1 -- Support FlexCAN1
    CONFIG_KINETIS_SPI0     -- Support SPI0
    CONFIG_KINETIS_SPI1     -- Support SPI1
    CONFIG_KINETIS_SPI2     -- Support SPI2
    CONFIG_KINETIS_I2C0     -- Support I2C0
    CONFIG_KINETIS_I2C1     -- Support I2C1
    CONFIG_KINETIS_I2S      -- Support I2S
    CONFIG_KINETIS_DAC0     -- Support DAC0
    CONFIG_KINETIS_DAC1     -- Support DAC1
    CONFIG_KINETIS_ADC0     -- Support ADC0
    CONFIG_KINETIS_ADC1     -- Support ADC1
    CONFIG_KINETIS_CMP      -- Support CMP
    CONFIG_KINETIS_VREF     -- Support VREF
    CONFIG_KINETIS_SDHC     -- Support SD host controller
    CONFIG_KINETIS_FTM0     -- Support FlexTimer 0
    CONFIG_KINETIS_FTM1     -- Support FlexTimer 1
    CONFIG_KINETIS_FTM2     -- Support FlexTimer 2
    CONFIG_KINETIS_LPTMR0   -- Support the low power timer 0
    CONFIG_KINETIS_RTC      -- Support RTC
    CONFIG_KINETIS_SLCD     -- Support the segment LCD (K60 only)
    CONFIG_KINETIS_EWM      -- Support the external watchdog
    CONFIG_KINETIS_CMT      -- Support Carrier Modulator Transmitter
    CONFIG_KINETIS_USBOTG   -- Support USB OTG (see also CONFIG_USBHOST and CONFIG_USBDEV)
    CONFIG_KINETIS_USBDCD   -- Support the USB Device Charger Detection module
    CONFIG_KINETIS_LLWU     -- Support the Low Leakage Wake-Up Unit
    CONFIG_KINETIS_TSI      -- Support the touch screeen interface
    CONFIG_KINETIS_FTFL     -- Support FLASH
    CONFIG_KINETIS_DMA      -- Support DMA
    CONFIG_KINETIS_CRC      -- Support CRC
    CONFIG_KINETIS_PDB      -- Support the Programmable Delay Block
    CONFIG_KINETIS_PIT      -- Support Programmable Interval Timers
    CONFIG_ARM_MPU          -- Support the MPU

Kinetis interrupt priorities (Default is the mid priority). These should
not be set because they can cause unhandled, nested interrupts. All
interrupts need to be at the default priority in the current design.

    CONFIG_KINETIS_UART0PRIO
    CONFIG_KINETIS_UART1PRIO
    CONFIG_KINETIS_UART2PRIO
    CONFIG_KINETIS_UART3PRIO
    CONFIG_KINETIS_UART4PRIO
    CONFIG_KINETIS_UART5PRIO

    CONFIG_KINETIS_EMACTMR_PRIO
    CONFIG_KINETIS_EMACTX_PRIO
    CONFIG_KINETIS_EMACRX_PRIO
    CONFIG_KINETIS_EMACMISC_PRIO

    CONFIG_KINETIS_SDHC_PRIO

PIN Interrupt Support

    CONFIG_KINETIS_GPIOIRQ   -- Enable pin interrupt support.  Also needs
      one or more of the following:
    CONFIG_KINETIS_PORTAINTS -- Support 32 Port A interrupts
    CONFIG_KINETIS_PORTBINTS -- Support 32 Port B interrupts
    CONFIG_KINETIS_PORTCINTS -- Support 32 Port C interrupts
    CONFIG_KINETIS_PORTDINTS -- Support 32 Port D interrupts
    CONFIG_KINETIS_PORTEINTS -- Support 32 Port E interrupts

Kinetis K60 specific device driver settings

    CONFIG_UARTn_SERIAL_CONSOLE - selects the UARTn (n=0..5) for the
      console and ttys0 (default is the UART0).
    CONFIG_UARTn_RXBUFSIZE - Characters are buffered as received.
       This specific the size of the receive buffer
    CONFIG_UARTn_TXBUFSIZE - Characters are buffered before
       being sent.  This specific the size of the transmit buffer
    CONFIG_UARTn_BAUD - The configure BAUD of the UART.
    CONFIG_UARTn_BITS - The number of bits.  Must be either 8 or 8.
    CONFIG_UARTn_PARTIY - 0=no parity, 1=odd parity, 2=even parity

Kenetis ethernet controller settings

    CONFIG_ENET_NRXBUFFERS - Number of RX buffers.  The size of one
        buffer is determined by CONFIG_NET_ETH_PKTSIZE.  Default: 6
    CONFIG_ENET_NTXBUFFERS - Number of TX buffers.  The size of one
        buffer is determined by CONFIG_NET_ETH_PKTSIZE.  Default: 2
    CONFIG_ENET_USEMII - Use MII mode.  Default: RMII mode.
    CONFIG_ENET_PHYADDR - PHY address

Configurations
==============

Each TWR-K60N512 configuration is maintained in a sub-directory and can
be selected as follow:

    tools/configure.sh twr-k60n512:<subdir>

Where `<subdir>`{=html} is one of the following:

  nsh:
  ------------------------------------------------------------------
  Configures the NuttShell (nsh) located at apps/examples/nsh. The
  Configuration enables both the serial and telnet NSH interfaces.
  Support for the board's SPI-based MicroSD card is included
  (but not passing tests as of this writing).

    NOTES:

    1. This configuration uses the mconf-based configuration tool.  To
       change this configuration using that tool, you should:

       a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
          see additional README.txt files in the NuttX tools repository.

       b. Execute 'make menuconfig' in nuttx/ in order to start the
          reconfiguration process.

    2. Default platform/toolchain:

       CONFIG_HOST_LINUX=y                 : Linux (Cygwin under Windows okay too).
       CONFIG_ARM_TOOLCHAIN_BUILDROOT=y : Buildroot (arm-nuttx-elf-gcc)
       CONFIG_ARM_TOOLCHAIN_BUILDROOT_OABI=y      : The older OABI version
       CONFIG_RAW_BINARY=y                 : Output formats: ELF and raw binary

    3. An SDHC driver is under work and can be enabled in the NSH configuration
       for further testing be setting the following configuration values as
       follows:

      CONFIG_KINETIS_SDHC=y                : Enable the SDHC driver

      CONFIG_MMCSD=y                       : Enable MMC/SD support
      CONFIG_MMCSD_SDIO=y                  : Use the SDIO-based MMC/SD driver
      CONFIG_MMCSD_NSLOTS=1                : One MMC/SD slot

      CONFIG_FAT=y                         : Eable FAT file system
      CONFIG_FAT_LCNAMES=y                 : FAT lower case name support
      CONFIG_FAT_LFN=y                     : FAT long file name support
      CONFIG_FAT_MAXFNAME=32               : Maximum length of a long file name

      CONFIG_KINETIS_GPIOIRQ=y             : Enable GPIO interrupts
      CONFIG_KINETIS_PORTEINTS=y           : Enable PortE GPIO interrupts

      CONFIG_SCHED_WORKQUEUE=y             : Enable the NuttX workqueue

      CONFIG_NSH_ARCHINIT=y                : Provide NSH initialization logic
