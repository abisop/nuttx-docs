stm32f103-minimum
=================

chip:stm32, chip:stm32f1, chip:stm32f103

This page discusses issues unique to NuttX configurations for the
STM32F103C8T6 Minimum System Development Board for ARM Microcontroller.

STM32F103C8T6 Minimum System Development Boards:
------------------------------------------------

This STM32F103C8T6 minimum system development board is available from
several vendors on the net, and may be sold under different names or no
name at all. It is based on a STM32F103C8T6 and has a DIP-40
form-factor.

There are four versions of very similar boards: Red, Blue, RoboDyn Black
and Black. See: <https://wiki.stm32duino.com/index.php?title=Blue_Pill>
<https://wiki.stm32duino.com/index.php?title=Red_Pill>
<https://wiki.stm32duino.com/index.php?title=RobotDyn_Black_Pill>
<https://wiki.stm32duino.com/index.php?title=Black_Pill>

The Red Board:

Good things about the red board:

-   1.5k pull up resistor on the PA12 pin (USB D+) which you can
    programmatically drag down for automated USB reset.
-   large power capacitors and LDO power.
-   User LED on PC13

Problems with the red board:

-   Silk screen is barely readable, the text is chopped off on some of
    the pins
-   USB connector only has two anchor points and it is directly soldered
    on the surface
-   Small reset button with hardly any resistance

The Blue Board:

Good things about the blue board:

-   

    Four soldered anchor point on the USB connector. What you can\'t tell

    :   from this picture is that there is a notch in the PCB board and
        the USB connector sits down inside it some. This provides some
        lateral stability that takes some of the stress off the solder
        points.

-   It has nice clear readable silkscreen printing.

-   It also a larger reset button.

-   User LED on PC13

Problems with the blue board:

-   

    Probably won\'t work as a USB device if it has a 10k pull-up on PA12. You

    :   have to check the pull up on PA12 (USB D+). If it has a 10k
        pull-up resistor, you will need to replace it with a 1.5k one to
        use the native USB.

-   Puny voltage regulator probably 100mA.

A schematic for the blue board is available here:
<http://www.stm32duino.com/download/file.php?id=276>

The Black Board:

-   User LED is on PB12.
-   Mounting holes.

Both Boards:

Nice features common to both:

-   SWD pins broken out and easily connected (VCC, GND, SWDIO, SWCLK)
-   USB 5V is broken out with easy access.
-   Power LED
-   You can probably use more flash (128k) than officially documented
    for the chip (stm32f103c8t6 64k), I was able to load 115k of flash
    on mine and it seemed to work.

Problems with both boards:

-   No preloaded bootloader (this isn\'t really a problem as the entire
    64k of flash is available for use)
-   No user button

This is the board pinout based on its form-factor for the Blue board:

LEDs
----

The STM32F103 Minimum board has only one software controllable LED. This
LED can be used by the board port when CONFIG\_ARCH\_LEDS option is
enabled.

If enabled the LED is simply turned on when the board boots
successfully, and is blinking on panic / assertion failed.

UARTs
-----

### UART/USART PINS

### Default USART/UART Configuration

USART1 (RX & TX only) is available through pins PA9 (TX) and PA10 (RX).

Timer Inputs/Outputs
--------------------

Using 128KiB of Flash instead of 64KiB
--------------------------------------

Some people figured out that the STM32F103C8T6 has 128KiB of internal
memory instead of 64KiB as documented in the datasheet and reported by
its internal register.

In order to enable 128KiB you need modify the linker script to reflect
this new size. Open the
boards/arm/stm32/stm32f103-minimum/scripts/ld.script and replace:

    flash (rx) : ORIGIN = 0x08000000, LENGTH = 64K

with:

    flash (rx) : ORIGIN = 0x08000000, LENGTH = 128K

Enable many NuttX features (ie. many filesystems and applications) to
get a large binary image with more than 64K.

We will use OpenOCD to write the firmware in the STM32F103C8T6 Flash.
Use a up to dated OpenOCD version (ie. openocd-0.9).

You will need to create a copy of original
openocd/scripts/target/stm32f1x.cfg to
openocd/scripts/target/stm32f103c8t6.cfg and edit the later file
replacing:

    flash bank _FLASHNAME stm32f1x 0x08000000 0 0 0 _TARGETNAME

with:

    flash bank _FLASHNAME stm32f1x 0x08000000 0x20000 0 0 _TARGETNAME

We will use OpenOCD with STLink-V2 programmer, but it will work with
other programmers (JLink, Versaloon, or some based on FTDI FT232, etc).

Open a terminal and execute:

     sudo openocd -f interface/stlink-v2.cfg -f target/stm32f103c8t6.cfg

Now in other terminal execute:

     telnet localhost 4444

    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    Open On-Chip Debugger

    > reset halt
    stm32f1x.cpu: target state: halted
    target halted due to debug-request, current mode: Thread
    xPSR: 0x01000000 pc: 0x080003ac msp: 0x20000d78

    > flash write_image erase nuttx.bin 0x08000000
    auto erase enabled
    device id = 0x20036410
    ignoring flash probed value, using configured bank size
    flash size = 128kbytes
    stm32f1x.cpu: target state: halted
    target halted due to breakpoint, current mode: Thread
    xPSR: 0x61000000 pc: 0x2000003a msp: 0x20000d78
    wrote 92160 bytes from file nuttx.bin in 4.942194s (18.211 KiB/s)

    > reset run
    > exit

Now NuttX should start normally.

Nintendo Wii Nunchuck:
----------------------

There is a driver on NuttX to support Nintendo Wii Nunchuck Joystick. If
you want to use it please select these options:

-   Enable the I2C1 at System Type -\> STM32 Peripheral Support, it will
    enable:

    > CONFIG\_STM32\_I2C1=y

-   Enable to Custom board/driver initialization at RTOS Features -\>
    RTOS hooks

    > CONFIG\_BOARD\_LATE\_INITIALIZE=y

-   Enable the I2C Driver Support at Device Drivers, it will enable this
    symbol:

    > CONFIG\_I2C=y

-   Nintendo Wii Nunchuck Joystick at Device Drivers -\> \[\*\] Input
    Device Support

    > CONFIG\_INPUT=y
    >
    > :   CONFIG\_INPUT\_NUNCHUCK=y

-   Enable the Nunchuck joystick example at Application Configuration
    -\> Examples

    CONFIG\_EXAMPLES\_NUNCHUCK=y

    :   CONFIG\_EXAMPLES\_NUNCHUCK\_DEVNAME=\"/dev/nunchuck0\"

You need to connect GND and +3.3V pins from Nunchuck connector to GND
and 3.3V of stm32f103-minimum respectively (Nunchuck also can work
connected to 5V, but I don\'t recommend it). Connect I2C Clock from
Nunchuck to SCK (PB6) and the I2C Data to SDA (PB7).

Quadrature Encoder:
-------------------

The nsh configuration has been used to test the Quadrature Encoder
(QEncoder, QE) with the following modifications to the configuration
file:

-   These setting enable support for the common QEncode upper half
    driver:

    > CONFIG\_SENSORS=y
    >
    > :   CONFIG\_SENSORS\_QENCODER=y

-   

    This is a board setting that selected timer 4 for use with the

    :   quadrature encode:

        CONFIG\_STM32F103MINIMUM\_QETIMER=4

-   These settings enable the STM32 Quadrature encoder on timer 4:

    > CONFIG\_STM32\_TIM4\_CAP=y CONFIG\_STM32\_TIM4\_QE=y
    > CONFIG\_STM32\_TIM4\_QECLKOUT=2800000
    > CONFIG\_STM32\_QENCODER\_FILTER=y
    > CONFIG\_STM32\_QENCODER\_SAMPLE\_EVENT\_6=y
    > CONFIG\_STM32\_QENCODER\_SAMPLE\_FDTS\_4=y

-   These settings enable the test case at apps/examples/qencoder:

    > CONFIG\_EXAMPLES\_QENCODER=y CONFIG\_EXAMPLES\_QENCODER\_DELAY=100
    > CONFIG\_EXAMPLES\_QENCODER\_DEVPATH=\"/dev/qe0\"

In this configuration, the QEncoder inputs will be on the TIM4 inputs of
PB6 and PB7.

SPI NOR Flash support:
----------------------

We can use an extern SPI NOR Flash with STM32F103-Minimum board. In this
case we tested the Winboard W25Q32FV (32Mbit = 4MiB).

You can connect the W25Q32FV module in the STM32F103 Minimum board this
way: connect PA5 (SPI1 CLK) to CLK; PA7 (SPI1 MOSI) to DI; PA6 (SPI
MISO) to DO; PA4 to /CS; Also connect 3.3V to VCC and GND to GND.

You can start with default \"stm32f103-minimum/nsh\" configuration
option and enable/disable these options using \"make menuconfig\" :

    System Type  --->
        STM32 Peripheral Support  --->
            [*] SPI1

    Board Selection  --->
        [*] MTD driver for external 4Mbyte W25Q32FV FLASH on SPI1
        (0)   Minor number for the FLASH /dev/smart entry
        [*]   Enable partition support on FLASH
        (1024,1024,1024,1024) Flash partition size list

    RTOS Features  --->
        Stack and heap information  --->
                (512) Idle thread stack size
                (1024) Main thread stack size
                (256) Minimum pthread stack size
                (1024) Default pthread stack size

    Device Drivers  --->
        -*- Memory Technology Device (MTD) Support  --->
                [*]   Support MTD partitions
                -*-   SPI-based W25 FLASH
                (0)     W25 SPI Mode
                (20000000) W25 SPI Frequency

    File Systems  --->
        [ ] Disable pseudo-filesystem operations
        -*- SMART file system
        (0xff) FLASH erased state
        (16)  Maximum file name length

    Memory Management  --->
        [*] Small memory model

    Also change the boards/arm/stm32/stm32f103-minimum/scripts/ld.script file to use 128KB
    of Flash instead 64KB (since this board has a hidden 64KB flash) :

    MEMORY
    {
        flash (rx) : ORIGIN = 0x08000000, LENGTH = 128K
        sram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
    }

    Then after compiling and flashing the file nuttx.bin you can format and mount
    the flash this way:

    nsh> mksmartfs /dev/smart0p0
    nsh> mksmartfs /dev/smart0p1
    nsh> mksmartfs /dev/smart0p2
    nsh> mksmartfs /dev/smart0p3

    nsh> mount -t smartfs /dev/smart0p0 /mnt
    nsh> ls /mnt
    /mnt:

    nsh> echo "Testing" > /mnt/file.txt

    nsh> ls /mnt
    /mnt:
     file.txt

    nsh> cat /mnt/file.txt
    Testing

    nsh>

SDCard support:
---------------

Only STM32F103xx High-density devices has SDIO controller. STM32F103C8T6
is a Medium-density device, but we can use SDCard over SPI.

You can do that enabling these options:

    CONFIG_FS_FAT=y

    CONFIG_MMCSD=y
    CONFIG_MMCSD_NSLOTS=1
    CONFIG_MMCSD_SPI=y
    CONFIG_MMCSD_SPICLOCK=20000000
    CONFIG_MMCSD_SPIMODE=0

    CONFIG_STM32_SPI=y
    CONFIG_STM32_SPI1=y

    CONFIG_SPI=y
    CONFIG_SPI_CALLBACK=y
    CONFIG_SPI_EXCHANGE=y

And connect a SDCard/SPI board on SPI1. Connect the CS pin to PA4, SCK
to PA5, MOSI to PA7 and MISO to PA6. Note: some chinese boards use MOSO
instead of MISO.

Nokia 5110 LCD Display support:
-------------------------------

You can connect a low cost Nokia 5110 LCD display in the STM32F103
Minimum board this way: connect PA5 (SPI1 CLK) to CLK; PA7 (SPI1 MOSI)
to DIN; PA4 to CE; PA3 to RST; PA2 to DC. Also connect 3.3V to VCC and
GND to GND.

You can start with default \"stm32f103-minimum/nsh\" configuration
option and enable these options using \"make menuconfig\" :

    System Type  --->
        STM32 Peripheral Support  --->
            [*] SPI1

    Device Drivers  --->
        -*- SPI Driver Support  --->
            [*]   SPI exchange
            [*]   SPI CMD/DATA

    Device Drivers  --->
        LCD Driver Support  --->
            [*] Graphic LCD Driver Support  --->
                [*]   Nokia 5110 LCD Display (Phillips PCD8544)
                (1)     Number of PCD8544 Devices
                (84)    PCD8544 X Resolution
                (48)    PCD8544 Y Resolution

    Graphics Support  --->
        [*] NX Graphics
        (1)   Number of Color Planes

        (0x0) Initial background color
            Supported Pixel Depths  --->
                [ ] Disable 1 BPP
        [*]   Packed MS First

        Font Selections  --->
            (7) Bits in Character Set
            [*] Mono 5x8

    Application Configuration  --->
        Examples  --->
            [*] NX graphics "Hello, World!" example
            (1)   Bits-Per-Pixel

    After compiling and flashing the nuttx.bin inside the board, reset it.
    You should see it:

    NuttShell (NSH)
    nsh> ?
    help usage:  help [-v] [<cmd>]

      [           dd          free        mb          source      usleep
      ?           echo        help        mh          sleep       xd
      cat         exec        hexdump     mw          test
      cd          exit        kill        pwd         true
      cp          false       ls          set         unset

    Builtin Apps:
      nxhello

    Now just run nxhello and you should see "Hello World" in the display:

    nsh> nxhello

HYT271 sensor support
---------------------

The existing sensor configuration allows connecting several sensors of
type hyt271 on i2c bus number 2. For full feature support, be able to
change the i2c address of the sensor, the following hardware setup is
necessary.:

    ----------                                            -----------
    |        |------ GND ------------------------ GND ----|         |
    |        |                                            |         |
    |        |                                            |         |
    |        |                                            |         |
    |        |---- POWIN A00 ------.                      |         |
    |        |                     |                      |         |
    |        |                    4.7k                    |         |
    |        |                     |                      |         |
    | STM32  |--- POWOUT A01 ------.------.------ VDD ----| HYT271  |
    |        |                     |      |               |         |
    |        |                    2.2k    |               |         |
    |        |                     |      |               |         |
    |        |----- SDA2 B11 ------.----  | ----- SDA ----|         |
    |        |                            |               |         |
    |        |                           2.2k             |         |
    |        |                            |               |         |
    |        |----- SCL2 B10 -------------.------ SCL ----|         |
    |        |                                            |         |
    ---------                                             -----------

DS18B20 sensor support
----------------------

The existing sensor configuration allows connecting several sensors of
type ds18b20 on 1wire bus number 2. The following hardware setup is
necessary.:

    ---------                                            -----------
    |       |------ GND ----------.------------- GND ----|         |
    |       |                                            |         |
    |       |                                            |         |
    |       |                                            |         |
    |       |------ VDD ----------.------------- VDD ----|         |
    | STM32 |                     |                      | DS18B20 |
    |       |                    4.7k                    |         |
    |       |                     |                      |         |
    |       |----- TX2 A02 -------.------.------- DQ ----|         |
    |       |                                            |         |
    --------                                             -----------

USB Console support
-------------------

The STM32F103C8 has a USB Device controller, then we can use NuttX
support to USB Device. We can the console over USB enabling these
options:

    System Type  --->
      STM32 Peripheral Support  --->
        [*] USB Device

    It will enable:  CONFIG_STM32_USB=y

    Board Selection  --->
      -*- Enable boardctl() interface
      [*]   Enable USB device controls

    It will enable: CONFIG_BOARDCTL_USBDEVCTRL=y

    Device Drivers  --->
      -*- USB Device Driver Support  --->
        [*]   USB Modem (CDC/ACM) support  --->

    It will enable:  CONFIG_CDCACM=y and many default options.

    Device Drivers  --->
      -*- USB Device Driver Support  --->
        [*]   USB Modem (CDC/ACM) support  --->
          [*]   CDC/ACM console device

    It will enable: CONFIG_CDCACM_CONSOLE=y

    Device Drivers  --->
      [*] Serial Driver Support  --->
        Serial console (No serial console)  --->
          (X) No serial console

It will enable: CONFIG\_NO\_SERIAL\_CONSOLE=y

After flashing the firmware in the board, unplug and plug it in the
computer and it will create a /dev/ttyACM0 device in the Linux. Use
minicom with this device to get access to NuttX NSH console (press Enter
three times to start)

MCP2515 External Module
-----------------------

You can use an external MCP2515 (tested with NiRen MCP2515\_CAN module)
to get CAN Bus working on STM32F103C8 chip (remember the internal CAN
cannot work with USB at same time because they share the SRAM buffer).

You can connect the MCP2515 module in the STM32F103 Minimum board this
way: connect PA5 (SPI1 CLK) to SCK; PA7 (SPI1 MOSI) to SI; PA6 (SPI
MISO) to SO; PA4 to CS; B0 to INT. Also connect 5V to VCC and GND to
GND.

Note: Although MCP2515 can work with 2.7V-5.5V it is more stable when
using it on BluePill board on 5V.

Testing: you will need at least 2 boards each one with a MCP2515 module
connected to it. Connect CAN High from the first module to the CAN High
of the second module, and the CAN Low from the first module to the CAN
Low of the second module.

You need to modify the \"CAN example\" application on menuconfig and
create two firmware versions: the first firmware will be Read-only and
the second one Write-only. Flash the first firmware in the first board
and the second firmware in the second board. Now you can start the both
boards, run the \"can\" command in the Write-only board and then run the
\"can\" command in the Read-only board. You should see the data coming.

STM32F103 Minimum - specific Configuration Options
--------------------------------------------------

Configurations
--------------

### Instantiating Configurations

Each STM32F103 Minimum configuration is maintained in a sub-directory
and can be selected as follow:

    tools/configure.sh STM32F103 Minimum:<subdir>

Where \<subdir\> is one of the following:

### Configuration Directories

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. This
configuration enables a console on UART1. Support for builtin
applications is enabled, but in the base configuration no builtin
applications are selected.

### jlx12864g

This is a config example to use the JLX12864G-086 LCD module. To use
this LCD you need to connect PA5 (SPI1 CLK) to SCK; PA7 (SPI1 MOSI) to
SDA; PA4 to CS; PA3 to RST; PA2 to RS.

### nrf24

This is a config example to test the nrf24 terminal example. You will
need two stm32f103-minimum board each one with a nRF24L01 module
connected this way: connect PB1 to nRF24 CE pin; PA4 to CSN; PA5 (SPI1
CLK) to SCK; PA7 (SPI1 MOSI) to MOSI; PA6 (SPI1 MISO) to MISO; PA0 to
IRQ.

### usbnsh

This is another NSH example. If differs from other \'nsh\'
configurations in that this configurations uses a USB serial device for
console I/O.

NOTES:

1.  This configuration uses the mconf-based configuration tool. To
    change this configuration using that tool, you should:

    > a.  Build and install the kconfig-mconf tool. See nuttx/README.txt
    >     see additional README.txt files in the NuttX tools repository.
    > b.  Execute \'make menuconfig\' in nuttx/ in order to start the
    >     reconfiguration process.

2.  

    By default, this configuration uses the ARM EABI toolchain

    :   for Windows and builds under Cygwin (or probably MSYS). That can
        easily be reconfigured, of course.

        CONFIG\_HOST\_WINDOWS=y : Builds under Windows
        CONFIG\_WINDOWS\_CYGWIN=y : Using Cygwin
        CONFIG\_ARM\_TOOLCHAIN\_GNU\_EABI=y : GNU EABI toolchain for
        Windows

3.  

    This configuration does have UART2 output enabled and set up as

    :   the system logging device:

        CONFIG\_SYSLOG\_CHAR=y : Use a character device for system
        logging CONFIG\_SYSLOG\_DEVPATH=\"/dev/ttyS0\" : UART2 will be
        /dev/ttyS0

        However, there is nothing to generate SYSLOG output in the
        default configuration so nothing should appear on UART2 unless
        you enable some debug output or enable the USB monitor.

4.  Enabling USB monitor SYSLOG output. If tracing is enabled, the USB
    device will save encoded trace output in in-memory buffer; if the
    USB monitor is enabled, that trace buffer will be periodically
    emptied and dumped to the system logging device (UART2 in this
    configuration):

        CONFIG_USBDEV_TRACE=y                   : Enable USB trace feature
        CONFIG_USBDEV_TRACE_NRECORDS=128        : Buffer 128 records in memory
        CONFIG_NSH_USBDEV_TRACE=n               : No builtin tracing from NSH
        CONFIG_NSH_ARCHINIT=y                   : Automatically start the USB monitor
        CONFIG_USBMONITOR=y              : Enable the USB monitor daemon
        CONFIG_USBMONITOR_STACKSIZE=2048 : USB monitor daemon stack size
        CONFIG_USBMONITOR_PRIORITY=50    : USB monitor daemon priority
        CONFIG_USBMONITOR_INTERVAL=2     : Dump trace data every 2 seconds

        CONFIG_USBMONITOR_TRACEINIT=y    : Enable TRACE output
        CONFIG_USBMONITOR_TRACECLASS=y
        CONFIG_USBMONITOR_TRACETRANSFERS=y
        CONFIG_USBMONITOR_TRACECONTROLLER=y
        CONFIG_USBMONITOR_TRACEINTERRUPTS=y

5.  By default, this project assumes that you are *NOT* using the DFU
    bootloader.

### Using the Prolifics PL2303 Emulation

You could also use the non-standard PL2303 serial device instead of the
standard CDC/ACM serial device by changing:

    CONFIG_CDCACM=y               : Disable the CDC/ACM serial device class
    CONFIG_CDCACM_CONSOLE=y       : The CDC/ACM serial device is NOT the console
    CONFIG_PL2303=y               : The Prolifics PL2303 emulation is enabled
    CONFIG_PL2303_CONSOLE=y       : The PL2303 serial device is the console

### veml6070

This is a config example to use the Vishay VEML6070 UV-A sensor. To use
this sensor you need to connect PB6 (I2C1 CLK) to SCL; PB7 (I2C1 SDA) to
SDA of sensor module. I used a GY-VEML6070 module to test this driver.
