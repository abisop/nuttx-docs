# GD32F4

The devices of GD32F4xx series are 32-bit general-purpose
microcontrollers based on the Cortex-M4 processor. The Cortex-M4
processor includes three AHB buses known as I-Code, D-Code and System
buses. All memory accesses of the Cortex-M4 processor are executed on
the three buses according to the different purposes and the target
memory spaces. The memory organization uses a Harvard architecture,
pre-defined memory map and up to 4 GB of memory space, making the system
flexible and extendable.

## Supported MCUs

TODO

## Peripheral Support

The following list indicates peripherals now supported in NuttX:

| Peripheral                                                           | Support                                                  | Notes |
| -------------------------------------------------------------------- | -------------------------------------------------------- | ----- |
| SYSCFG FMC PMU RCU GPIO DMA IPA EXTI SPI TLI I2C USART I2S SDIO ENET | Yes Yes yes Yes Yes Yes no Yes Yes no Yes Yes no yes Yes |       |

### Memory

  - CONFIG\_RAM\_SIZE - Describes the installed DRAM (SRAM in this case)
  - CONFIG\_RAM\_START - The start address of installed DRAM
  - CONFIG\_GD32\_TCMEXCLUDE - Exclude TCM SRAM from the HEAP
  - CONFIG\_ARCH\_INTERRUPTSTACK - This architecture supports an
    interrupt stack. If defined, this symbol is the size of the
    interrupt stack in bytes. If not defined, the user task stacks will
    be used during interrupt handling.

## Supported Boards

> boards/*/*
