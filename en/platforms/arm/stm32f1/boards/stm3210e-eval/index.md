ST STM3210E-EVAL
================

chip:stm32, chip:stm32f1, chip:stm32f103

This page discusses issues unique to NuttX configurations for the
STMicro STM3210E-EVAL development board.

DFU and JTAG
------------

### Enabling Support for the DFU Bootloader

The linker files in these projects can be configured to indicate that
you will be loading code using STMicro built-in USB Device Firmware
Upgrade (DFU) loader or via some JTAG emulator. You can specify the DFU
bootloader by adding the following line:

    CONFIG_STM32_DFU=y

to your .config file. Most of the configurations in this directory are
set up to use the DFU loader.

If CONFIG\_STM32\_DFU is defined, the code will not be positioned at the
beginning of FLASH (0x08000000) but will be offset to 0x08003000. This
offset is needed to make space for the DFU loader and 0x08003000 is
where the DFU loader expects to find new applications at boot time. If
you need to change that origin for some other bootloader, you will need
to edit the file(s) ld.script.dfu for the configuration.

The DFU SE PC-based software is available from the STMicro website,
<http://www.st.com>. General usage instructions:

1.  Convert the NuttX Intel Hex file (nuttx.hex) into a special DFU file
    (nuttx.dfu)\... see below for details.
2.  Connect the STM3210E-EVAL board to your computer using a USB cable.
3.  Start the DFU loader on the STM3210E-EVAL board. You do this by
    resetting the board while holding the \"Key\" button. Windows should
    recognize that the DFU loader has been installed.
4.  Run the DFU SE program to load nuttx.dfu into FLASH.

What if the DFU loader is not in FLASH? The loader code is available
inside of the Demo directory of the USBLib ZIP file that can be
downloaded from the STMicro Website. You can build it using RIDE (or
other toolchains); you will need a JTAG emulator to burn it into FLASH
the first time.

In order to use STMicro\'s built-in DFU loader, you will have to get the
NuttX binary into a special format with a .dfu extension. The DFU SE
PC\_based software installation includes a file \"DFU File Manager\"
conversion program that a file in Intel Hex format to the special DFU
format. When you successfully build NuttX, you will find a file called
nutt.hex in the top-level directory. That is the file that you should
provide to the DFU File Manager. You will end up with a file called
nuttx.dfu that you can use with the STMicro DFU SE program.

### Enabling JTAG

If you are not using the DFU, then you will probably also need to enable
JTAG support. By default, all JTAG support is disabled but there NuttX
configuration options to enable JTAG in various different ways.

These configurations effect the setting of the SWJ\_CFG\[2:0\] bits in
the AFIO MAPR register. These bits are used to configure the SWJ and
trace alternate function I/Os. The SWJ (SerialWire JTAG) supports JTAG
or SWD access to the Cortex debug port. The default state in this port
is for all JTAG support to be disabled.

CONFIG\_STM32\_JTAG\_FULL\_ENABLE - sets SWJ\_CFG\[2:0\] to 000 which
enables full SWJ (JTAG-DP + SW-DP)

CONFIG\_STM32\_JTAG\_NOJNTRST\_ENABLE - sets SWJ\_CFG\[2:0\] to 001
which enable full SWJ (JTAG-DP + SW-DP) but without JNTRST.

CONFIG\_STM32\_JTAG\_SW\_ENABLE - sets SWJ\_CFG\[2:0\] to 010 which
would set JTAG-DP disabled and SW-DP enabled.

The default setting (none of the above defined) is SWJ\_CFG\[2:0\] set
to 100 which disable JTAG-DP and SW-DP.

OpenOCD
-------

I have also used OpenOCD with the STM3210E-EVAL. In this case, I used
the Olimex USB ARM OCD. See the script in
boards/arm/stm32/stm3210e-eval/tools/oocd.sh for more information. Using
the script:

-   Start the OpenOCD GDB server:

        cd <nuttx-build-directory>
        boards/arm/stm32/stm3210e-eval/tools/oocd.sh PWD

-   Load NuttX:

        cd <nuttx-built-directory>
        arm-none-eabi-gdb nuttx
        gdb> target remote localhost:3333
        gdb> mon reset
        gdb> mon halt
        gdb> load nuttx

-   Running NuttX:

        gdb> mon reset
        gdb> c

LEDs
----

The STM3210E-EVAL board has four LEDs labeled LD1, LD2, LD3 and LD4 on
the board. These LEDs are not used by the board port unless
CONFIG\_ARCH\_LEDS is defined. In that case, the usage by the board port
is defined in include/board.h and src/up\_leds.c. The LEDs are used to
encode OS-related events as follows:

>   SYMBOL                 Meaning                                         LED1\[1\]   LED2   LED3   LED4\[4\]
>   ---------------------- ----------------------------------------------- ----------- ------ ------ -----------
>   LED\_STARTED           NuttX has been started                          ON          OFF    OFF    OFF
>   LED\_HEAPALLOCATE      Heap has been allocated                         OFF         ON     OFF    OFF
>   LED\_IRQSENABLED       Interrupts enabled                              ON          ON     OFF    OFF
>   LED\_STACKCREATED      Idle stack created                              OFF         OFF    ON     OFF
>   LED\_INIRQ             In an interrupt\[2\]                            ON          N/C    N/C    OFF
>   LED\_SIGNAL            In a signal handler\[3\]                        N/C         ON     N/C    OFF
>   LED\_ASSERTION         An assertion failed                             ON          ON     N/C    OFF
>   LED\_PANIC LED\_IDLE   The system has crashed STM32 is is sleep mode   N/C         N/C    N/C    ON
>
> \[1\] If LED1, LED2, LED3 are statically on, then NuttX probably
> failed to boot and these LEDs will give you some indication of where
> the failure was \[2\] The normal state is LED1 ON and LED1 faintly
> glowing. This faint glow is because of timer interrupts that result in
> the LED being illuminated on a small proportion of the time. \[3\]
> LED2 may also flicker normally if signals are processed. \[4\] LED4
> may not be available if RS-485 is also used. For RS-485, it will then
> indicate the RS-485 direction.

Temperature Sensor
------------------

### LM-75 Temperature Sensor Driver

Support for the on-board LM-75 temperature sensor is available. This
support has been verified, but has not been included in any of the
available the configurations. To set up the temperature sensor, add the
following to the NuttX configuration file:

    Drivers -> Sensors
      CONFIG_SENSORS_LM75=y
      CONFIG_LM75_I2C=y

Then you can implement logic like the following to use the temperature
sensor:

    #include <nuttx/sensors/lm75.h>
    #include <arch/board/board.h>

    ret = stm32_lm75initialize("/dev/temp");        /* Register the temperature sensor */
    fd  = open("/dev/temp", O_RDONLY);              /* Open the temperature sensor device */
    ret = ioctl(fd, SNIOC_FAHRENHEIT, 0);           /* Select Fahrenheit */
    bytesread = read(fd, buffer, 8*sizeof(b16_t));  /* Read temperature samples */

More complex temperature sensor operations are also available. See the
IOCTL commands enumerated in include/nuttx/sensors/lm75.h. Also read the
descriptions of the stm32\_lm75initialize() and stm32\_lm75attach()
interfaces in the arch/board/board.h file (sames as
boards/arm/stm32/stm3210e-eval/include/board.h).

### NSH Command Line Application

There is a tiny NSH command line application at examples/system/lm75
that will read the current temperature from an LM75 compatible
temperature sensor and print the temperature on stdout in either units
of degrees Fahrenheit or Centigrade. This tiny command line application
is enabled with the following configuration options:

    Library
      CONFIG_LIBM=y
      CONFIG_LIBC_FLOATINGPOINT=y

    Applications -> NSH Library
      CONFIG_NSH_ARCHINIT=y

    Applications -> System Add-Ons
      CONFIG_SYSTEM_LM75=y
      CONFIG_SYSTEM_LM75_DEVNAME="/dev/temp"
      CONFIG_SYSTEM_LM75_FAHRENHEIT=y  (or CENTIGRADE)
      CONFIG_SYSTEM_LM75_STACKSIZE=1024
      CONFIG_SYSTEM_LM75_PRIORITY=100

RTC
---

The STM32 RTC may configured using the following settings.:

    CONFIG_RTC - Enables general support for a hardware RTC. Specific
      architectures may require other specific settings.
    CONFIG_RTC_HIRES - The typical RTC keeps time to resolution of 1
      second, usually supporting a 32-bit time_t value.  In this case,
      the RTC is used to &quot;seed&quot; the normal NuttX timer and the
      NuttX timer provides for higher resolution time. If CONFIG_RTC_HIRES
      is enabled in the NuttX configuration, then the RTC provides higher
      resolution time and completely replaces the system timer for purpose of
      date and time.
    CONFIG_RTC_FREQUENCY - If CONFIG_RTC_HIRES is defined, then the
      frequency of the high resolution RTC must be provided.  If CONFIG_RTC_HIRES
      is not defined, CONFIG_RTC_FREQUENCY is assumed to be one.
    CONFIG_RTC_ALARM - Enable if the RTC hardware supports setting of an alarm.
      A callback function will be executed when the alarm goes off.

In hi-res mode, the STM32 RTC operates only at 16384Hz. Overflow
interrupts are handled when the 32-bit RTC counter overflows every 3
days and 43 minutes. A BKP register is incremented on each overflow
interrupt creating, effectively, a 48-bit RTC counter.

In the lo-res mode, the RTC operates at 1Hz. Overflow interrupts are not
handled (because the next overflow is not expected until the year 2106).

WARNING: Overflow interrupts are lost whenever the STM32 is powered
down. The overflow interrupt may be lost even if the STM32 is powered
down only momentarily. Therefore hi-res solution is only useful in
systems where the power is always on.

FSMC SRAM
---------

The 8-Mbit SRAM is connected to the STM32 at PG10 which will be
FSMC\_NE3, Bank1 SRAM3. This memory will appear at address 0x68000000.

The on-board SRAM can be configured by setting:

    CONFIG_STM32_FSMC=y                         : Enables the FSMC
    CONFIG_STM32_EXTERNAL_RAM=y                 : Enable external SRAM support
    CONFIG_HEAP2_BASE=0x68000000                : SRAM will be located at 0x680000000
    CONFIG_HEAP2_SIZE=1048576                   : The size of the SRAM is 1Mbyte
    CONFIG_MM_REGIONS=2                         : There will be two memory regions
                                                : in the heap

STM3210E-EVAL-specific Configuration Options
--------------------------------------------

Configurations
--------------

Each STM3210E-EVAL configuration is maintained in a sub-directory and
can be selected as follow:

    tools/configure.sh stm3210e-eval:<subdir>

Where \<subdir\> is one of the following:

### composite

This configuration exercises a composite USB interface consisting of a
CDC/ACM device and a USB mass storage device. This configuration uses
apps/system/composite.

### nsh and nsh2

Configure the NuttShell (nsh) located at examples/nsh.

Differences between the two NSH configurations:

    =========== ======================= ================================
                nsh                     nsh2
    =========== ======================= ================================
    Platform    Windows with Cygwin (2) Windows with Cygwin (2)
    ----------- ----------------------- --------------------------------
    Toolchain:  NuttX buildroot (1)     ARM EABI GCC for Windows (1)
    ----------- ----------------------- --------------------------------
    Loader:     DfuSe                   DfuSe
    ----------- ----------------------- --------------------------------
    Serial      Debug output: USART1    Debug output: USART1
    Console:    NSH output:   USART1    NSH output:   USART1 (3)
    ----------- ----------------------- --------------------------------
    I2C         No                      I2C1
    ----------- ----------------------- --------------------------------
    microSD     Yes                     Yes
    Support
    ----------- ----------------------- --------------------------------
    FAT FS      CONFIG_FAT_LCNAMES=y    CONFIG_FAT_LCNAMES=y
    Config      CONFIG_FAT_LFN=n        CONFIG_FAT_LFN=y (4)
    ----------- ----------------------- --------------------------------
    Support for No                      Yes
    Built-in
    Apps
    ----------- ----------------------- --------------------------------
    Built-in    None                    apps/examples/nx
    Apps                                apps/examples/nxhello
                                        apps/system/usbmsc (5)
                                        apps/system/i2c
    =========== ======================= ================================

    (1) You will probably need to modify PATH environment variable to
        to include the correct path to the binaries for whichever
        toolchain you may use.
    (2) Since DfuSe is assumed, this configuration may only work under
        Cygwin without modification.
    (3) When any other device other than /dev/console is used for a user
        interface, (1) linefeeds (\n) will not be expanded to carriage return
        / linefeeds \r\n). You will need to configure your terminal program
        to account for this. And (2) input is not automatically echoed so
        you will have to turn local echo on.
    (4) Microsoft holds several patents related to the design of
        long file names in the FAT file system.  Please refer to the
        details in the top-level NOTICE file.  Please do not use FAT
        long file name unless you are familiar with these patent issues.
    (5) When built as an NSH add-on command (CONFIG_NSH_BUILTIN_APPS=y),
        Caution should be used to assure that the SD drive is not in use when
        the USB storage device is configured.  Specifically, the SD driver
        should be unmounted like:

        nsh> mount -t vfat /dev/mmcsd0 /mnt/sdcard # Card is mounted in NSH
        ...
        nsh> umount /mnd/sdcard                    # Unmount before connecting USB!!!
        nsh> msconn                                # Connect the USB storage device
        ...
        nsh> msdis                                 # Disconnect USB storate device
        nsh> mount -t vfat /dev/mmcsd0 /mnt/sdcard # Restore the mount

        Failure to do this could result in corruption of the SD card format.

    1. Both configurations use the mconf-based configuration tool.  To
       change these configurations using that tool, you should:

       a. Build and install the kconfig-mconf tool.  See nuttx/README.txt
          see additional README.txt files in the NuttX tools repository.

       b. Execute 'make menuconfig' in nuttx/ in order to start the
          reconfiguration process.

    2. The nsh2 contains support for some built-in applications that can be
       enabled by make some additional minor changes:

       a. examples/can.  The CAN test example can be enabled by changing the
          following settings in nsh2/defconfig:

          CONFIG_CAN=y                   : Enable CAN "upper-half" driver support
          CONFIG_STM32_CAN1=y            : Enable STM32 CAN1 "lower-half" driver support

          The default CAN settings may need to change in your board board
          configuration:

          CONFIG_CAN_EXTID=y             : Support extended IDs
          CONFIG_STM32_CAN1_BAUD=250000  : Bit rate: 250 KHz
          CONFIG_STM32_CAN_TSEG1=12      : 80% sample point
          CONFIG_STM32_CAN_TSEG2=3

### nx

An example using the NuttX graphics system (NX). This example focuses on
general window controls, movement, mouse and keyboard input.:

    CONFIG_ARM_TOOLCHAIN_GNU_EABI=y  : GNU EABI toolchain for Windows
    CONFIG_LCD_RPORTRAIT=y              : 240x320 reverse portrait

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configurations using that tool, you should:

    > a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
    >     see additional README.txt files in the NuttX tools repository.
    > b.  Execute \'make menuconfig\' in nuttx/ in order to start the
    >     reconfiguration process.

2.  If you configured the multi-used NX server (which is disabled by
    default), then you would also need:

        CONFIG_EXAMPLES_NX_CLIENTPRIO=80
        CONFIG_EXAMPLES_NX_SERVERPRIO=120
        CONFIG_EXAMPLES_NX_STACKSIZE=2048

3.  This example provides a framework for a number of other standalone
    graphics tests.

    > a.  apps/examples/nxlines: The NXLINES graphic example illustrates
    >     drawing of fat lines in various orientations. You can modify
    >     this configuration so to support the NXLINES example by making
    >     the following modifications to the NuttX configuration file:
    >
    >     Provide the new start-up entry point:
    >
    >     > CONFIG\_INIT\_ENTRYPOINT=\"nxlines\_main\"
    >
    >     Disable apps/examples/nx:
    >
    >     > CONFIG\_EXAMPLES\_NX=n
    >
    >     Enable and configure apps/nxlines/nxlines:
    >
    >     > CONFIG\_EXAMPLES\_NXLINES=y
    >     > CONFIG\_EXAMPLES\_NXLINES\_VPLANE=0
    >     > CONFIG\_EXAMPLES\_NXLINES\_DEVNO=0
    >     > CONFIG\_EXAMPLES\_NXLINES\_DEFAULT\_COLORS=n
    >     > CONFIG\_EXAMPLES\_NXLINES\_BGCOLOR=0x0320
    >     > CONFIG\_EXAMPLES\_NXLINES\_LINEWIDTH=16
    >     > CONFIG\_EXAMPLES\_NXLINES\_LINECOLOR=0xffe0
    >     > CONFIG\_EXAMPLES\_NXLINES\_BORDERWIDTH=4
    >     > CONFIG\_EXAMPLES\_NXLINES\_BORDERCOLOR=0xffe0
    >     > CONFIG\_EXAMPLES\_NXLINES\_CIRCLECOLOR=0xf7bb
    >     > CONFIG\_EXAMPLES\_NXLINES\_BPP=16
    >     > CONFIG\_EXAMPLES\_NXLINES\_EXTERNINIT=n
    >
    > b.  apps/examples/nxtext: Another example using the NuttX graphics
    >     system (NX). This example focuses on placing text on the
    >     background while pop-up windows occur. Text should continue to
    >     update normally with or without the popup windows present.
    >
    >     You can modify this configuration so to support the NXLINES
    >     example by making the following modifications to the NuttX
    >     configuration file:
    >
    >     Provide the new start-up entry point:
    >
    >         CONFIG_INIT_ENTRYPOINT="nxtext_main"
    >
    >     Disable apps/examples/nx:
    >
    >         CONFIG_EXAMPLES_NX=n
    >
    >     Enable an NX font:
    >
    >         CONFIG_NXFONT_SERIF22X28B=y
    >
    >     Enable and configure apps/nxlines/nxtext:
    >
    >         CONFIG_EXAMPLES_NXTEXT=y
    >         CONFIG_EXAMPLES_NXTEXT_VPLANE=0
    >         CONFIG_EXAMPLES_NXTEXT_DEVNO=0
    >         CONFIG_EXAMPLES_NXTEXT_BPP=16
    >         CONFIG_EXAMPLES_NXTEXT_BMCACHE=512
    >         CONFIG_EXAMPLES_NXTEXT_GLCACHE=16
    >         CONFIG_EXAMPLES_NXTEXT_DEFAULT_COLORS=n
    >         CONFIG_EXAMPLES_NXTEXT_BGCOLOR=0x0011
    >         CONFIG_EXAMPLES_NXTEXT_BGFONTCOLOR=0xffdf
    >         CONFIG_EXAMPLES_NXTEXT_PUCOLOR=0xfd20
    >         CONFIG_EXAMPLES_NXTEXT_PUFONTCOLOR=0x001f
    >         CONFIG_EXAMPLES_NXTEXT_DEFAULT_FONT=n
    >         CONFIG_EXAMPLES_NXTEXT_BGFONTID=11
    >         CONFIG_EXAMPLES_NXTEXT_PUFONTID=1
    >         CONFIG_EXAMPLES_NXTEXT_EXTERNINIT=n
    >
    >     If you configured the multi-used NX server (which is disabled
    >     by default), then you would also need:
    >
    >         CONFIG_EXAMPLES_NXTEXT_STACKSIZE=2048
    >         CONFIG_EXAMPLES_NXTEXT_CLIENTPRIO=80
    >         CONFIG_EXAMPLES_NXTEXT_SERVERPRIO=120
    >
    > > c.  
    > >
    > >     Others could be similar configured: apps/examples/nxhello,
    > >
    > >     :   nximage, \...
    >
    > 4\. The nsh configuration was used to verify the discrete joystick
    > (DJoystick driver). If you would like to duplicate this test,
    > below are the configuration changes needed to setup the DJoystick
    > driver (see nuttx/drivers/input/djoystick.c) and the DJoystick
    > test (see apps/examples/djoystick):
    >
    >     Pre-requisites:
    >
    >       CONFIG_BUILTIN=y           # Enable support for built-in applications
    >       CONFIG_NSH_BUILTIN_APPS=y  # Enable NSH built-in applications
    >
    >     Enable the DJoystick driver:
    >
    >       CONFIG_INPUT=y             # Enable input driver support
    >       CONFIG_INPUT_DJOYSTICK=y   # Enable the joystick drivers
    >                                  # (default parameters should be okay)
    >     Enable the DJoystick Example:
    >
    >      CONFIG_EXAMPLES_DJOYSTICK=y  # Enable the DJoystick example
    >      CONFIG_EXAMPLES_DJOYSTICK_DEVNAME="/dev/djoy0"
    >
    > When running the configuration, you should see the built-in
    > application \'djoy\'. Just type \'djoy\' at the NSH command
    > prompt.

### nxterm

This is yet another NSH configuration. This NSH configuration differs
from the other, however, in that it uses the NxTerm driver to host the
NSH shell.

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configurations using that tool, you should:

    a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
        see additional README.txt files in the NuttX tools repository.
    b.  Execute \'make menuconfig\' in nuttx/ in order to start the
        reconfiguration process.

2.  Some of the differences in this configuration include these settings
    in the defconfig file:

    These select NX Multi-User mode:

        CONFG_NX_MULTIUSER=y
        CONFIG_DISABLE_MQUEUE=n

    The following definition in the defconfig file to enables the NxTerm
    driver:

        CONFIG_NXTERM=y

    And this selects apps/examples/nxterm instead of apps/examples/nsh:

        CONFIG_EXAMPLES_NXTERM=y

    Other configuration settings of interest:

        CONFIG_HOST_WINDOWS=y               : Windows
        CONFIG_WINDOWS_CYGWIN=y             : with Cygwin
        CONFIG_ARM_TOOLCHAIN_BUILDROOT=y : NuttX buildroot under Linux or Cygwin
        CONFIG_LCD_LANDSCAPE=y              : 320x240 landscape

### pm

This is a configuration that is used to test STM32 power management,
i.e., to test that the board can go into lower and lower states of power
usage as a result of inactivity. This configuration is based on the nsh2
configuration with modifications for testing power management. This
configuration should provide some guideline for power management in your
STM32 application.

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configurations using that tool, you should:

    a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
        see additional README.txt files in the NuttX tools repository.
    b.  Execute \'make menuconfig\' in nuttx/ in order to start the
        reconfiguration process.

2.  Default configuration is Cygwin under windows using the ARM EABI
    toolchain:

        CONFIG_HOST_WINDOWS=y                   : Windows
        CONFIG_WINDOWS_CYGWIN=y                 : Cygwin
        CONFIG_ARM_TOOLCHAIN_GNU_EABI=y      : GNU EABI toolchain for Windows

3.  CONFIG\_ARCH\_CUSTOM\_PMINIT and CONFIG\_ARCH\_IDLE\_CUSTOM are
    necessary parts of the PM configuration:

        CONFIG_ARCH_CUSTOM_PMINIT=y

    CONFIG\_ARCH\_CUSTOM\_PMINIT moves the PM initialization from
    arch/arm/src/stm32/stm32\_pminitialiaze.c to
    boards/arm/stm32/stm3210-eval/src/stm32\_pm.c. This allows us to
    support board-specific PM initialization.:

        CONFIG_ARCH_IDLE_CUSTOM=y

    The bulk of the PM activities occur in the IDLE loop. The IDLE loop
    is special because it is what runs when there is no other task
    running. Therefore when the IDLE executes, we can be assure that
    nothing else is going on; this is the ideal condition for doing
    reduced power management.

    The configuration CONFIG\_ARCH\_IDLE\_CUSTOM allows us to \"steal\"
    the normal STM32 IDLE loop (of arch/arm/src/stm32/stm32\_idle.c) and
    replace this with our own custom IDLE loop (at
    boards/arm/stm32/stm3210-eval/src/up\_idle.c).

4.  Here are some additional things to note in the configuration:

        CONFIG_PM_BUTTONS=y

    CONFIG\_PM\_BUTTONS enables button support for PM testing. Buttons
    can drive EXTI interrupts and EXTI interrupts can be used to wakeup
    for certain reduced power modes (STOP mode). The use of the buttons
    here is for PM testing purposes only; buttons would normally be part
    the application code and CONFIG\_PM\_BUTTONS would not be defined.:

        CONFIG_RTC_ALARM=y

    The RTC alarm is used to wake up from STOP mode and to transition to
    STANDBY mode. This used of the RTC alarm could conflict with other
    uses of the RTC alarm in your application.

### usbserial

This configuration directory exercises the USB serial class driver at
examples/usbserial. See examples/README.txt for more information.:

    CONFIG_ARM_TOOLCHAIN_BUILDROOT=y      : NuttX buildroot under Linux or Cygwin

USB debug output can be enabled as by changing the following settings in
the configuration file:

    -CONFIG_DEBUG_FEATURES=n
    -CONFIG_DEBUG_INFO=n
    -CONFIG_DEBUG_USB=n
    +CONFIG_DEBUG_FEATURES=y
    +CONFIG_DEBUG_INFO=y
    +CONFIG_DEBUG_USB=y

    -CONFIG_EXAMPLES_USBSERIAL_TRACEINIT=n
    -CONFIG_EXAMPLES_USBSERIAL_TRACECLASS=n
    -CONFIG_EXAMPLES_USBSERIAL_TRACETRANSFERS=n
    -CONFIG_EXAMPLES_USBSERIAL_TRACECONTROLLER=n
    -CONFIG_EXAMPLES_USBSERIAL_TRACEINTERRUPTS=n
    +CONFIG_EXAMPLES_USBSERIAL_TRACEINIT=y
    +CONFIG_EXAMPLES_USBSERIAL_TRACECLASS=y
    +CONFIG_EXAMPLES_USBSERIAL_TRACETRANSFERS=y
    +CONFIG_EXAMPLES_USBSERIAL_TRACECONTROLLER=y
    +CONFIG_EXAMPLES_USBSERIAL_TRACEINTERRUPTS=y

By default, the usbserial example uses the Prolific PL2303 serial/USB
converter emulation. The example can be modified to use the CDC/ACM
serial class by making the following changes to the configuration file:

    -CONFIG_PL2303=y
    +CONFIG_PL2303=n

    -CONFIG_CDCACM=n
    +CONFIG_CDCACM=y

The example can also be converted to use the alternative USB serial
example at apps/examples/usbterm by changing the following:

    -CONFIG_EXAMPLES_USBSERIAL=y
    +CONFIG_EXAMPLES_USBSERIAL=n

### usbmsc

This configuration directory exercises the USB mass storage class driver
at system/usbmsc. See examples/README.txt for more information.

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configurations using that tool, you should:

    a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
        see additional README.txt files in the NuttX tools repository.
    b.  Execute \'make menuconfig\' in nuttx/ in order to start the
        reconfiguration process.

2.  Build environment (can be easily reconfigured):

        CONFIG_HOST_LINUX=y                  : Linux (or Cygwin)
        CONFIG_ARM_TOOLCHAIN_BUILDROOT=y  : NuttX buildroot under Linux or Cygwin
