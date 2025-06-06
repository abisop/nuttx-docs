Nordic nRF9160 DK (nRF9160)
===========================

chip:nrf91, chip:nrf9160

The [nRF9160-DK
(PCA10090)](https://www.nordicsemi.com/Products/Development-hardware/nrf9160-dk)
is a development board based on the nRF9160 and nRF52840 from Nordic.

Serial Console
--------------

Serial console for the application core:

  Pin     Signal         Notes
  ------- -------------- ---------------
  P0.28   APP UART0 TX   virtual COM 0
  P0.29   APP UART0 RX   virtual COM 0

Serial console for the bootloader (secure domain):

  Pin     Signal         Notes
  ------- -------------- ---------------
  P0.00   APP UART1 TX   virtual COM 2
  P0.01   APP UART1 RX   virtual COM 2

LEDs and Buttons
----------------

### LEDs

The PCA10090 has 4 user-controllable LEDs:

  LED    MCU
  ------ -------
  LED1   P0.02
  LED2   P0.03
  LED3   P0.04
  LED4   P0.05

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
  BUTTON1   P0.06
  BUTTON2   P0.07

Configurations
--------------

Each configuration is maintained in a sub-directory and can be selected
as follow:

    tools/configure.sh nrf9160-dk:<subdir>

Where \<subdir\> is one of the following:

### nsh

Basic NuttShell configuration (console enabled in UART0, exposed via
J-Link VCOM connection, at 115200 bps).

### ostest\_tickless

This is a NSH configuration that includes `apps/testing/ostest` as a
builtin and enable support for the tick-less OS.

### miniboot\_s

This configuration is a simple bootloader that allows you to enter a TZ
non-secure environment.

### modem\_ns

This configuration includes modem firmware and MUST BE run in non-secure
environment. Booting into a non-secure environment can be done using the
miniboot\_s configuration.

To get this configuration working with miniboot bootloader follow these
steps:

1.  build firmware for miniboot and modem configuration:

        cmake -B build_boot -DBOARD_CONFIG=nrf9160-dk:miniboot_s -GNinja
        cmake -B build_modem -DBOARD_CONFIG=nrf9160-dk:modem_ns -GNinja
        cmake --build build_boot
        cmake --build build_modem

2.  flash bootloader:

        nrfjprog --program build_boot/nuttx.hex --chiperase --verify

3.  flash modem image:

        nrfjprog --program build_modem/nuttx.hex

4.  reset chip:

        nrfjprog --reset
