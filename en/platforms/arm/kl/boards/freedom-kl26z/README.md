README.txt
==========

This is the README file for the port of NuttX to the Freescale Freedom
KL26Z board. This board has the MKL26Z128 chip with a built-in SDA
debugger.

Contents
========

-   Development Environment
-   GNU Toolchain Options
-   NuttX Buildroot Toolchain
-   LEDs
-   Serial Console
-   mbed
-   Freedom KL26Z-specific Configuration Options
-   Configurations

Development Environment
=======================

Either Linux or Cygwin under Windows can be used for the development
environment. The source has been built only using the GNU toolchain (see
below). Other toolchains will likely cause problems.

GNU Toolchain Options
=====================

As of this writing, all testing has been performed using the NuttX
buildroot toolchain described below. I have also verified the build
using the CodeSourcery GCC toolchain for windows. Most any contemporary
EABI GCC toolchain should work will a little tinkering.

NuttX Buildroot Toolchain
=========================

A GNU GCC-based toolchain is assumed. The PATH environment variable
should be modified to point to the correct path to the Cortex-M0 GCC
toolchain (if different from the default in your PATH variable).

If you have no Cortex-M0 toolchain, one can be downloaded from the NuttX
Bitbucket download site
(https://bitbucket.org/nuttx/buildroot/downloads/). This GNU toolchain
builds and executes in the Linux or Cygwin environment.

1.  You must have already configured NuttX in `<some-dir>`{=html}/nuttx.

    tools/configure.sh freedom-kl26z:`<sub-dir>`{=html}

2.  Download the latest buildroot package into `<some-dir>`{=html}

3.  unpack the buildroot tarball. The resulting directory may have
    versioning information on it like buildroot-x.y.z. If so, rename
    `<some-dir>`{=html}/buildroot-x.y.z to
    `<some-dir>`{=html}/buildroot.

4.  cd `<some-dir>`{=html}/buildroot

5.  cp boards/cortexm0-eabi-defconfig-4.6.3 .config

6.  make oldconfig

7.  make

8.  Make sure that the PATH variable includes the path to the newly
    built binaries.

See the file boards/README.txt in the buildroot source tree. That has
more details PLUS some special instructions that you will need to follow
if you are building a Cortex-M0 toolchain for Cygwin under Windows.

LEDs
====

The Freedom KL26Z has a single RGB LED driven by the KL26Z as follows:

    ------------- --------
    RGB LED       KL26Z128
    ------------- --------
    Red Cathode   PTE29
    Green Cathode PTE31
    Blue Cathode  PTD5

NOTE: PTD5 is also connected to the I/O header on J2 pin 12 (also known
as D13).

If CONFIG\_ARCH\_LEDs is defined, then NuttX will control the LED on
board the Freedom KL26Z. The following definitions describe how NuttX
controls the LEDs:

    SYMBOL                Meaning                 LED state
                                                  Initially all LED is OFF
    -------------------  -----------------------  --------------------------
    LED_STARTED          NuttX has been started   R=OFF G=OFF B=OFF
    LED_HEAPALLOCATE     Heap has been allocated  (no change)
    LED_IRQSENABLED      Interrupts enabled       (no change)
    LED_STACKCREATED     Idle stack created       R=OFF G=OFF B=ON
    LED_INIRQ            In an interrupt          (no change)
    LED_SIGNAL           In a signal handler      (no change)
    LED_ASSERTION        An assertion failed      (no change)
    LED_PANIC            The system has crashed   R=FLASHING G=OFF B=OFF
    LED_IDLE             K26Z1XX is in sleep mode (Optional, not used)

Serial Console
==============

As with most NuttX configurations, the Freedom KL26Z configurations
depend on having a serial console to interact with the software. The
Freedom KL26Z, however, has no on-board RS-232 drivers so will be
necessary to connect the Freedom KL26Z UART pins to an external RS-232
driver board or TTL-to-Serial USB adaptor.

By default UART0 is used as the serial console on this boards. The UART0
is configured to work with the OpenSDA USB CDC/ACM port:

    ------ ------------------------------- -----------------------------
    PIN    PIN FUNCTIONS                   BOARD SIGNALS
    ------ ------------------------------- -----------------------------
    Pin 27 PTA1/TSI0_CH2/UART0_RX/FTM2_CH0 UART1_RX_TGTMCU and D0 (PTA1)
    Pin 28 PTA2/TSI0_CH3/UART0_TX/FTM2_CH1 UART1_TX_TGTMCU and D1 (PTA2)

But the UART0 Tx/Rx signals are also available on J1:

    ---------------- ---------
    UART0 SIGNAL     J1 pin
    ---------------- ---------
    UART0_RX (PTA1)  J1, pin 2
    UART0_TX (PTA2)  J1, pin 4

Ground is available on J2 pin 14. 3.3V is available on J3 and J4.

Freedom KL26Z-specific Configuration Options
============================================

    CONFIG_ARCH - Identifies the arch/ subdirectory.  This should
       be set to:

       CONFIG_ARCH=arm

    CONFIG_ARCH_family - For use in C code:

       CONFIG_ARCH_ARM=y

    CONFIG_ARCH_architecture - For use in C code:

       CONFIG_ARCH_CORTEXM0=y

    CONFIG_ARCH_CHIP - Identifies the arch/*/chip subdirectory

       CONFIG_ARCH_CHIP=kl

    CONFIG_ARCH_CHIP_name - For use in C code to identify the exact
       chip:

       CONFIG_ARCH_CHIP_MKL26Z128=y

    CONFIG_ARCH_BOARD - Identifies the boards/ subdirectory and
       hence, the board that supports the particular chip or SoC.

       CONFIG_ARCH_BOARD=freedom-kl26z (for the Freescale FRDM-KL26Z development board)

    CONFIG_ARCH_BOARD_name - For use in C code

       CONFIG_ARCH_BOARD_FREEDOM_K26Z128=y

    CONFIG_ARCH_LOOPSPERMSEC - Must be calibrated for correct operation
       of delay loops

    CONFIG_ENDIAN_BIG - define if big endian (default is little
       endian)

    CONFIG_RAM_SIZE - Describes the installed DRAM (SRAM in this case):

       CONFIG_RAM_SIZE=16384 (16Kb)

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

Individual subsystems can be enabled as follows. These settings are for
all of the K25Z100/120 line and may not be available for the MKL26Z128
in particular:

AHB ---

    CONFIG_KL_PDMA    Peripheral DMA
    CONFIG_KL_FMC     Flash memory
    CONFIG_KL_EBI     External bus interface

APB1 ----

    CONFIG_KL_WDT     Watchdog timer
    CONFIG_KL_RTC     Real time clock (RTC)
    CONFIG_KL_TMR0    Timer0
    CONFIG_KL_TMR1    Timer1
    CONFIG_KL_I2C0    I2C interface
    CONFIG_KL_SPI0    SPI0 master/slave
    CONFIG_KL_SPI1    SPI1 master/slave
    CONFIG_KL_PWM0    PWM0
    CONFIG_KL_PWM1    PWM1
    CONFIG_KL_PWM2    PWM2
    CONFIG_KL_PWM3    PWM3
    CONFIG_KL_UART0   UART0
    CONFIG_KL_USBD    USB 2.0 FS device controller
    CONFIG_KL_ACMP    Analog comparator
    CONFIG_KL_ADC     Analog-digital-converter (ADC)

APB2 ---

    CONFIG_KL_PS2     PS/2 interface
    CONFIG_KL_TIMR2   Timer2
    CONFIG_KL_TIMR3   Timer3
    CONFIG_KL_I2C1    I2C1 interface
    CONFIG_KL_SPI2    SPI2 master/slave
    CONFIG_KL_SPI3    SPI3 master/slave
    CONFIG_KL_PWM4    PWM4
    CONFIG_KL_PWM5    PWM5
    CONFIG_KL_PWM6    PWM6
    CONFIG_KL_PWM7    PWM7
    CONFIG_KL_UART1   UART1
    CONFIG_KL_UART2   UART2
    CONFIG_KL_I2S     I2S interface

K26Z1XX specific device driver settings

    CONFIG_UARTn_SERIAL_CONSOLE - Selects the UARTn (n=0,1,2) for the
      console and ttys0.
    CONFIG_UARTn_RXBUFSIZE - Characters are buffered as received.
       This specific the size of the receive buffer for UARTn.
    CONFIG_UARTn_TXBUFSIZE - Characters are buffered before
       being sent.  This specific the size of the transmit buffer
       for UARTn.
    CONFIG_UARTn_BAUD - The configure BAUD of UARTn,
    CONFIG_UARTn_BITS - The number of bits.  Must be 5, 6, 7, or 8.
    CONFIG_UARTn_PARTIY - 0=no parity, 1=odd parity, 2=even parity
    CONFIG_UARTn_2STOP - Two stop bits

Configurations
==============

Each FREEDOM-KL26Z configuration is maintained in a sub-directory and
can be selected as follow:

    tools/configure.sh freedom-kl26z:<subdir>

If this is a Windows native build, then configure.bat should be used
instead of configure.sh:

    configure.bat freedom-kl26z\<subdir>

Where `<subdir>`{=html} is one of the following:

  nsh:
  ------------------------------------------------------------------
  Configures the NuttShell (nsh) located at apps/examples/nsh. The
  Configuration enables the serial interface on UART0. Support for
  builtin applications is disabled.

    NOTES:

    1. This configuration uses the mconf-based configuration tool.  To
       change this configuration using that tool, you should:

       a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
          see additional README.txt files in the NuttX tools repository.

       b. Execute 'make menuconfig' in nuttx/ in order to start the
          reconfiguration process.

    2. By default, this configuration uses the ARM EABI toolchain
       for Windows and builds under Cygwin (or probably MSYS).  That
       can easily be reconfigured, of course.

       CONFIG_HOST_WINDOWS=y                   : Builds under Windows
       CONFIG_WINDOWS_CYGWIN=y                 : Using Cygwin
       CONFIG_ARM_TOOLCHAIN_GNU_EABI=y      : GNU EABI toolchain for Windows

    3. Serial Console.  A serial console is necessary to interrupt with
       NSH.   The serial console is configured on UART0 which is available
       on J1:

       ---------------- ---------
       UART0 SIGNAL     J1 pin
       ---------------- ---------
       UART0_RX (PTA1)  J1, pin 2
       UART0_TX (PTA2)  J1, pin 4

       Ground is available on J2 pin 14.  3.3V is available on J3 and J4.

       It is possible to configure NSH to use a USB serial console instead
       of an RS-232 serial console.  However, that configuration has not
       been implemented as of this writing.

    4. Memory Usage.  The size command gives us the static memory usage.
       This is what I get:

       $ size nuttx
          text    data     bss     dec     hex filename
         35037     106    1092   36235    8d8b nuttx

       And we can get the runtime memory usage from the NSH free command:

       NuttShell (NSH) NuttX-6.25
       nsh> free
            total  used free  largest
       Mem: 14160  3944 10216 10216
       nsh>

       Summary:

       - This slightly tuned NSH example uses 34.2KB of FLASH leaving 93.8KB
         of FLASH (72%) free from additional application development.

         I did not do all of the arithmetic, but it appears to me that of this
         34+KB of FLASH usage, probably 20-30% of the FLASH is used by libgcc!
         libgcc has gotten very fat!

       - Static SRAM usage is about 1.2KB (<4%).

       - At run time, 10.0KB of SRAM (62%) is still available for additional
         applications. Most of the memory used at runtime is allocated I/O
         buffers and the stack for the NSH main thread (1.5KB).

       There is probably enough free memory to support 3 or 4 application
       threads in addition to NSH.

    5. This configurations has support for NSH built-in applications.  However,
       in the default configuration no built-in applications are enabled.
