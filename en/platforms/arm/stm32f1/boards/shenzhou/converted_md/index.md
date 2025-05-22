Shenzhou IV
===========

::: {.tags}
chip:stm32, chip:stm32f1, chip:stm32f107
:::

This page discusses issues unique to NuttX configurations for the
Shenzhou IV development board from www.armjishu.com featuring the
STMicro STM32F107VCT MCU. As of this writing, there are five models of
the Shenzhou board:

1.  Shenzhou I (STM32F103RB)
2.  Shenzhou II (STM32F103VC)
3.  Shenzhou III (STM32F103ZE)
4.  Shenzhou IV (STM32F107VC)
5.  Shenzhou king ((STM32F103ZG, core board + IO expansion board)).

Support is currently provided for the Shenzhou IV only. Features of the
Shenzhou IV board include:

-   STM32F107VCT

-   10/100M PHY (DM9161AEP)

-   TFT LCD Connector

-   USB OTG

-   CAN (CAN1=2)

-   USART connectos (USART1-2)

-   RS-485

-   SD card slot

-   Audio DAC (PCM1770)

-   SPI Flash (W25X16)

-   (4) LEDs (LED1-4)

-   2.4G Wireless (NRF24L01 SPI module)

-   315MHz Wireless (module)

-   (4) Buttons (KEY1-4, USERKEY2, USERKEY, TEMPER, WAKEUP)

-   VBUS/external +4V select

-   5V/3.3V power conversion

-   Extension connector

-   JTAG

STM32F107VCT Pin Usage
----------------------

LEDs
----

The Shenzhou board has four LEDs labeled LED1, LED2, LED3 and LED4 on
the board. These LEDs are not used by the board port unless
CONFIG\_ARCH\_LEDS is defined. In that case, the usage by the board port
is defined in include/board.h and src/up\_leds.c. The LEDs are used to
encode OS-related events as follows:

    SYMBOL               Meaning                 LED1*   LED2    LED3    LED4****
    -------------------  ----------------------- ------- ------- ------- ------
    LED_STARTED          NuttX has been started  ON      OFF     OFF     OFF
    LED_HEAPALLOCATE     Heap has been allocated OFF     ON      OFF     OFF
    LED_IRQSENABLED      Interrupts enabled      ON      ON      OFF     OFF
    LED_STACKCREATED     Idle stack created      OFF     OFF     ON      OFF
    LED_INIRQ            In an interrupt**       ON      N/C     N/C     OFF
    LED_SIGNAL           In a signal handler***  N/C     ON      N/C     OFF
    LED_ASSERTION        An assertion failed     ON      ON      N/C     OFF
    LED_PANIC            The system has crashed  N/C     N/C     N/C     ON
    LED_IDLE             STM32 is is sleep mode  (Optional, not used)

    * If LED1, LED2, LED3 are statically on, then NuttX probably failed to boot
    and these LEDs will give you some indication of where the failure was
    ** The normal state is LED1 ON and LED1 faintly glowing.  This faint glow
    is because of timer interrupts that result in the LED being illuminated
    on a small proportion of the time.
    *** LED2 may also flicker normally if signals are processed.
    **** LED4 may not be available if RS-485 is also used. For RS-485, it will
    then indicate the RS-485 direction.

Shenzhou-specific Configuration Options
---------------------------------------

Configurations
--------------

Each Shenzhou configuration is maintained in a sub-directory and can be
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

1.  This example assumes that a network is connected. During its
    initialization, it will try to negotiate the link speed. If you have
    no network connected when you reset the board, there will be a long
    delay (maybe 30 seconds?) before anything happens. That is the
    timeout before the networking finally gives up and decides that no
    network is available.

2.  Enabling the ADC example:

    The only internal signal for ADC testing is the potentiometer input:

        ADC1_IN10(PC0) Potentiometer

    External signals are also available on CON5 CN14:

        ADC_IN8 (PB0) CON5 CN14 Pin2
        ADC_IN9 (PB1) CON5 CN14 Pin1

    The signal selection is hard-coded in
    boards/arm/stm32/shenzhou/src/up\_adc.c: The potentiometer input
    (only) is selected.

    These selections will enable sampling the potentiometer input at
    100Hz using Timer 1:

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

Reading from the LCD is not supported only because it has not been
tested. If you get inspired to test this feature, you can turn the LCD
read functionality on by setting:

    -CONFIG_LCD_NOGETRUN=y
    +# CONFIG_LCD_NOGETRUN is not set

    -CONFIG_NX_WRITEONLY=y
    +# CONFIG_NX_WRITEONLY is not set

### thttpd

This builds the THTTPD web server example using the THTTPD and the
apps/examples/thttpd application.

NOTE: This example can only be built using the older toolchains due to
incompatibilities introduced in later GCC releases.
