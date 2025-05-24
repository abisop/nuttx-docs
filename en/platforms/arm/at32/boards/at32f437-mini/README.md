README
======

This README discusses issues unique to NuttX configurations for the
AT32F437-MINI development board featuring the AT32F437VMT7 MCU. The
AT32F437VMT7 is a 288MHz Cortex-M4 operation with 4Mbyte Flash memory
and 384kbytes.

LEDs
====

LED1 = PE2 LED2 = PE3

USART/UART
==========

USART1 RX = PA10 TX = PA9 The usart1 is used for console.
./tools/configure.sh at32f437-mini/nsh make -j16 and flash
nuttx.hex,then run it will show: NuttShell (NSH) NuttX-12.2.1 nsh\>
nsh\> nsh\> ps PID GROUP PRI POLICY TYPE NPX STATE EVENT SIGMASK STACK
COMMAND 0 0 0 FIFO Kthread N-- Ready 0000000000000000 001016 Idle\_Task
2 2 100 RR Task --- Running 0000000000000000 002016 nsh\_main nsh\>

USART2/RS485 RX = PD6 TX = PD5\
DIR = PD4

CAN
===

CAN1 TX = PD1 RX = PD0 CAN\_CHARDRIVER: ./tools/configure.sh
at32f437-mini/can\_char CAN\_SOCKET: ./tools/configure.sh
at32f437-mini/can\_socket

USB
===

OTGFS1 D+ = PA12 D- = PA11

SDIO
====

SDIO1 CMD = PD2 CLK = PC12 D0 = PC8 D1 = PC9 D2 = PC10 D3 = PC11

ETH RMII\_REF\_CLK = PA1 ETH\_MDIO = PA2 RMII\_CRS\_DV = PA7 ETH\_MDC =
PC1 RMII\_RXD0 = PC4 RMII\_RXD1 = PC5 RMII\_TX\_EN = PB11 RMII\_TXD0 =
PB12 RMII\_TXD1 = PB13 ETH\_RST = PA3 The eth used lan8720a as phy

W25QXX CLK = PB3 MISO = PB4 MOSI = PB5 CS = PD7

RTC The board used rtc device on chip

PWM The pwm test with tim20 chanel1 in PE2

ADC ADC1 chanel8(PB0)
