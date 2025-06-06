Nordic nRF5340 DK
=================

chip:nrf53, chip:nrf5340

The [nRF5340-DK
(PCA10092)](https://www.nordicsemi.com/Products/Development-hardware/nrf5340-dk)
is a development board based on the nRF5340 from Nordic.

Serial Console
--------------

Serial console for the application core:

  Pin     Signal         Notes
  ------- -------------- ---------------
  P1.01   APP UART0 TX   virtual COM 0
  P1.00   APP UART0 RX   virtual COM 0

Serial console for the network core:

  Pin     Signal         Notes
  ------- -------------- ---------------
  P0.20   NET UART0 TX   virtual COM 1
  P0.22   NET UART0 RX   virtual COM 1

LEDs and Buttons
----------------

### LEDs

The PCA10092 has 4 user-controllable LEDs:

  LED    MCU
  ------ -------
  LED1   P0.28
  LED2   P0.29
  LED3   P0.30
  LED4   P0.31

A low output illuminates the LED.

### CONFIG\_ARCH\_LEDS

If CONFIG\_ARCH\_LEDS is not defined, then the LEDs are completely under
control of the application. The following interfaces are then available
for application control of the LEDs:

    uint32_t board_userled_initialize(void);
    void board_userled(int led, bool ledon);
    void board_userled_all(uint32_t ledset);

### Pushbuttons

  BUTTON    MCU
  --------- -------
  BUTTON1   P0.23
  BUTTON2   P0.24
  BUTTON3   P0.08
  BUTTON4   P0.09

Configurations
--------------

Each configuration is maintained in a sub-directory and can be selected
as follow:

    tools/configure.sh nrf5340-dk:<subdir>

Where \<subdir\> is one of the following:

### adc\_cpuapp

This configuration shows the use of the ADC peripheral.

### composite\_cpuapp

NuttShell configuration for the application core with support for
CDC/ACM with RNDIS composite driver.

### nsh\_cpuapp

Basic NuttShell configuration for the application core (console enabled
in UART0, exposed via J-Link VCOM0, at 115200 bps).

### nsh\_cpunet

Basic NuttShell configuration for the network core (console enabled in
UART0, exposed via J-Link VCOM1, at 115200 bps).

### ostest\_tickless\_cpuapp

This is a NSH configuration that includes `apps/testing/ostest` as a
builtin and enable support for the tick-less OS.

### pwm\_cpuapp

This configuration shows the use of the PWM peripheral.

### qspi\_cpuapp

NuttShell configuration with enabled support for on-board MX25R QSPI
memory.

### rpmsghci\_bt\_cpuapp

This configuration enables RPMSG Bluetooth HCI client on the application
core and uses NuttX BLE stack for the host-layer

### rpmsghci\_nimble\_cpuapp

This configuration enables RPMSG Bluetooth HCI client on the application
core and uses nimBLE for the host-layer

### rpmsghci\_sdc\_cpunet

This configuration enables RPMSG Bluetooth HCI server on the network
core which can be accessed using RPMSG Bluetooth HCI client on the
application core.

### rptun\_cpuapp

This configuration enables basic RPTUN support on the application core.
The `rptun` command will be available from NSH.

### rptun\_cpunet

This configuration enables basic RPTUN support on the network core. The
`rptun` command will be available from NSH.

### sdc\_cpunet

Enables Nordic\'s SoftDevice controller on the network core and uses
NuttX BLE stack for the host-layer. The `btsak` application is included
as a builtin.

### sdc\_nimble\_cpunet

Enables Nordic\'s SoftDevice controller on the network core and uses
nimBLE for the host-layer. The `nimble` test application can be used to
enable a simple GATT server.

### timer\_cpuapp

This configuration shows the use of the TIMER peripheral.
