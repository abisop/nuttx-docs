Nordic Thingy:91
================

chip:nrf91, chip:nrf52, chip:nrf9160, chip:nrf52840

The [Thingy:91
(PCA0035)](https://www.nordicsemi.com/Products/Development-hardware/Nordic-Thingy-91)
is a development board based on the nRF9160 and nRF52840 from Nordic.

Peripheral Support
------------------

  Peripheral                                                                                                                                                                                              Support                                        NOTES
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------- -------
  UART Modem GPS Buttons LEDs COEX PMIC Battery monitoring Buzzer EEPROM (24CW160) Low power accelerometer (ADXL362) Hi G accelerometer (ADXL372) Air quality sensor (HBME680) Color sensor (BH1749NUC)   Yes Yes No Yes No No No No No No No No No No   

Serial Console
--------------

1.  Console over RTT UART
2.  Access to UART0 console over USB connected to nRF52840. MCU\_IF0 and
    MCU\_IF1 pins are used to communicate between MCUs.

Configurations
--------------

TODO

Flash & Debug
-------------

Both flashing and debuing is possible only with an external debug probe.
