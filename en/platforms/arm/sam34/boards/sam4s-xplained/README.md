README \^\^\^\^\^\^

This README discusses issues unique to NuttX configurations for the
Atmel SAM4S Xplained development board. This board features the
ATSAM4S16C MCU with 1MB FLASH and 128KB.

The SAM4S Xplained features:

    - 120 MHz Cortex-M4 with MPU
    - 12MHz crystal (no 32.768KHz crystal)
    - Segger J-Link JTAG emulator on-board for program and debug
    - MICRO USB A/B connector for USB connectivity
    - IS66WV51216DBLL ISSI SRAM 8Mb 512K x 16 55ns PSRAM 2.5v-3.6v
    - Four Atmel QTouch buttons
    - External voltage input
    - Four LEDs, two controllable from software
    - Xplained expansion headers
    - Footprint for external serial Flash (not fitted)

Contents \^\^\^\^\^\^\^\^

-   PIO Muliplexing
-   Buttons and LEDs
-   Serial Consoles
-   SAM4S Xplained-specific Configuration Options
-   Configurations

PIO Muliplexing \^\^\^\^\^\^\^\^\^\^\^\^\^\^\^

PA0 SMC\_A17 PB0 J2.3 default PC0 SMC\_D0 PA1 SMC\_A18 PB1 J2.4 PC1
SMC\_D1 PA2 J3.7 default PB2 J1.3 & J4.3 PC2 SMC\_D2 PA3 J1.1 & J4.1 PB3
J1.4 & J4.4 PC3 SMC\_D3 PA4 J1.2 & J4.2 PB4 JTAG PC4 SMC\_D4 PA5
User\_button BP2 PB5 JTAG PC5 SMC\_D5 PA6 J3.7 optional PB6 JTAG PC6
SMC\_D6 PA7 CLK\_32K PB7 JTAG PC7 SMC\_D7 PA8 CLK\_32K PB8 CLK\_12M PC8
SMC\_NWE PA9 RX\_UART0 PB9 CLK\_12M PC9 Power on detect PA10 TX\_UART0
PB10 USB\_DDM PC10 User LED D9 PA11 J3.2 default PB11 USB\_DDP PC11
SMC\_NRD PA12 MISO PB12 ERASE PC12 J2.2 PA13 MOSI PB13 J2.3 optional
PC13 J2.7 PA14 SPCK PB14 N/A PC14 SMC\_NCS0 PA15 J3.5 PC15 SMC\_NSC1
PA16 J3.6 PC16 N/A PA17 J2.5 PC17 User LED D10 PA18 J3.4 & SMC\_A14 PC18
SMC\_A0 PA19 J3.4 optional & SMC\_A15 PC19 SMC\_A1 PA20 J3.1 & SMC\_A16
PC20 SMC\_A2 PA21 J2.6 PC21 SMC\_A3 PA22 J2.1 PC22 SMC\_A4 PA23 J3.3
PC23 SMC\_A5 PA24 TSLIDR\_SL\_SN PC24 SMC\_A6 PA25 TSLIDR\_SL\_SNSK PC25
SMC\_A7 PA26 TSLIDR\_SM\_SNS PC26 SMC\_A8 PA27 TSLIDR\_SM\_SNSK PC27
SMC\_A9 PA28 TSLIDR\_SR\_SNS PC28 SMC\_A10 PA29 TSLIDR\_SR\_SNSK PC29
SMC\_A11 PA30 J4.5 PC30 SMC\_A12 PA31 J1.5 PC31 SMC\_A13

Buttons and LEDs \^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^

Buttons -------

The SAM4S Xplained has two mechanical buttons. One button is the RESET
button connected to the SAM4S reset line and the other is a generic user
configurable button labeled BP2 and connected to GPIO PA5. When a button
is pressed it will drive the I/O line to GND.

LEDs ----

There are four LEDs on board the SAM4X Xplained board, two of these can
be controlled by software in the SAM4S:

      LED              GPIO
      ---------------- -----
      D9  Yellow LED   PC10
      D10 Yellow LED   PC17

Both can be illuminated by driving the GPIO output to ground (low).

These LEDs are not used by the board port unless CONFIG\_ARCH\_LEDS is
defined. In that case, the usage by the board port is defined in
include/board.h and src/sam\_leds.c. The LEDs are used to encode
OS-related events as follows:

    SYMBOL                Meaning                     LED state
                                                    D9       D10
    -------------------  -----------------------  -------- --------
    LED_STARTED          NuttX has been started     OFF      OFF
    LED_HEAPALLOCATE     Heap has been allocated    OFF      OFF
    LED_IRQSENABLED      Interrupts enabled         OFF      OFF
    LED_STACKCREATED     Idle stack created         ON       OFF
    LED_INIRQ            In an interrupt              No change
    LED_SIGNAL           In a signal handler          No change
    LED_ASSERTION        An assertion failed          No change
    LED_PANIC            The system has crashed     OFF      Blinking
    LED_IDLE             MCU is is sleep mode         Not used

Thus if D9 is statically on, NuttX has successfully booted and is,
apparently, running normmally. If D10 is flashing at approximately 2Hz,
then a fatal error has been detected and the system has halted.

Serial Consoles \^\^\^\^\^\^\^\^\^\^\^\^\^\^\^

  UART1
  ------------------------------------------------------------------------
  If you have a TTL to RS-232 converter then this is the most convenient
  serial console to use. UART1 is the default in all of these
  configurations.

    UART1 RXD  PB2   J1 pin 3   J4 pin 3
    UART1 TXD  PB3   J1 pin 4   J4 pin 4
    GND              J1 pin 9   J4 pin 9
    Vdd              J1 pin 10  J4 pin 10

  USART1
  ---------------------------
  USART1 is another option:

    USART1 RXD PA21  J2 pin 6
    USART1 TXD PA22  J2 pin 1
    GND              J2 pin 9
    Vdd              J2 pin 10

  Virtual COM Port
  -------------------------------------------------------------------
  Yet another option is to use UART0 and the virtual COM port. This
  option may be more convenient for long term development, but was
  painful to use during board bring-up.

The SAM4S Xplained contains an Embedded Debugger (EDBG) that can be used
to program and debug the ATSAM4S16C using Serial Wire Debug (SWD). The
Embedded debugger also include a Virtual Com port interface over USART1.
Virtual COM port connections:

  AT91SAM4S16       ATSAM3U4CAU
  ---------------- --------------
  PA9 RX\_UART0     PA9\_4S PA12
  PA10 TX\_UART0    RX\_3U PA11

SAM4S Xplained-specific Configuration Options
\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^\^

CONFIG\_ARCH - Identifies the arch/ subdirectory. This should be set to:

    CONFIG_ARCH=arm

CONFIG\_ARCH\_family - For use in C code:

    CONFIG_ARCH_ARM=y

CONFIG\_ARCH\_architecture - For use in C code:

    CONFIG_ARCH_CORTEXM4=y

CONFIG\_ARCH\_CHIP - Identifies the arch/\*/chip subdirectory

    CONFIG_ARCH_CHIP="sam34"

CONFIG\_ARCH\_CHIP\_name - For use in C code to identify the exact chip:

    CONFIG_ARCH_CHIP_SAM34
    CONFIG_ARCH_CHIP_SAM4S
    CONFIG_ARCH_CHIP_ATSAM4S16C

CONFIG\_ARCH\_BOARD - Identifies the boards/ subdirectory and hence, the
board that supports the particular chip or SoC.

    CONFIG_ARCH_BOARD=sam4s-xplained (for the SAM4S Xplained development board)

CONFIG\_ARCH\_BOARD\_name - For use in C code

    CONFIG_ARCH_BOARD_SAM4S_XPLAINED=y

CONFIG\_ARCH\_LOOPSPERMSEC - Must be calibrated for correct operation of
delay loops

CONFIG\_ENDIAN\_BIG - define if big endian (default is little endian)

CONFIG\_RAM\_SIZE - Describes the installed DRAM (SRAM in this case):

    CONFIG_RAM_SIZE=0x00008000 (32Kb)

CONFIG\_RAM\_START - The start address of installed DRAM

    CONFIG_RAM_START=0x20000000

CONFIG\_ARCH\_LEDS - Use LEDs to show state. Unique to boards that have
LEDs

CONFIG\_ARCH\_INTERRUPTSTACK - This architecture supports an interrupt
stack. If defined, this symbol is the size of the interrupt stack in
bytes. If not defined, the user task stacks will be used during
interrupt handling.

CONFIG\_ARCH\_STACKDUMP - Do stack dumps after assertions

CONFIG\_ARCH\_LEDS - Use LEDs to show state. Unique to board
architecture.

Individual subsystems can be enabled:

    CONFIG_SAM34_RTC         - Real Time Clock
    CONFIG_SAM34_RTT         - Real Time Timer
    CONFIG_SAM34_WDT         - Watchdog Timer
    CONFIG_SAM34_UART0       - UART 0
    CONFIG_SAM34_UART1       - UART 1
    CONFIG_SAM34_SMC         - Static Memory Controller
    CONFIG_SAM34_USART0      - USART 0
    CONFIG_SAM34_USART1      - USART 1
    CONFIG_SAM34_HSMCI       - High Speed Multimedia Card Interface
    CONFIG_SAM34_TWI0        - Two-Wire Interface 0
    CONFIG_SAM34_TWI1        - Two-Wire Interface 1
    CONFIG_SAM34_SPI0        - Serial Peripheral Interface
    CONFIG_SAM34_SSC         - Synchronous Serial Controller
    CONFIG_SAM34_TC0         - Timer Counter 0
    CONFIG_SAM34_TC1         - Timer Counter 1
    CONFIG_SAM34_TC2         - Timer Counter 2
    CONFIG_SAM34_TC3         - Timer Counter 3
    CONFIG_SAM34_TC4         - Timer Counter 4
    CONFIG_SAM34_TC5         - Timer Counter 5
    CONFIG_SAM34_ADC12B      - 12-bit Analog To Digital Converter
    CONFIG_SAM34_DACC        - Digital To Analog Converter
    CONFIG_SAM34_PWM         - Pulse Width Modulation
    CONFIG_SAM34_CRCCU       - CRC Calculation Unit
    CONFIG_SAM34_ACC         - Analog Comparator
    CONFIG_SAM34_UDP         - USB Device Port

Some subsystems can be configured to operate in different ways. The
drivers need to know how to configure the subsystem.

    CONFIG_SAM34_GPIOA_IRQ
    CONFIG_SAM34_GPIOB_IRQ
    CONFIG_SAM34_GPIOC_IRQ
    CONFIG_USART0_SERIALDRIVER
    CONFIG_USART1_SERIALDRIVER
    CONFIG_USART2_SERIALDRIVER
    CONFIG_USART3_SERIALDRIVER

ST91SAM4S specific device driver settings

    CONFIG_U[S]ARTn_SERIAL_CONSOLE - selects the USARTn (n=0,1,2,3) or UART
           m (m=4,5) for the console and ttys0 (default is the USART1).
    CONFIG_U[S]ARTn_RXBUFSIZE - Characters are buffered as received.
       This specific the size of the receive buffer
    CONFIG_U[S]ARTn_TXBUFSIZE - Characters are buffered before
       being sent.  This specific the size of the transmit buffer
    CONFIG_U[S]ARTn_BAUD - The configure BAUD of the UART.  Must be
    CONFIG_U[S]ARTn_BITS - The number of bits.  Must be either 7 or 8.
    CONFIG_U[S]ARTn_PARTIY - 0=no parity, 1=odd parity, 2=even parity
    CONFIG_U[S]ARTn_2STOP - Two stop bits

Configurations \^\^\^\^\^\^\^\^\^\^\^\^\^\^

Each SAM4S Xplained configuration is maintained in a sub-directory and
can be selected as follow:

    tools/configure.shsam4s-xplained:<subdir>

Before building, make sure the PATH environment variable includes the
correct path to the directory than holds your toolchain binaries.

And then build NuttX by simply typing the following. At the conclusion
of the make, the nuttx binary will reside in an ELF file called, simply,
nuttx.

    make

The `<subdir>`{=html} that is provided above as an argument to the
tools/configure.sh must be is one of the following.

NOTES:

1.  These configurations use the mconf-based configuration tool. To
    change any of these configurations using that tool, you should:

```{=html}
<!-- -->
```
    a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
       see additional README.txt files in the NuttX tools repository.

    b. Execute 'make menuconfig' in nuttx/ in order to start the
       reconfiguration process.

2.  Unless stated otherwise, all configurations generate console output
    on UART1 which is available on J1 or J4 (see the section "Serial
    Consoles" above). USART1 or the virtual COM port on UART0 are
    options. The virtual COM port could be used, for example, by
    reconfiguring to use UART0 like:

    System Type -\> AT91SAM3/4 Peripheral Support CONFIG\_SAM\_UART0=y
    CONFIG\_SAM\_UART1=n

    Device Drivers -\> Serial Driver Support -\> Serial Console
    CONFIG\_UART0\_SERIAL\_CONSOLE=y

    Device Drivers -\> Serial Driver Support -\> UART0 Configuration
    CONFIG\_UART0\_2STOP=0 CONFIG\_UART0\_BAUD=115200
    CONFIG\_UART0\_BITS=8 CONFIG\_UART0\_PARITY=0
    CONFIG\_UART0\_RXBUFSIZE=256 CONFIG\_UART0\_TXBUFSIZE=256

3.  Unless otherwise stated, the configurations are setup for Linux (or
    any other POSIX environment like Cygwin under Windows):

    Build Setup: CONFIG\_HOST\_LINUX=y : Linux or other POSIX
    environment

4.  These configurations use the older, OABI, buildroot toolchain. But
    that is easily reconfigured:

    System Type -\> Toolchain: CONFIG\_ARM\_TOOLCHAIN\_BUILDROOT=y :
    Buildroot toolchain CONFIG\_ARM\_TOOLCHAIN\_BUILDROOT\_OABI=y :
    Older, OABI toolchain

    If you want to use the Atmel GCC toolchain, here are the steps to do
    so:

    Build Setup: CONFIG\_HOST\_WINDOWS=y : Windows
    CONFIG\_HOST\_CYGWIN=y : Using Cygwin or other POSIX environment

    System Type -\> Toolchain: CONFIG\_ARM\_TOOLCHAIN\_GNU\_EABI=y :
    General GCC EABI toolchain under windows

    This re-configuration should be done before making NuttX or else the
    subsequent 'make' will fail. If you have already attempted building
    NuttX then you will have to 1) 'make distclean' to remove the old
    configuration, 2) 'tools/configure.sh sam3u-ek/ksnh' to start with a
    fresh configuration, and 3) perform the configuration changes above.

    Also, make sure that your PATH variable has the new path to your
    Atmel tools. Try 'which arm-none-eabi-gcc' to make sure that you are
    selecting the right tool.

    See also the "NOTE about Windows native toolchains" in the section
    call "GNU Toolchain Options" above.

Configuration sub-directories
-----------------------------

nsh: This configuration directory will built the NuttShell. See NOTES
above.

    NOTES:
    1. The configuration configuration can be modified to include support
       for the on-board SRAM (1MB).

       System Type -> External Memory Configuration
         CONFIG_SAM34_EXTSRAM0=y              : Select SRAM on CS0
         CONFIG_SAM34_EXTSRAM0SIZE=1048576    : Size=1MB

       Now what are you going to do with the SRAM.  There are two choices:

       a)  To enable the NuttX RAM test that may be used to verify the
           external SRAM:

           System Type -> External Memory Configuration
             CONFIG_SAM34_EXTSRAM0HEAP=n      : Don't add to heap

           Application Configuration -> System NSH Add-Ons
             CONFIG_TESTING_RAMTEST=y         : Enable the RAM test built-in

         In this configuration, the SDRAM is not added to heap and so is
         not excessible to the applications.  So the RAM test can be
         freely executed against the SRAM memory beginning at address
         0x6000:0000 (CS0).

         nsh> ramtest -h
         Usage: <noname> [-w|h|b] <hex-address> <decimal-size>

         Where:
           <hex-address> starting address of the test.
           <decimal-size> number of memory locations (in bytes).
           -w Sets the width of a memory location to 32-bits.
           -h Sets the width of a memory location to 16-bits (default).
           -b Sets the width of a memory location to 8-bits.

         To test the entire external SRAM:

         nsh> ramtest 60000000 1048576
         RAMTest: Marching ones: 60000000 1048576
         RAMTest: Marching zeroes: 60000000 1048576
         RAMTest: Pattern test: 60000000 1048576 55555555 aaaaaaaa
         RAMTest: Pattern test: 60000000 1048576 66666666 99999999
         RAMTest: Pattern test: 60000000 1048576 33333333 cccccccc
         RAMTest: Address-in-address test: 60000000 1048576

        b) To add this RAM to the NuttX heap, you would need to change the
           configuration as follows:

           System Type -> External Memory Configuration
             CONFIG_SAM34_EXTSRAM0HEAP=y     : Add external RAM to heap

           Memory Management
             -CONFIG_MM_REGIONS=1           : Only the internal SRAM
             +CONFIG_MM_REGIONS=2           : Also include external SRAM
