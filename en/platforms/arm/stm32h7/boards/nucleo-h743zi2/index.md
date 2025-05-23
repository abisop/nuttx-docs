# ST Nucle H743ZI2

<div class="tags">

chip:stm32, chip:stm32h7, chip:stm32h743

</div>

This page discusses issues unique to NuttX configurations for the
STMicro NUCLEO-H743ZI2 development board featuring the STM32H743ZI MCU.
The STM32H743ZI is a 400MHz Cortex-M7 operation with 2MBytes Flash
memory and 1MByte SRAM. The board features:

  - On-board ST-LINK/V2 for programming and debugging,
  - 3 user LEDs
  - Two pushbuttons (user and reset)
  - 32.768 kHz crystal oscillator
  - USB OTG FS with Micro-AB connectors
  - Ethernet connector compliant with IEEE-802.3-2002
  - Board connectors:
      - USB with Micro-AB
      - SWD
      - Ethernet RJ45
      - ST Zio connector including Arduino Uno V3
      - ST morpho

Refer to the <http://www.st.com> website for further information about
this board (search keyword: NUCLEO-H743ZI2)

## Serial Console

Many options are available for a serial console via the Morpho
connector. Here two common serial console options are suggested:

1.  Arduino Serial Shield.
    
    If you are using a standard Arduino RS-232 shield with the serial
    interface with RX on pin D0 and TX on pin D1 from USART6:
    
    > 
    > 
    > | ARDUINO | FUNCTION   | GPIO |
    > | ------- | ---------- | ---- |
    > | DO RX   | USART6\_RX | PG9  |
    > | D1 TX   | USART6\_TX | PG14 |
    > 

2.  Nucleo Virtual Console.
    
    The virtual console uses Serial Port 3 (USART3) with TX on PD8 and
    RX on PD9.
    
    > 
    > 
    > | VCOM Signal | Pin |
    > | ----------- | --- |
    > | SERIAL\_RX  | PD9 |
    > | SERIAL\_TX  | PD8 |
    > 

    These signals are internally connected to the on board ST-Link.
    
    The Nucleo virtual console is the default serial console in all
    configurations unless otherwise stated in the description of the
    configuration.

## Configurations

### nsh:

This configuration provides a basic NuttShell configuration (NSH) for
the Nucleo-H743ZI. The default console is the VCOM on USART3.

### jumbo:

This configuration enables many Apache NuttX features. This is mostly to
help provide additional code coverage in CI, but also allows for a users
to see a wide range of features that are supported by the OS.

  - Some highlights:
    
      - NSH:
        
          - Readline with tab completion
          - Readline command history
    
      - Performance and Monitoring:
        
          - RAM backed syslog
          - Syslog with process name, priority, and timestamp
          - Process Snapshot with stack usage, cpu usage, and signal
            information
          - Interrupt Statistics
          - procfs filesystem (required for ifconfig, ifup/ifdown)
    
      - Networking:
        
          - IPv4 Networking
          - Ethernet
          - DHCP Client
          - iperf
          - telnet daemon
    
      - File Systems:
        
          - FAT filesystem
          - LittleFS
          - RAM MTD device
    
      - Testing:
        
          - OS Test with FPU support
          - Filesystem testing
    
      - USB Host:
        
          - USB Hub support
          - Mass Storage Device
          - Trace Monitoring
