CloudController
===============

chip:stm32, chip:stm32f1, chip:stm32f107

This page discusses issues unique to NuttX configurations for the
CloudController development board featuring the STMicro STM32F107VCT
MCU.

Features of the CloudController board include:

-   STM32F107VCT

-   10/100M PHY (DM9161AEP)

-   USB OTG

-   USART connectos (USART1-2)

-   SPI Flash (W25X16)

-   (3) LEDs (LED1-3)

-   (3) Buttons (KEY1-3, USERKEY2, USERKEY, TEMPER, WAKEUP)

-   5V/3.3V power conversion

-   SWD

STM32F107VCT Pin Usage
----------------------

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    **23 PA0  WAKEUP         Connected to KEY4.  Active low: Closing KEY4 pulls WAKEUP to ground.
    24 PA1  MII_RX_CLK
            RMII_REF_CLK
    25 PA2  MII_MDIO
    26 PA3  315M_VT
    29 PA4  DAC_OUT1       To CON5(CN14)
    30 PA5  DAC_OUT2       To CON5(CN14). JP10
            SPI1_SCK       To the SD card, SPI FLASH
    31 PA6  SPI1_MISO      To the SD card, SPI FLASH
    32 PA7  SPI1_MOSI      To the SD card, SPI FLASH
    67 PA8  MCO            To DM9161AEP PHY
    68 PA9  USB_VBUS       MINI-USB-AB. JP3
            USART1_TX      MAX3232 to CN5
    69 PA10 USB_ID         MINI-USB-AB. JP5
            USART1_RX      MAX3232 to CN5
    70 PA11 USB_DM         MINI-USB-AB
    71 PA12 USB_DP         MINI-USB-AB
    72 PA13 TMS/SWDIO
    76 PA14 TCK/SWCLK
    77 PA15 TDI
    == ==== ============== ===================================================================

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    35 PB0  ADC_IN1        To CON5(CN14)
    36 PB1  ADC_IN2        To CON5(CN14)
    37 PB2  DATA_LE        To TFT LCD (CN13)
            BOOT1          JP13
    89 PB3  TDO/SWO
    90 PB4  TRST
    91 PB5  CAN2_RX
    92 PB6  CAN2_TX        JP11
            I2C1_SCL
    93 PB7  I2C1_SDA
    95 PB8  USB_PWR        Drives USB VBUS
    96 PB9  F_CS           To both the TFT LCD (CN13) and to the W25X16 SPI FLASH
    47 PB10 USERKEY        Connected to KEY2
    48 PB11 MII_TX_EN      Ethernet PHY
    51 PB12 I2S_WS         Audio DAC
            MII_TXD0       Ethernet PHY
    52 PB13 I2S_CK         Audio DAC
            MII_TXD1       Ethernet PHY
    53 PB14 SD_CD          There is confusion here.  Schematic is wrong LCD_WR is PB14.
    54 PB15 I2S_DIN        Audio DAC
    == ==== ============== ===================================================================

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    15 PC0  POTENTIO_METER
    16 PC1  MII_MDC        Ethernet PHY
    17 PC2  WIRELESS_INT
    18 PC3  WIRELESS_CE    To the NRF24L01 2.4G wireless module
    33 PC4  USERKEY2       Connected to KEY1
    34 PC5  TP_INT         JP6.  To TFT LCD (CN13) module
            MII_INT        Ethernet PHY
    63 PC6  I2S_MCK        Audio DAC. Active low: Pulled high
    64 PC7  PCM1770_CS     Audio DAC. Active low: Pulled high
    65 PC8  LCD_CS         TFT LCD (CN13). Active low: Pulled high
    66 PC9  TP_CS          TFT LCD (CN13). Active low: Pulled high
    78 PC10 SPI3_SCK       To TFT LCD (CN13), the NRF24L01 2.4G wireless module
    79 PC11 SPI3_MISO      To TFT LCD (CN13), the NRF24L01 2.4G wireless module
    80 PC12 SPI3_MOSI      To TFT LCD (CN13), the NRF24L01 2.4G wireless module
    7  PC13 TAMPER         Connected to KEY3
    8  PC14 OSC32_IN       Y1 32.768Khz XTAL
    9  PC15 OSC32_OUT      Y1 32.768Khz XTAL
    == ==== ============== ===================================================================

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    81 PD0  CAN1_RX
    82 PD1  CAN1_TX
    83 PD2  LED1           Active low: Pulled high
    84 PD3  LED2           Active low: Pulled high
    85 PD4  LED3           Active low: Pulled high
    86 PD5  485_TX         Same as USART2_TX but goes to SP3485
            USART2_TX      MAX3232 to CN6
    87 PD6  485_RX         Save as USART2_RX but goes to SP3485 (see JP4)
            USART2_RX      MAX3232 to CN6
    88 PD7  LED4           Active low: Pulled high
            485_DIR        SP3485 read enable (not)
    55 PD8  MII_RX_DV      Ethernet PHY
            RMII_CRSDV     Ethernet PHY
    56 PD9  MII_RXD0       Ethernet PHY
    57 PD10 MII_RXD1       Ethernet PHY
    58 PD11 SD_CS          Active low: Pulled high (See also TFT LCD CN13, pin 32)
    59 PD12 WIRELESS_CS    To the NRF24L01 2.4G wireless module
    60 PD13 LCD_RS         To TFT LCD (CN13)
    61 PD14 LCD_WR         To TFT LCD (CN13). Schematic is wrong LCD_WR is PB14.
    62 PD15 LCD_RD         To TFT LCD (CN13)
    == ==== ============== ===================================================================

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    97 PE0  DB00           To TFT LCD (CN13)
    98 PE1  DB01           To TFT LCD (CN13)
    1  PE2  DB02           To TFT LCD (CN13)
    2  PE3  DB03           To TFT LCD (CN13)
    3  PE4  DB04           To TFT LCD (CN13)
    4  PE5  DB05           To TFT LCD (CN13)
    5  PE6  DB06           To TFT LCD (CN13)
    38 PE7  DB07           To TFT LCD (CN13)
    39 PE8  DB08           To TFT LCD (CN13)
    40 PE9  DB09           To TFT LCD (CN13)
    41 PE10 DB10           To TFT LCD (CN13)
    42 PE11 DB11           To TFT LCD (CN13)
    43 PE12 DB12           To TFT LCD (CN13)
    44 PE13 DB13           To TFT LCD (CN13)
    45 PE14 DB14           To TFT LCD (CN13)
    46 PE15 DB15           To TFT LCD (CN13)
    == ==== ============== ===================================================================

    == ==== ============== ===================================================================
    PN NAME SIGNAL         NOTES
    == ==== ============== ===================================================================
    73 N/C

    12 OSC_IN              Y2 25Mhz XTAL
    13 OSC_OUT             Y2 25Mhz XTAL

    94 BOOT0               JP15 (3.3V or GND)
    14 RESET               S5
    6  VBAT                JP14 (3.3V or battery)

    49 VSS_1               GND
    74 VSS_2               GND
    99 VSS_3               GND
    27 VSS_4               GND
    10 VSS_5               GND
    19 VSSA                VSSA
    20 VREF-               VREF-
    == ==== ============== ===================================================================

LEDs
----

> The Cloudctrl board has four LEDs labeled LED1, LED2, LED3 and LED4 on
> the board. These LEDs are not used by the board port unless
> CONFIG\_ARCH\_LEDS is defined. In that case, the usage by the board
> port is defined in include/board.h and src/up\_leds.c. The LEDs are
> used to encode OS-related events as follows:
>
> >   SYMBOL                 Meaning                                         LED1\[1\]   LED2   LED3   LED4\[4\]
> >   ---------------------- ----------------------------------------------- ----------- ------ ------ -----------
> >   LED\_STARTED           NuttX has been started                          ON          OFF    OFF    OFF
> >   LED\_HEAPALLOCATE      Heap has been allocated                         OFF         ON     OFF    OFF
> >   LED\_IRQSENABLED       Interrupts enabled                              ON          ON     OFF    OFF
> >   LED\_STACKCREATED      Idle stack created                              OFF         OFF    ON     OFF
> >   LED\_INIRQ             In an interrupt\[2\]                            ON          N/C    N/C    OFF
> >   LED\_SIGNAL            In a signal handler\[3\]                        N/C         ON     N/C    OFF
> >   LED\_ASSERTION         An assertion failed                             ON          ON     N/C    OFF
> >   LED\_PANIC LED\_IDLE   The system has crashed STM32 is is sleep mode   N/C         N/C    N/C    ON
> >
> > \[1\] If LED1, LED2, LED3 are statically on, then NuttX probably
> > failed to boot and these LEDs will give you some indication of where
> > the failure was \[2\] The normal state is LED1 ON and LED1 faintly
> > glowing. This faint glow is because of timer interrupts that result
> > in the LED being illuminated on a small proportion of the time.
> > \[3\] LED2 may also flicker normally if signals are processed. \[4\]
> > LED4 may not be available if RS-485 is also used. For RS-485, it
> > will then indicate the RS-485 direction.

Cloudctrl-specific Configuration Options
----------------------------------------

Configurations
--------------

Each Cloudctrl configuration is maintained in a sub-directory and can be
selected as follow:

    tools/configure.sh shenzhou:<subdir>

Where \<subdir\> is one of the following:

### nsh

Configures the NuttShell (nsh) located at apps/examples/nsh. The
Configuration enables both the serial and telnet NSH interfaces.:

    CONFIG_ARM_TOOLCHAIN_GNU_EABI=y        : GNU EABI toolchain for Windows
    CONFIG_NSH_DHCPC=n                        : DHCP is disabled
    CONFIG_NSH_IPADDR=0x0a000002              : Target IP address 10.0.0.2
    CONFIG_NSH_DRIPADDR=0x0a000001            : Host IP address 10.0.0.1

    NOTES:
    1. This example assumes that a network is connected.  During its
       initialization, it will try to negotiate the link speed.  If you have
       no network connected when you reset the board, there will be a long
       delay (maybe 30 seconds?) before anything happens.  That is the timeout
       before the networking finally gives up and decides that no network is
       available.

    2. Enabling the ADC example:

       The only internal signal for ADC testing is the potentiometer input:

         ADC1_IN10(PC0) Potentiometer

       External signals are also available on CON5 CN14:

         ADC_IN8 (PB0) CON5 CN14 Pin2
         ADC_IN9 (PB1) CON5 CN14 Pin1

       The signal selection is hard-coded in boards/shenzhou/src/up_adc.c:  The
       potentiometer input (only) is selected.

       These selections will enable sampling the potentiometer input at 100Hz using
       Timer 1:

         CONFIG_ANALOG=y                        : Enable analog device support
         CONFIG_ADC=y                           : Enable generic ADC driver support
         CONFIG_ADC_DMA=n                       : ADC DMA is not supported
         CONFIG_STM32_ADC1=y                    : Enable ADC 1
         CONFIG_STM32_TIM1=y                    : Enable Timer 1
         CONFIG_STM32_TIM1_ADC=y                : Use Timer 1 for ADC
         CONFIG_STM32_TIM1_ADC1=y               : Allocate Timer 1 to ADC 1
         CONFIG_STM32_ADC1_SAMPLE_FREQUENCY=100 : Set sampling frequency to 100Hz
         CONFIG_STM32_ADC1_TIMTRIG=0            : Trigger on timer output 0
         CONFIG_STM32_FORCEPOWER=y              : Apply power to TIM1 a boot up time
         CONFIG_EXAMPLES_ADC=y                  : Enable the apps/examples/adc built-in

### nxwm

This is a special configuration setup for the NxWM window manager
UnitTest. The NxWM window manager can be found here:

    apps/graphics/NxWidgets/nxwm

The NxWM unit test can be found at:

    apps/graphics/NxWidgets/UnitTests/nxwm

NOTE: JP6 selects between the touchscreen interrupt and the MII
interrupt. It should be positioned 1-2 to enable the touchscreen
interrupt.

NOTE: Reading from the LCD is not currently supported by this
configuration. The hardware will support reading from the LCD and
drivers/lcd/ssd1289.c also supports reading from the LCD. This limits
some graphics capabilities.

Reading from the LCD is not supported only because it has not been test.
If you get inspired to test this feature, you can turn the LCD read
functionality on by setting:

    -CONFIG_LCD_NOGETRUN=y
    +# CONFIG_LCD_NOGETRUN is not set

    -CONFIG_NX_WRITEONLY=y
    +# CONFIG_NX_WRITEONLY is not set

### thttpd

This builds the THTTPD web server example using the THTTPD and the
apps/examples/thttpd application.

NOTE: This example can only be built using older GCC toolchains due to
incompatibilities introduced in later GCC releases.
