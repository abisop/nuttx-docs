OMNIBUSF4
=========

chip:stm32, chip:stm32f4, chip:stm32f405

\"OmnibusF4\" is not a product name per se, but rather a design spec
that many product vendors within the drone flight management unit (FMU)
community adhere to. The spec defines the major components, and how
those components are wired into the STM32F405RGT6 microcontroller.

Airbot is one such vendor, and they publish a schematic here:

> <http://bit.ly/obf4pro>

Other software that supports the OmnibusF4 family include Betaflight,
iNAV, and many others. PX4 recently added support as well. No code from
any of those sources is included in this port.

Since OmnibusF4 is a drone FMU, most of its IO is already allocated to
FMU-specific tasks. As such, we don\'t need to make the board support
package as flexible as, say, an STM32F4 Discovery board.

Build Instructions
------------------

The boards/arm/stm32/omnibusf4/nsh/defconfig file creates a basic setup,
and includes drivers for all supported onboard chips. The console and
command prompt are sent to USART3.
