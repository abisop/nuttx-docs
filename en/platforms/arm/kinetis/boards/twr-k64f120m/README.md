README.txt
==========

This is the README file for the port of NuttX to the Freescale Kinetis
TWR-K64F120M. Refer to the Freescale web site for further information
about this part:

www.nxp.com/products/sensors/accelerometers/3-axis-accelerometers/kinetis-k64-mcu-tower-system-module:TWR-K64F120M

The board may be complemented by TWR-SER which includes (among other
things), an RS232 and Ethernet connections:

http://www.nxp.com/pages/serial-usb-ethernet-can-rs232-485-tower-system-module:TWR-SER

Contents
========

o Kinetis TWR-K64F120M Features o Kinetis TWR-K64F120M Pin Configuration
- On-Board Connections - Connections via the General Purpose Tower
Plug-in (TWRPI) Socket - Connections via the Tower Primary Connector
Side A - Connections via the Tower Primary Connector Side B - TWR-SER
Serial Board Connection o LEDs o TWR-K64F120M-specific Configuration
Options o Configurations

Kinetis TWR-K64F120M Features:
==============================

o K64N1M in 144 MAPBGA, MK64FN1M0VMD12 o Integrated, Open-SDA serial,
flash and debug through USB o SD Card Slot o MMA7660 3-axis
accelerometer o Tower Plug-In (TWRPI) Socket for expansion (sensors,
etc.) o Touch TWRPI Socket adds support for various capacitive touch
boards (e.g. keypads, rotary dials, sliders, etc.) o Tower connectivity
for access to USB, Ethernet, RS232/RS485, CAN, SPI, I²C, Flexbus, etc. o
Plus: Potentiometer, 4 LEDs, 2 pushbuttons, accelerometer, RTC battery

Kinetis TWR-K64F120M Pin Configuration
======================================

  On-Board Connections                           
  ---------------------- ------------ ---------- --------------
  FEATURE                CONNECTION   PORT/PIN   PIN FUNCTION

OSJTAG USB-to-serial OSJTAG Bridge RX Data PTC3 UART1\_RX Bridge OSJTAG
Bridge TX Data PTC4 UART1\_TX SD Card Slot SD Clock PTE2 SDHC0\_DCLK SD
Command PTE3 SDHC0\_CMD SD Data0 PTE1 SDHC0\_D0 SD Data1 PTE0 SDHC0\_D1
SD Data2 PTE5 SDHC0\_D2 SD Data3 PTE4 SDHC0\_D3 SD Card Detect PTB20
PTB20 SD Write Protect PTB21 PTB21 Micro-USB K64\_MICRO\_USB\_DN
USB0\_DN K64\_MICRO\_USB\_DP USB0\_DP K64\_USB\_ID\_J PTE12
K64\_USB\_FLGA PTC8 K64\_USB\_ENABLE PTC9 Pushbuttons SW1 (LLWU\_P10)
PTC6 PTC6 SW2 (RSTIN\_B\_R) RSTIN RESET SW3 (NMI B) PTA4 PTA4 LEDs D5 /
Green LED PTE6 PTE6 D6 / Yellow LED PTE7 PTE7 D7 / Orange LED PTE8 PTE8
D9 / Blue LED PTE9 PTE9 Potentiometer Potentiometer (R526) ? ADC1\_SE18
Accelerometer I2C SDA PTC11 I2C1\_SDA I2C SCL PTC10 I2C1\_SCL INT1 PTA6
PTA6 INT2 PTA8 PTA8

SDHC important notice: on TWR-K64F120M, R521 (close to the SD card
holder) is not placed, hence WRPROTEC is always ON. Either place a
4.7KOhm resistor or change PIN config to PULLDOWN, losing Write Protect
function. See twrk64.h.

  Connections via the G   eneral Purpose Tower Plug-   in (TWRPI   ) Socket
  ----------------------- ---------------------------- ----------- --------------
  FEATURE                 CONNECTION                   PORT/PIN    PIN FUNCTION

General Purpose TWRPI ADC0 (J4 Pin 8) ? ADC1\_SE16/ADC0\_SE22 TWRPI
Socket TWRPI\_ADC1 (J4 Pin 9) ? ADC0\_SE16/ADC0\_SE21 TWRPI\_ADC2 (J4
Pin 12) ? ADC1\_DP0/ADC0\_DP3 TWRPI\_ID0 (J4 Pin 17) ?
ADC0\_DP0/AD1\_DP3 TWRPI\_ID1 (J4 Pin 18) ? ADC0\_DM0/ADC1\_DM3 TWRPI
I2C SCL (J3 Pin 3) PTC10 I2C1\_SCL TWRPI I2C SDA (J3 Pin 4) PTC11
I2C1\_SDA SPI1\_SOUT (J3 Pin 10) PTB16 ? SPI1\_PCS0 (J3 Pin 11) PTB10
PTB10 SPI1\_SCK (J3 Pin 12) PTB11 ? TWRPI\_GPIO0 (J3 Pin 15) PTB3 PTB3
TWRPI GPIO1 (J3 Pin 16) PTC0 PTC0 TWRPI GPIO2 (J3 Pin 17) PTC16 PTC16
TWRPI GPIO3 (J3 Pin 18) PTC17 PTC17 TWRPI GPIO4 (J3 Pin 19) PTC18 PTC18
TWRPI GPIO5 (J3 Pin 20) PTC19 PTC19

The TWR-K64F120M features two expansion card-edge connectors that
interface to the Primary and Secondary Elevator boards in a Tower
system. The Primary Connector (comprised of sides A and B) is identified
by a white strip. The Secondary Connector is comprised of sides C and D.

TWR-SER Serial Board Connection
===============================

The serial board connects into the tower and then maps to the tower pins
to yet other functions (see TWR-SER-SCH.pdf).

In particular it features an Ethernet port.

Networking Support
==================

U2 is a 25 MHz oscillator (which may be disabled by setting J4), which
clock is sent to U1. U1 has two clock output banks: 25MHz (CLKBx) and
50MHz (CLKAx). J2 (set board) is used to select the PHY clock source:
50MHz, 25MHz or CLCKOUT0 from K64. Set it to 25MHz. In order to keep
synchornized the PHY clock with the K64 clock, one can set J3 (default
is open) to route CLOCKIN0 either from 25MHz or 50Mhz lines. In that
case, J33 (main board) will have to be removed and J32 (main board set)
set to disable its 50MHz\_OSC and use CLKIN0 provided by set board. J12
is by default set to RMII mode. In this case J2 should be placed to
50MHz clock Note that in MII mode, MII0\_TXER is required by kinetis
driver, but not connected on set board

Ethernet MAC/KSZ8041NL PHY -------------------------- ------------
----------------------------------------------------------
------------------------------ ------------------------------- KSZ8041
TWR Board Signal(s) K64F Pin Pin name Pin Signal Function MII RMII ---
-------- ----------------------------------------------------------
------------------------------ ------------------------------- 9 REFCLK
CLK\_SEL J2: CLOCKOUT0/25MHz/50MHz, PHY clock input PTC3/CLKOUT ---
direct to PHY 11 MDIO FEC\_MDIO PTB0/RMII0\_MDIO/MII0\_MDIO
PIN\_MII0\_MDIO PIN\_RMII0\_MDIO 12 MDC FEC\_MDC
PTB1/RMII0\_MDC/MII0\_MDC PIN\_MII0\_MDC PIN\_RMII0\_MDC 13 PHYAD0
FEC\_RXD3 J12: PHY Address select (pull-down if set) PTA9/MII0\_RXD3
PIN\_RMII0\_RXD3 --- 14 PHYAD1 FEC\_RXD2 J12: PHY Address select
(pull-up if set) PTA10/MII0\_RXD2 PIN\_RMII0\_RXD2 --- 15 PHYAD2
FEC\_RXD1 J12: PHY Address select (pull-up if set)
PTA12/RMII0\_RXD1/MII0\_RXD1 PIN\_MII0\_RXD1 PIN\_RMII0\_RXD1 16 DUPLEX
FEC\_RXD0 J12: Half-duplex (pull-down if set)
PTA13/RMII0\_RXD0/MII0\_RXD0 PIN\_MII0\_RXD0 PIN\_RMII0\_RXD0 18 CONFIG2
FEC\_RXDV J12: Loopback select (pull-up if set)
PTA14/RMII0\_CRS\_DV/MII0\_RXDV PIN\_MII0\_RXDV PIN\_RMII0\_CRS\_DV 19
RXC FEC\_RXCLK PTA11/MII0\_RXCLK PIN\_MII0\_RXCLK --- 20 ISO FEC\_RXER
J12: Isolation mode select (pull-up if set) PTA5/RMII0\_RXER/MII0\_RXER
PIN\_MII\_RXER PIN\_RMII\_RXER 22 TXC FEC\_TXCLK PTA25/MII0\_TXCLK
PIN\_MII0\_TXCLK --- 23 TXEN FEC\_TXEN PTA15/RMII0\_TXEN/MII0\_TXEN
PIN\_MII0\_TXEN PIN\_RMII0\_TXEN 24 TXD0 FEC\_TXD0
PTA16/RMII0\_TXD0/MII0\_TXD0 PIN\_MII0\_TXD0 PIN\_RMII0\_TXD0 25 TXD1
FEC\_TXD1 PTA17/RMII0\_TXD1/MII0\_TXD1 PIN\_MII0\_TXD1 PIN\_RMII0\_TXD1
26 TXD2 FEC\_TXD2 PTA24/MII0\_TXD2 PIN\_MII0\_TXD2 --- 27 TXD3 FEC\_TXD3
PTA26/MII0\_TXD3 PIN\_MII0\_TXD3 --- 28 CONFIG0 FEC\_COL J12: RMII
select (pull-up if set) PTA29/MII0\_COL PIN\_MII0\_COL --- 29 CONFIG1
FEC\_CRS PTA27/MII0\_CRS PIN\_MII0\_CRS --- 30 LED0 LED0/NWAYEN J12:
Disable auto\_negotiation (pull-down if s --- --- 31 LED1 LED1/SPEED
J12: 10Mbps select (pull-down if set) --- --- --- --------
----------------- ----------------------------------------
------------------------------ -------------------------------

Networking support can be added to NSH by selecting the following
configuration options.

Selecting the MAC peripheral ----------------------------

System Type -\> Kinetis Peripheral Support CONFIG\_KINETIS\_ENET=y :
Enable the Ethernet MAC peripheral

System Type -\> Ethernet Configuration CONFIG\_KINETIS\_ENETNETHIFS=1
CONFIG\_KINETIS\_ENETNRXBUFFERS=6 CONFIG\_KINETIS\_ENETNTXBUFFERS=2
CONFIG\_KINETIS\_ENET\_MDIOPULLUP=y

Networking Support CONFIG\_NET=y : Enable Neworking
CONFIG\_NET\_ETHERNET=y : Support Ethernet data link
CONFIG\_NET\_SOCKOPTS=y : Enable socket operations
CONFIG\_NET\_ETH\_PKTSIZE=590 : Maximum packet size 1518 is more
standard CONFIG\_NET\_ARP=y : Enable ARP CONFIG\_NET\_ARPTAB\_SIZE=16 :
ARP table size CONFIG\_NET\_ARP\_IPIN=y : Enable ARP address harvesting
CONFIG\_NET\_ARP\_SEND=y : Send ARP request before sending data
CONFIG\_NET\_TCP=y : Enable TCP/IP networking
CONFIG\_NET\_TCP\_WRITE\_BUFFERS=y : Support TCP write-buffering
CONFIG\_NET\_TCPBACKLOG=y : Support TCP/IP backlog
CONFIG\_NET\_MAX\_LISTENPORTS=20 : CONFIG\_NET\_UDP=y : Enable UDP
networking CONFIG\_NET\_BROADCAST=y : Needed for DNS name resolution
CONFIG\_NET\_ICMP=y : Enable ICMP networking CONFIG\_NET\_ICMP\_SOCKET=y
: Needed for NSH ping command : Defaults should be okay for other
options Application Configuration -\> Network Utilities
CONFIG\_NETDB\_DNSCLIENT=y : Enable host address resolution
CONFIG\_NETUTILS\_TELNETD=y : Enable the Telnet daemon
CONFIG\_NETUTILS\_TFTPC=y : Enable TFTP data file transfers for get and
put commands CONFIG\_NETUTILS\_NETLIB=y : Network library support is
needed CONFIG\_NETUTILS\_WEBCLIENT=y : Needed for wget support :
Defaults should be okay for other options Application Configuration -\>
NSH Library CONFIG\_NSH\_TELNET=y : Enable NSH session via Telnet
CONFIG\_NSH\_IPADDR=0xc0a800e9 : Select a fixed IP address
CONFIG\_NSH\_DRIPADDR=0xc0a800fe : IP address of gateway/host PC
CONFIG\_NSH\_NETMASK=0xffffff00 : Netmask CONFIG\_NSH\_NOMAC=y : Need to
make up a bogus MAC address : Defaults should be okay for other options

You can also enable enable the DHCPC client for networks that use
dynamically assigned address:

Application Configuration -\> Network Utilities
CONFIG\_NETUTILS\_DHCPC=y : Enables the DHCP client

Networking Support CONFIG\_NET\_UDP=y : Depends on broadcast UDP

Application Configuration -\> NSH Library CONFIG\_NET\_BROADCAST=y
CONFIG\_NSH\_DHCPC=y : Tells NSH to use DHCPC, not : the fixed addresses

Using the network with NSH --------------------------

So what can you do with this networking support? First you see that NSH
has several new network related commands:

    ifconfig, ifdown, ifup:  Commands to help manage your network
    get and put:             TFTP file transfers
    wget:                    HTML file transfers
    ping:                    Check for access to peers on the network
    Telnet console:          You can access the NSH remotely via telnet.

You can also enable other add on features like full FTP or a Web Server
or XML RPC and others. There are also other features that you can enable
like DHCP client (or server) or network name resolution.

By default, the IP address of the DK-TM4C129X will be 192.168.0.233 and
it will assume that your host is the gateway and has the IP address
192.168.0.254.

    nsh> ifconfig
    eth0    Link encap:Ethernet HWaddr 16:03:60:0f:00:33 at UP
        inet addr:192.168.0.233 DRaddr:192.168.0.254 Mask:255.255.255.

You can use ping to test for connectivity to the host (Careful, Window
firewalls usually block ping-related ICMP traffic).

On the host PC side, you may be able to ping the TWR-K64F120M:

    $ ping 192.168.0.233
    PING 192.168.0.233 (192.168.0.233) 56(84) bytes of data.
    64 bytes from 192.168.0.233: icmp_seq=1 ttl=64 time=7.82 ms
    64 bytes from 192.168.0.233: icmp_seq=2 ttl=64 time=4.50 ms
    64 bytes from 192.168.0.233: icmp_seq=3 ttl=64 time=2.04 ms
    ^C
    --- 192.168.0.233 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2003ms
    rtt min/avg/max/mdev = 2.040/4.789/7.822/2.369 ms

From the target side, you may should also be able to ping the host
(assuming it's IP is 192.168.0.1):

    nsh> ping 192.168.0.1
    PING 192.168.0.1 56 bytes of data
    56 bytes from 192.168.0.1: icmp_seq=1 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=2 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=3 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=4 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=5 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=6 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=7 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=8 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=9 time=0 ms
    56 bytes from 192.168.0.1: icmp_seq=10 time=0 ms
    10 packets transmitted, 10 received, 0% packet loss, time 10100 ms
    nsh>

You can also log into the NSH from the host PC like this:

    $ telnet 192.168.0.233
    Trying 192.168.0.233...
    Connected to 192.168.0.233.
    Escape character is '^]'.

    NuttShell (NSH)
    nsh>

NOTE: If you enable this networking as described above, you will
experience a delay on booting NSH. That is because the start-up logic
waits for the network connection to be established before starting
NuttX. In a real application, you would probably want to do the network
bringup on a separate thread so that access to the NSH prompt is not
delayed.

The kinetis\_enet.c driver, does not wait too long for PHY to negotiate
the link speed. In this case it folds back to 10Mbs half-duplex mode.
This behaviour should be improved in order to cope with the plug and
play nature of this port.

Reconfiguring after the network becomes available requires the network
monitor feature, also discussed below.

  Network Initialization Thread
  -------------------------------------------------------------------------
  \[not tested on K64F120M\]
  There is a configuration option enabled by CONFIG\_NSH\_NETINIT\_THREAD
  that will do the NSH network bring-up asynchronously in parallel on
  a separate thread. This eliminates the (visible) networking delay
  altogether. This current implementation, however, has some limitations:

    - If no network is connected, the network bring-up will fail and
      the network initialization thread will simply exit.  There are no
      retries and no mechanism to know if the network initialization was
      successful (it could perform a network Ioctl to see if the link is
      up and it now, keep trying, but it does not do that now).

    - Furthermore, there is currently no support for detecting loss of
      network connection and recovery of the connection (similarly, this
      thread could poll periodically for network status, but does not).

Both of these shortcomings could be eliminated by enabling the network
monitor:

  Network Monitor
  ------------------------------------------------------------------------
  By default the network initialization thread will bring-up the network
  then exit, freeing all of the resources that it required. This is a
  good behavior for systems with limited memory.

If the CONFIG\_NSH\_NETINIT\_MONITOR option is selected, however, then
the network initialization thread will persist forever; it will monitor
the network status. In the event that the network goes down (for
example, if a cable is removed), then the thread will monitor the link
status and attempt to bring the network back up. In this case the
resources required for network initialization are never released.

Pre-requisites:

    - CONFIG_NSH_NETINIT_THREAD as described above.

    - The K64F EMAC block does not support PHY interrupts.  The KSZ8081
      PHY interrupt line is brought to a jumper block and it should be
      possible to connect that some some interrupt port pin.  You would
      need to provide some custom logic in the Freedcom K64F
      configuration to set up that PHY interrupt.

    - In addition to the PHY interrupt, the Network Monitor also requires the
      following setting:

        CONFIG_NETDEV_PHY_IOCTL. Enable PHY IOCTL commands in the Ethernet
        device driver. Special IOCTL commands must be provided by the Ethernet
        driver to support certain PHY operations that will be needed for link
        management. There operations are not complex and are implemented for
        the Atmel SAMA5 family.

        CONFIG_ARCH_PHY_INTERRUPT. This is not a user selectable option.
        Rather, it is set when you select a board that supports PHY
        interrupts.  For the K64F, like most other architectures, the PHY
        interrupt must be provided via some board-specific GPIO.  In any
        event, the board-specific logic must provide support for the PHY
        interrupt. To do this, the board logic must do two things: (1) It
        must provide the function arch_phy_irq() as described and prototyped
        in the nuttx/include/nuttx/arch.h, and (2) it must select
        CONFIG_ARCH_PHY_INTERRUPT in the board configuration file to
        advertise that it supports arch_phy_irq().

        One other thing: UDP support is required (CONFIG_NET_UDP).

Given those prerequisites, the network monitor can be selected with
these additional settings.

    System Type -> Kinetis Ethernet Configuration
      CONFIG_ARCH_PHY_INTERRUPT=y           : (auto-selected)
      CONFIG_NETDEV_PHY_IOCTL=y             : (auto-selected)

    Application Configuration -> NSH Library -> Networking Configuration
      CONFIG_NSH_NETINIT_THREAD             : Enable the network initialization thread
      CONFIG_NSH_NETINIT_MONITOR=y          : Enable the network monitor
      CONFIG_NSH_NETINIT_RETRYMSEC=2000     : Configure the network monitor as you like

LEDs
====

The TWR-K64F120M board has four LEDs labeled D5, D6, D7, D9 on the
board. Usage of these LEDs is defined in include/board.h and
src/up\_leds.c. They are encoded as follows:

    SYMBOL                Meaning                  LED1*    LED2    LED3    LED4
    -------------------   -----------------------  -------  ------- ------- ------
    LED_STARTED           NuttX has been started   OFF      OFF     OFF     N/A
    LED_HEAPALLOCATE      Heap has been allocated  OFF      OFF     OFF     N/A
    LED_IRQSENABLED       Interrupts enabled       OFF      OFF     OFF     N/A
    LED_STACKCREATED      Idle stack created       ON       OFF     OFF     N/A
    LED_INIRQ             In an interrupt**        N/C      ON      N/C     N/A
    LED_SIGNAL            In a signal handler***   N/C      N/C     ON      N/A
    LED_ASSERTION         An assertion failed      ON       ON      ON      N/A
    LED_PANIC             The system has crashed   Blink    N/C     N/C    N/A
    LED_IDLE              K64 is is sleep mode   (Optional, not used)

-   If LED1, LED2, LED3 are statically on, then NuttX probably failed to
    boot and these LEDs will give you some indication of where the
    failure was \*\* The normal state is LED1 ON and LED2 faintly
    glowing. This faint glow is because of timer interrupts and signal
    that result in the LED being illuminated on a small proportion of
    the time. \*\*\* LED3 may even glow faintlier then LED2 while
    signals are processed.

TWR-K64F120M-specific Configuration Options
===========================================

    CONFIG_ARCH - Identifies the arch/ subdirectory.  This should
       be set to:

       CONFIG_ARCH=arm

    CONFIG_ARCH_family - For use in C code:

       CONFIG_ARCH_ARM=y

    CONFIG_ARCH_architecture - For use in C code:

       CONFIG_ARCH_CORTEXM4=y

    CONFIG_ARCH_CHIP - Identifies the arch/*/chip subdirectory

       CONFIG_ARCH_CHIP=kinetis

    CONFIG_ARCH_CHIP_name - For use in C code to identify the exact
       chip:

       CONFIG_ARCH_CHIP_MK64FN1M0VMD12=y

    CONFIG_ARCH_BOARD - Identifies the boards/ subdirectory and
       hence, the board that supports the particular chip or SoC.

       CONFIG_ARCH_BOARD=twr-k64f120m (for the TWR-K64F120M development board)

    CONFIG_ARCH_BOARD_name - For use in C code

       CONFIG_ARCH_BOARD_TWR_K64F120M=y

    CONFIG_ENDIAN_BIG - define if big endian (default is little
       endian)

    CONFIG_RAM_SIZE - Describes the installed DRAM (SRAM in this case):

       CONFIG_RAM_SIZE=262144 (256Kb)

    CONFIG_RAM_START - The start address of installed DRAM

       CONFIG_RAM_START=0x1fff0000

    CONFIG_ARCH_LEDS - Use LEDs to show state. Unique to boards that
       have LEDs

       CONFIG_ARCH_LEDS=y

    CONFIG_ARCH_INTERRUPTSTACK - This architecture supports an interrupt
       stack. If defined, this symbol is the size of the interrupt
        stack in bytes.  If not defined, the user task stacks will be
      used during interrupt handling.

    CONFIG_ARCH_STACKDUMP - Do stack dumps after assertions

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

Kinetis specific device driver settings

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

Each TWR-K64F120M configuration is maintained in a sub-directory and can
be selected as follow:

    tools/configure.sh twr-k64f120m:<subdir>

Where `<subdir>`{=html} is one of the following:

  nsh:
  ------------------------------------------------------------------
  Configures the NuttShell (nsh) located at apps/examples/nsh. The
  Configuration enables only the serial interface.
  The serial console is on OpenSDA serial bridge. For access,
  use \$ miniterm.py -f direct /dev/ttyACM0 115200 from Linux PC
  Support for the board's SDHC MicroSD card is included.

    NOTES:

    1. The SDHC driver is under work and currently support IRQ mode (no DMA):

      CONFIG_KINETIS_SDHC=y                : Enable the SDHC driver

      CONFIG_MMCSD=y                       : Enable MMC/SD support
      CONFIG_MMCSD_SDIO=y                  : Use the SDIO-based MMC/SD driver
      CONFIG_MMCSD_NSLOTS=1                : One MMC/SD slot

      CONFIG_FAT=y                         : Eable FAT file system
      CONFIG_FAT_LCNAMES=n                 : FAT lower case name support
      CONFIG_FAT_LFN=y                     : FAT long file name support
      CONFIG_FAT_MAXFNAME=32               : Maximum length of a long file name

      CONFIG_KINETIS_GPIOIRQ=y             : Enable GPIO interrupts
      CONFIG_KINETIS_PORTEINTS=y           : Enable PortE GPIO interrupts

      CONFIG_SCHED_WORKQUEUE=y             : Enable the NuttX workqueue

      CONFIG_NSH_ARCHINIT=y                : Provide NSH initialization logic

  netnsh:
  -------------------------------------------------------------------------
  This is the same config then nsh, but it adds Ethernet support with the
  TWR-SER card. It includes telnetd in order to access nsh from Ethernet.
  IP address defaults to 192.168.0.233/24.

    NOTES:

    1. See networking support for application and especially for jumper setting.
       In this config, this is TWR-SER that clocks the MCU.

    2. The PHY link negotiation is done at boot time only. If no link is then
       available, a fallback mode is used at 10Mbs/half-duplex. Please make sure
       your ethernet cable and switches are on before booting.
