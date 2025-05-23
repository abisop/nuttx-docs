# Espressif ESP32

The ESP32 is a series of single and dual-core SoCs from Espressif based
on Harvard architecture Xtensa LX6 CPUs and with on-chip support for
Bluetooth and Wi-Fi.

All embedded memory, external memory and peripherals are located on the
data bus and/or the instruction bus of these CPUs. With some minor
exceptions, the address mapping of two CPUs is symmetric, meaning they
use the same addresses to access the same memory. Multiple peripherals
in the system can access embedded memory via DMA.

On dual-core SoCs, the two CPUs are typically named "PRO\_CPU" and
"APP\_CPU" (for "protocol" and "application"), however for most purposes
the two CPUs are interchangeable.

## ESP32 Toolchain

The toolchain used to build ESP32 firmware can be either downloaded or
built from the sources. It is **highly** recommended to use (download or
build) the same toolchain version that is being used by the NuttX CI.

Please refer to the Docker
[container](https://github.com/apache/nuttx/tree/master/tools/ci/docker/linux/Dockerfile)
and check for the current compiler version being used. For instance:

    ###############################################################################
    # Build image for tool required by ESP32 builds
    ###############################################################################
    FROM nuttx-toolchain-base AS nuttx-toolchain-esp32
    # Download the latest ESP32 GCC toolchain prebuilt by Espressif
    RUN mkdir -p xtensa-esp32-elf-gcc && \
      curl -s -L "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz" \
      | tar -C xtensa-esp32-elf-gcc --strip-components 1 -xJ
    
    RUN mkdir -p xtensa-esp32s2-elf-gcc && \
      curl -s -L "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s2-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz" \
      | tar -C xtensa-esp32s2-elf-gcc --strip-components 1 -xJ
    
    RUN mkdir -p xtensa-esp32s3-elf-gcc && \
      curl -s -L "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32s3-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz" \
      | tar -C xtensa-esp32s3-elf-gcc --strip-components 1 -xJ

For ESP32, the toolchain version is based on GGC 12.2.0
(`xtensa-esp32-elf-12.2.0_20230208`)

### The prebuilt Toolchain (Recommended)

First, create a directory to hold the toolchain:

``` console
 mkdir -p /path/to/your/toolchain/xtensa-esp32-elf-gcc
```

Download and extract toolchain:

``` console
 curl -s -L "https://github.com/espressif/crosstool-NG/releases/download/esp-12.2.0_20230208/xtensa-esp32-elf-12.2.0_20230208-x86_64-linux-gnu.tar.xz" \
| tar -C xtensa-esp32-elf-gcc --strip-components 1 -xJ
```

Add the toolchain to your \`PATH\`:

``` console
 echo "export PATH=/path/to/your/toolchain/xtensa-esp32-elf-gcc/bin:PATH" >> ~/.bashrc
```

You can edit your shell's rc files if you don't use bash.

### Building from source

You can also build the toolchain yourself. The steps to build the
toolchain with crosstool-NG on Linux are as follows

``` console
 git clone https://github.com/espressif/crosstool-NG.git
 cd crosstool-NG
 git submodule update --init

 ./bootstrap && ./configure --enable-local && make

 ./ct-ng xtensa-esp32-elf
 ./ct-ng build

 chmod -R u+w builds/xtensa-esp32-elf

 export PATH="crosstool-NG/builds/xtensa-esp32-elf/bin:PATH"
```

These steps are given in the setup guide in [ESP-IDF
documentation](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/linux-setup-scratch.html).

## Building and flashing NuttX

### Installing esptool

First, make sure that `esptool.py` is installed and up-to-date. This
tool is used to convert the ELF to a compatible ESP32 image and to flash
the image into the board.

It can be installed with: `pip install esptool>=4.8.1`.

<div class="warning">

<div class="title">

Warning

</div>

Installing `esptool.py` may required a Python virtual environment on
newer systems. This will be the case if the `pip install` command throws
an error such as: `error: externally-managed-environment`.

If you are not familiar with virtual environments, refer to [Managing
esptool on virtual environment]() for instructions on how to install
`esptool.py`.

</div>

### Bootloader and partitions

NuttX can boot the ESP32 directly using the so-called "Simple Boot". An
externally-built 2nd stage bootloader is not required in this case as
all functions required to boot the device are built within NuttX. Simple
boot does not require any specific configuration (it is selectable by
default if no other 2nd stage bootloader is used).

If other features are required, an externally-built 2nd stage bootloader
is needed. The bootloader is built using the `make bootloader` command.
This command generates the firmware in the `nuttx` folder. The
`ESPTOOL_BINDIR` is used in the `make flash` command to specify the path
to the bootloader. For compatibility among other SoCs and future options
of 2nd stage bootloaders, the commands `make bootloader` and the
`ESPTOOL_BINDIR` option (for the `make flash`) can be used even if no
externally-built 2nd stage bootloader is being built (they will be
ignored if Simple Boot is used, for instance):

     make bootloader

<div class="note">

<div class="title">

Note

</div>

It is recommended that if this is the first time you are using the board
with NuttX to perform a complete SPI FLASH erase.

``` console
 esptool.py erase_flash
```

</div>

### Building and Flashing

This is a two-step process where the first step converts the ELF file
into an ESP32 compatible binary and the second step flashes it to the
board. These steps are included in the build system and it is possible
to build and flash the NuttX firmware simply by running:

     make flash ESPTOOL_PORT=<port> ESPTOOL_BINDIR=./

where:

  - `ESPTOOL_PORT` is typically `/dev/ttyUSB0` or similar.
  - `ESPTOOL_BINDIR=./` is the path of the externally-built 2nd stage
    bootloader and the partition table (if applicable): when built using
    the `make bootloader`, these files are placed into `nuttx` folder.
  - `ESPTOOL_BAUD` is able to change the flash baud rate if desired.

### Flashing NSH Example

This example shows how to build and flash the `nsh` defconfig for the
ESP32-DevKitC board:

     cd nuttx
     make distclean
     ./tools/configure.sh esp32-devkitc:nsh
     make -j(nproc)

When the build is complete, the firmware can be flashed to the board
using the command:

     make -j(nproc) flash ESPTOOL_PORT=<port> ESPTOOL_BINDIR=./

where `<port>` is the serial port where the board is connected:

     make flash ESPTOOL_PORT=/dev/ttyUSB0 ESPTOOL_BINDIR=./
     CP: nuttx.hex
     MKIMAGE: ESP32 binary
     esptool.py -c esp32 elf2image --ram-only-header -fs 4MB -fm dio -ff 40m -o nuttx.bin nuttx
     esptool.py v4.8.1
     Creating esp32 image...
     Image has only RAM segments visible. ROM segments are hidden and SHA256 digest is not appended.
     Merged 1 ELF section
     Successfully created esp32 image.
     Generated: nuttx.bin
     esptool.py -c esp32 -p /dev/ttyUSB0 -b 921600  write_flash -fs detect -fm dio -ff 40m 0x1000 nuttx.bin
     esptool.py v4.8.1
     Serial port /dev/ttyUSB0
     Connecting.....
     Chip is ESP32-D0WD-V3 (revision v3.1)
     [...]
     Flash will be erased from 0x00001000 to 0x00032fff...
     Flash params set to 0x0230
     Compressed 203816 bytes to 74735...
     Wrote 203816 bytes (74735 compressed) at 0x00001000 in 2.2 seconds (effective 744.4 kbit/s)...
     Hash of data verified.
    
     Leaving...
     Hard resetting via RTS pin...

Now opening the serial port with a terminal emulator should show the
NuttX console:

     picocom -b 115200 /dev/ttyUSB0
    NuttShell (NSH) NuttX-12.8.0
    nsh> uname -a
    NuttX 12.8.0 759d37b97c-dirty Mar  5 2025 20:31:15 xtensa esp32-devkitc

## Debugging

This section describes debugging techniques for the ESP32.

### Debugging with `openocd` and `gdb`

Espressif uses a specific version of OpenOCD to support ESP32:
[openocd-esp32](https://github.com/espressif/).

Please check [Building OpenOCD from
Sources](https://docs.espressif.com/projects/esp-idf/en/release-v5.1/esp32/api-guides/jtag-debugging/index.html#jtag-debugging-building-openocd)
for more information on how to build OpenOCD for ESP32.

ESP32 has dedicated pins for JTAG debugging. The following pins are used
for JTAG debugging:

| ESP32 Pin     | JTAG Signal |
| ------------- | ----------- |
| MTDO / GPIO15 | TDO         |
| MTDI / GPIO12 | TDI         |
| MTCK / GPIO13 | TCK         |
| MTMS / GPIO14 | TMS         |

Some boards, like `ESP32-Ethernet-Kit V1.2
<platforms/xtensa/esp32/boards/esp32-ethernet-kit/index:ESP32-Ethernet-Kit
V1.2>` and `ESP-WROVER-KIT
<platforms/xtensa/esp32/boards/esp32-wrover-kit/index:ESP-WROVER-KIT>`,
have a built-in JTAG debugger.

Other boards that don't have any built-in JTAG debugger can be debugged
using an external JTAG debugger, like the one described for the
`ESP32-DevKitC
<platforms/xtensa/esp32/boards/esp32-devkitc/index:Debugging with
OpenOCD>`.

<div class="note">

<div class="title">

Note

</div>

One must configure the USB drivers to enable JTAG communication. Please
check [Configure USB
Drivers](https://docs.espressif.com/projects/esp-idf/en/release-v5.1/esp32/api-guides/jtag-debugging/configure-ft2232h-jtag.html#configure-usb-drivers)
for configuring the JTAG adapter of the `ESP32-Ethernet-Kit V1.2
<platforms/xtensa/esp32/boards/esp32-ethernet-kit/index:ESP32-Ethernet-Kit
V1.2>` and `ESP-WROVER-KIT
<platforms/xtensa/esp32/boards/esp32-wrover-kit/index:ESP-WROVER-KIT>`
boards and other FT2232-based JTAG adapters.

</div>

OpenOCD can then be used:

    openocd -s <tcl_scripts_path> -c 'set ESP_RTOS hwthread' -f board/esp32-wrover-kit-3.3v.cfg -c 'init; reset halt; esp appimage_offset 0x1000'

<div class="note">

<div class="title">

Note

</div>

\- `appimage_offset` should be set to `0x1000` when `Simple Boot` is
used. For MCUboot, this value should be set to
`CONFIG_ESP32_OTA_PRIMARY_SLOT_OFFSET` value (`0x10000` by default). -
`-s <tcl_scripts_path>` defines the path to the OpenOCD scripts. Usually
set to <span class="title-ref">tcl</span> if running openocd from its
source directory. It can be omitted if
<span class="title-ref">openocd-esp32</span> were installed in the
system with <span class="title-ref">sudo make install</span>.

</div>

Once OpenOCD is running, you can use GDB to connect to it and debug your
application:

    xtensa-esp32-elf-gdb -x gdbinit nuttx

whereas the content of the `gdbinit` file is:

    target remote :3333
    set remote hardware-watchpoint-limit 2
    mon reset halt
    flushregs
    monitor reset halt
    thb nsh_main
    c

<div class="note">

<div class="title">

Note

</div>

`nuttx` is the ELF file generated by the build process. Please note that
`CONFIG_DEBUG_SYMBOLS` must be enabled in the `menuconfig`.

</div>

Please refer to
\[<span class="title-ref">/quick\](</span>/quick.md)start/debugging\`
for more information about debugging techniques.

### Stack Dump and Backtrace Dump

NuttX has a feature to dump the stack of a task and to dump the
backtrace of it (and of all the other tasks). This feature is useful to
debug the system when it is not behaving as expected, especially when it
is crashing.

In order to enable this feature, the following options must be enabled
in the NuttX configuration: `CONFIG_SCHED_BACKTRACE`,
`CONFIG_DEBUG_SYMBOLS` and, optionally, `CONFIG_ALLSYMS`.

<div class="note">

<div class="title">

Note

</div>

The first two options enable the backtrace dump. The third option
enables the backtrace dump with the associated symbols, but increases
the size of the generated NuttX binary.

</div>

Espressif also provides a tool to translate the backtrace dump into a
human-readable format. This tool is called `btdecode.sh` and is
available at `tools/espressif/btdecode.sh` of NuttX repository.

<div class="note">

<div class="title">

Note

</div>

This tool is not necessary if `CONFIG_ALLSYMS` is enabled. In this case,
the backtrace dump contains the function names.

</div>

#### Example - Crash Dump

A typical crash dump, caused by an illegal load with
`CONFIG_SCHED_BACKTRACE` and `CONFIG_DEBUG_SYMBOLS` enabled, is shown
below:

    xtensa_user_panic: User Exception: EXCCAUSE=001d task: backtrace
    _assert: Current Version: NuttX  10.4.0 2ae3246e40-dirty Sep 19 2024 12:59:10 xtensa
    _assert: Assertion failed user panic: at file: :0 task: backtrace process: backtrace 0x400f0724
    up_dump_register:    PC: 400f0754    PS: 00060530
    up_dump_register:    A0: 800e2fcc    A1: 3ffe1400    A2: 00000000    A3: 3ffe0470
    up_dump_register:    A4: 3ffe0486    A5: 3ffaf4b0    A6: 00000000    A7: 00000000
    up_dump_register:    A8: 800f0751    A9: 3ffe13d0   A10: 0000005a   A11: 3ffafcb0
    up_dump_register:   A12: 00000059   A13: 3ffaf600   A14: 00000002   A15: 3ffafaa4
    up_dump_register:   SAR: 00000018 CAUSE: 0000001d VADDR: 00000000
    up_dump_register:  LBEG: 4000c28c  LEND: 4000c296  LCNT: 00000000
    dump_stack: User Stack:
    dump_stack:   base: 0x3ffe0490
    dump_stack:   size: 00004048
    dump_stack:     sp: 0x3ffe1400
    stack_dump: 0x3ffe13e0: 00000059 3ffaf600 00000002 3ffafaa4 800e1eb4 3ffe1420 400f0724 00000002
    stack_dump: 0x3ffe1400: 3ffe0486 3ffaf4b0 00000000 00000000 00000000 3ffe1440 00000000 400f0724
    stack_dump: 0x3ffe1420: 3ffe0470 3ffafae8 00000000 3ffb0d2c 00000000 3ffe1460 00000000 00000000
    stack_dump: 0x3ffe1440: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
    stack_dump: 0x3ffe1460: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
    sched_dumpstack: backtrace| 2: 0x400ef738 0x40085152 0x40084d05 0x40084c7d 0x40080c84 0x400f0754 0x400e2fcc 0x400e1eb4
    sched_dumpstack: backtrace| 2: 0x40000000 0x400e2fcc 0x400e1eb4 0x40000000
    dump_tasks:    PID GROUP PRI POLICY   TYPE    NPX STATE   EVENT      SIGMASK          STACKBASE  STACKSIZE   COMMAND
    dump_task:       0     0   0 FIFO     Kthread - Ready              0000000000000000 0x3ffb0010      3056   Idle_Task
    dump_task:       1     1 100 RR       Task    - Waiting Semaphore  0000000000000000 0x3ffaec10      3024   nsh_main
    dump_task:       2     2 255 RR       Task    - Running            0000000000000000 0x3ffe0490      4048   backtrace task
    sched_dumpstack: backtrace| 0: 0x400e12bb 0x400826eb
    sched_dumpstack: backtrace| 1: 0x400edc59 0x400edb5b 0x400edb94 0x400e6c36 0x400e643c 0x400e6714 0x400e5830 0x400e56b8
    sched_dumpstack: backtrace| 1: 0x400e5689 0x400e2fcc 0x400e1eb4 0x40000000
    sched_dumpstack: backtrace| 2: 0x400ef738 0x40084ed4 0x400ed9ea 0x40085184 0x40084d05 0x40084c7d 0x40080c84 0x400f0754
    sched_dumpstack: backtrace| 2: 0x400e2fcc 0x400e1eb4 0x40000000 0x400e2fcc 0x400e1eb4 0x40000000

The lines starting with `sched_dumpstack` show the backtrace of the
tasks. By checking it, it is possible to track the root cause of the
crash. Saving this output to a file and using the `btdecode.sh`:

    ./tools/btdecode.sh esp32 /tmp/backtrace.txt
    Backtrace for task 2:
    0x400ef738: sched_dumpstack at sched_dumpstack.c:69
    0x40085152: _assert at assert.c:691
    0x40084d05: xtensa_user_panic at xtensa_assert.c:188 (discriminator 1)
    0x40084c7d: xtensa_user at ??:?
    0x40080c84: _xtensa_user_handler at xtensa_user_handler.S:194
    0x400f0754: assert_on_task at backtrace_main.c:158
     (inlined by) backtrace_main at backtrace_main.c:194
    0x400e2fcc: nxtask_startup at task_startup.c:70
    0x400e1eb4: nxtask_start at task_start.c:75
    0x40000000: ?? ??:0
    0x400e2fcc: nxtask_startup at task_startup.c:70
    0x400e1eb4: nxtask_start at task_start.c:75
    0x40000000: ?? ??:0
    
    Backtrace dump for all tasks:
    
    Backtrace for task 2:
    0x400ef738: sched_dumpstack at sched_dumpstack.c:69
    0x40084ed4: dump_backtrace at assert.c:418
    0x400ed9ea: nxsched_foreach at sched_foreach.c:69 (discriminator 2)
    0x40085184: _assert at assert.c:726
    0x40084d05: xtensa_user_panic at xtensa_assert.c:188 (discriminator 1)
    0x40084c7d: xtensa_user at ??:?
    0x40080c84: _xtensa_user_handler at xtensa_user_handler.S:194
    0x400f0754: assert_on_task at backtrace_main.c:158
     (inlined by) backtrace_main at backtrace_main.c:194
    0x400e2fcc: nxtask_startup at task_startup.c:70
    0x400e1eb4: nxtask_start at task_start.c:75
    0x40000000: ?? ??:0
    0x400e2fcc: nxtask_startup at task_startup.c:70
    0x400e1eb4: nxtask_start at task_start.c:75
    0x40000000: ?? ??:0
    
    Backtrace for task 1:
    0x400edc59: nxsem_wait at sem_wait.c:217
    0x400edb5b: nxsched_waitpid at sched_waitpid.c:165
    0x400edb94: waitpid at sched_waitpid.c:618
    0x400e6c36: nsh_builtin at nsh_builtin.c:163
    0x400e643c: nsh_execute at nsh_parse.c:652
     (inlined by) nsh_parse_command at nsh_parse.c:2840
    0x400e6714: nsh_parse at nsh_parse.c:2930
    0x400e5830: nsh_session at nsh_session.c:246
    0x400e56b8: nsh_consolemain at nsh_consolemain.c:79
    0x400e5689: nsh_main at nsh_main.c:80
    0x400e2fcc: nxtask_startup at task_startup.c:70
    0x400e1eb4: nxtask_start at task_start.c:75
    0x40000000: ?? ??:0
    
    Backtrace for task 0:
    0x400e12bb: nx_start at nx_start.c:772 (discriminator 1)
    0x400826eb: __esp32_start at esp32_start.c:294
     (inlined by) __start at esp32_start.c:358

The above output shows the backtrace of the tasks. By checking it, it is
possible to track the functions that were being executed when the crash
occurred.

## Peripheral Support

The following list indicates the state of peripherals' support in NuttX:

<table>
<thead>
<tr class="header">
<th>Peripheral</th>
<th>Support</th>
<th>NOTES</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>ADC AES Bluetooth Camera CAN/TWAI DMA</p></td>
<td><blockquote>
<p>Yes Yes Yes No Yes Yes</p>
</blockquote></td>
<td><blockquote>
<p>Oneshot</p>
</blockquote></td>
</tr>
<tr class="even">
<td><p>DAC eFuse Ethernet GPIO</p></td>
<td><blockquote>
<p>Yes Yes Yes Yes</p>
</blockquote></td>
<td><blockquote>
<p>One-shot</p>
</blockquote></td>
</tr>
<tr class="odd">
<td><p>I2C I2S</p></td>
<td><blockquote>
<p>Yes Yes</p>
</blockquote></td>
<td><blockquote>
<p>Master and Slave mode supported</p>
</blockquote></td>
</tr>
<tr class="even">
<td><p>LCD LED/PWM MCPWM Pulse_CNT RMT RNG RSA RTC SD/MMC SDIO SHA SPI SPIFLASH SPIRAM Timers Touch UART Watchdog Wi-Fi</p></td>
<td><blockquote>
<p>No Yes Yes Yes Yes Yes No Yes No No No Yes Yes Yes Yes Yes Yes Yes Yes</p>
</blockquote></td>
<td><blockquote>
<p>There is support for SPI displays</p>
</blockquote></td>
</tr>
</tbody>
</table>

## Memory Map

### Address Mapping

<table>
<thead>
<tr class="header">
<th>BUS TYPE</th>
<th>START</th>
<th>LAST</th>
<th>DESCRIPTION</th>
<th>NOTES</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Data Data</p>
<p>Data Data Instruction Instruction . Data / Instruction</p>
<p>.</p></td>
<td><p>0x00000000 0x3F400000 0x3F800000 0x3FC00000 0x3FF00000 0x3FF80000 0x40000000 0x400C2000 0x40C00000 0x50000000</p>
<p>0x50002000</p></td>
<td><p>0x3F3FFFFF 0x3F7FFFFF 0x3FBFFFFF 0x3FEFFFFF 0x3FF7FFFF 0x3FFFFFFF 0x400C1FFF 0x40BFFFFF 0x4FFFFFFF 0x50001FFF</p>
<p>0xFFFFFFFF</p></td>
<td><p>External Memory External Memory</p>
<p>Peripheral Embedded Memory Embedded Memory External Memory</p>
<p>Embedded Memory</p></td>
<td><p>Reserved</p>
<p>Reserved</p>
<p>Reserved</p>
<p>Reserved</p></td>
</tr>
</tbody>
</table>

### Embedded Memory

<table>
<thead>
<tr class="header">
<th>BUS TYPE</th>
<th>START</th>
<th>LAST</th>
<th>DESCRIPTION</th>
<th>NOTES</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Data . Data .</p></td>
<td><p>0x3ff80000 0x3ff82000 0x3ff90000 0x3ffa0000</p></td>
<td><p>0x3ff81fff 0x3ff8ffff 0x3ff9ffff 0x3ffadfff</p></td>
<td><p>RTC FAST Memory</p>
<p>Internal ROM 1</p></td>
<td><p>PRO_CPU Only Reserved</p>
<p>Reserved</p></td>
</tr>
<tr class="even">
<td>Data</td>
<td>0x3ffae000</td>
<td>0x3ffdffff</td>
<td>Internal SRAM 2</td>
<td>DMA</td>
</tr>
<tr class="odd">
<td>Data</td>
<td>0x3ffe0000</td>
<td>0x3fffffff</td>
<td>Internal SRAM 1</td>
<td>DMA</td>
</tr>
</tbody>
</table>

### Boundary Address (Embedded)

<table>
<thead>
<tr class="header">
<th>BUS TYPE</th>
<th>START</th>
<th>LAST</th>
<th>DESCRIPTION</th>
<th>NOTES</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Instruction Instruction .</p></td>
<td><p>0x40000000 0x40008000 0x40060000</p></td>
<td><p>0x40007fff 0x4005ffff 0x4006ffff</p></td>
<td><p>Internal ROM 0 Internal ROM 0</p></td>
<td><p>Remap</p>
<p>Reserved</p></td>
</tr>
<tr class="even">
<td><p>Instruction Instruction Instruction</p></td>
<td><p>0x40070000 0x40080000 0x400a0000</p></td>
<td><p>0x4007ffff 0x4009ffff 0x400affff</p></td>
<td><p>Internal SRAM 0 Internal SRAM 0 Internal SRAM 1</p></td>
<td><p>Cache</p></td>
</tr>
<tr class="odd">
<td><p>Instruction Instruction</p></td>
<td><p>0x400b0000 0x400b8000</p></td>
<td><p>0x400b7FFF 0x400bffff</p></td>
<td><p>Internal SRAM 1 Internal SRAM 1</p></td>
<td><p>Remap</p></td>
</tr>
<tr class="even">
<td><p>Instruction Data / Instruction</p></td>
<td><p>0x400c0000 0x50000000</p></td>
<td><p>0x400c1FFF 0x50001fff</p></td>
<td><p>RTC FAST Memory RTC SLOW Memory</p></td>
<td><p>PRO_CPU Only</p></td>
</tr>
</tbody>
</table>

### External Memory

| BUS TYPE | START      | LAST       | DESCRIPTION    | NOTES          |
| -------- | ---------- | ---------- | -------------- | -------------- |
| Data     | 0x3f400000 | 0x3f7fffff | External Flash | Read           |
| Data     | 0x3f800000 | 0x3fbfffff | External SRAM  | Read and Write |

### Boundary Address (External)

Instruction 0x400c2000 0x40bfffff 11512 KB External Flash Read

### Linker Segments

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 8%" />
<col style="width: 36%" />
</colgroup>
<thead>
<tr class="header">
<th>DESCRIPTION</th>
<th>START</th>
<th>END</th>
<th>ATTR</th>
<th>LINKER SEGMENT NAME</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><dl>
<dt>FLASH mapped data:</dt>
<dd><ul>
<li>.rodata</li>
<li>Constructors /destructors</li>
</ul>
</dd>
</dl></td>
<td>0x3f400010</td>
<td>0x3fc00010</td>
<td>R</td>
<td>drom0_0_seg</td>
</tr>
<tr class="even">
<td><dl>
<dt>COMMON data RAM:</dt>
<dd><ul>
<li>.bss/.data</li>
</ul>
</dd>
</dl></td>
<td>0x3ffb0000</td>
<td>0x40000000</td>
<td>RW</td>
<td>dram0_0_seg (NOTE 1,2,3)</td>
</tr>
<tr class="odd">
<td><dl>
<dt>IRAM for PRO cpu:</dt>
<dd><ul>
<li>Interrupt Vectors</li>
<li>Low level handlers</li>
<li>Xtensa/Espressif libraries</li>
</ul>
</dd>
</dl></td>
<td>0x40080000</td>
<td>0x400a0000</td>
<td>RX</td>
<td>iram0_0_seg</td>
</tr>
<tr class="even">
<td><dl>
<dt>RTC fast memory:</dt>
<dd><ul>
<li>.rtc.text (unused?)</li>
</ul>
</dd>
</dl></td>
<td>0x400c0000</td>
<td>0x400c2000</td>
<td>RWX</td>
<td>rtc_iram_seg (PRO_CPU only)</td>
</tr>
<tr class="odd">
<td><dl>
<dt>FLASH:</dt>
<dd><ul>
<li>.text</li>
</ul>
</dd>
</dl></td>
<td>0x400d0018</td>
<td>0x40400018</td>
<td>RX</td>
<td>iram0_2_seg (actually FLASH)</td>
</tr>
<tr class="even">
<td><dl>
<dt>RTC slow memory:</dt>
<dd><ul>
<li>.rtc.data/rodata (unused?)</li>
</ul>
</dd>
</dl></td>
<td>0x50000000</td>
<td>0x50001000</td>
<td>RW</td>
<td>rtc_slow_seg (NOTE 4)</td>
</tr>
</tbody>
</table>

<div class="note">

<div class="title">

Note

</div>

1)  Linker script will reserve space at the beginning of the segment for
    BT and at the end for trace memory.
2)  Heap ends at the top of dram\_0\_seg.
3)  Parts of this region is reserved for the ROM bootloader.
4)  Linker script will reserve space at the beginning of the segment for
    co-processor reserve memory and at the end for ULP coprocessor
    reserve memory.

</div>

## 64-bit Timers

ESP32 has 4 generic timers of 64 bits (2 from Group 0 and 2 from Group
1). They're accessible as character drivers, the configuration along
with a guidance on how to run the example and the description of the
application level interface can be found \[<span class="title-ref">here
\</component\](\`here
\</component.md)s/drivers/character/timers/timer\></span>.

## Watchdog Timers

ESP32 has 3 WDTs. 2 MWDTS from the Timers Module and 1 RWDT from the RTC
Module (Currently not supported yet). They're accessible as character
drivers, The configuration along with a guidance on how to run the
example and the description of the application level interface can be
found \[<span class="title-ref">here \</component\](\`here
\</component.md)s/drivers/character/timers/watchdog\></span>.

## SMP

The ESP32 has 2 CPUs. Support is included for testing an SMP
configuration. That configuration is still not yet ready for usage but
can be enabled with the following configuration settings, in `RTOS
Features --> Tasks and Scheduling`, with:

    CONFIG_SPINLOCK=y
    CONFIG_SMP=y
    CONFIG_SMP_NCPUS=2

Debug Tip: During debug session, OpenOCD may mysteriously switch from
one CPU to another. This behavior can be eliminated by uncommenting one
of the following in `scripts/esp32.cfg`:

    # Only configure the PRO CPU
    #set ESP32_ONLYCPU 1
    # Only configure the APP CPU
    #set ESP32_ONLYCPU 2

## Wi-Fi

A standard network interface will be configured and can be initialized
such as:

    nsh> ifup wlan0
    nsh> wapi psk wlan0 mypasswd 3
    nsh> wapi essid wlan0 myssid 1
    nsh> renew wlan0

In this case a connection to AP with SSID `myssid` is done, using
`mypasswd` as password. IP address is obtained via DHCP using `renew`
command. You can check the result by running `ifconfig` afterwards.

<div class="tip">

<div class="title">

Tip

</div>

Boards usually expose a `wifi` defconfig which enables Wi-Fi

</div>

<div class="tip">

<div class="title">

Tip

</div>

Please check \[<span class="title-ref">wapi \</application\](\`wapi
\</application.md)s/wireless/wapi/index\></span> documentation for more
information about its commands and arguments.

</div>

<div class="note">

<div class="title">

Note

</div>

The `wapi psk` command on Station mode sets a security threshold. That
is, it enables connecting only to an equally or more secure network than
the set threshold. `wapi psk wlan0 mypasswd 3` sets a WPA2-PSK-secured
network and enables the device to connect to networks that are equally
or more secure than that (WPA3-SAE, for instance, would be eligible for
connecting to).

</div>

## Wi-Fi SoftAP

It is possible to use ESP32 as an Access Point (SoftAP). Actually there
are some boards config examples called sta\_softap which enables this
support

If you are using this board config profile you can run these commands to
be able to connect your smartphone or laptop to your board:

    nsh> ifup wlan1
    nsh> dhcpd_start wlan1
    nsh> wapi psk wlan1 mypasswd 3
    nsh> wapi essid wlan1 nuttxap 1

In this case, you are creating the access point `nuttxapp` in your board
and to connect to it on your smartphone you will be required to type the
password `mypasswd` using WPA2.

<div class="tip">

<div class="title">

Tip

</div>

Please check \[<span class="title-ref">wapi \</application\](\`wapi
\</application.md)s/wireless/wapi/index\></span> documentation for more
information about its commands and arguments.

</div>

The `dhcpd_start` is necessary to let your board to associate an IP to
your smartphone.

## Bluetooth

These are the steps to test Bluetooth Low Energy (BLE) scan on ESP32
(i.e. Devkit board). First configure to use the BLE board profile:

     make distclean
     ./tools/configure.sh esp32-devkitc:ble
     make flash ESPTOOL_PORT=/dev/ttyUSB0

Enter in the NSH shell using your preferred serial console tool and run
the scan command:

    NuttShell (NSH) NuttX-10.2.0
    nsh> ifconfig
    bnep0   Link encap:UNSPEC at DOWN
            inet addr:0.0.0.0 DRaddr:0.0.0.0 Mask:0.0.0.0
    
    wlan0   Link encap:Ethernet HWaddr ac:67:b2:53:8b:ec at UP
            inet addr:10.0.0.2 DRaddr:10.0.0.1 Mask:255.255.255.0
    
    nsh> bt bnep0 scan start
    nsh> bt bnep0 scan stop
    nsh> bt bnep0 scan get
    Scan result:
    1.     addr:           63:14:2f:b9:9f:83 type: 1
           rssi:            -90
           response type:   3
           advertiser data: 1e ff 06 00 01 09 20 02 7c 33 a3 a7 cd c9 44 5b
    2.     addr:           52:ca:05:b5:ad:77 type: 1
           rssi:            -82
           response type:   3
           advertiser data: 1e ff 06 00 01 09 20 02 03 d1 21 57 bf 19 b3 7a
    3.     addr:           46:8e:b2:cd:94:27 type: 1
           rssi:            -92
           response type:   2
           advertiser data: 02 01 1a 09 ff c4 00 10 33 14 12 16 80 02 0a d4
    4.     addr:           46:8e:b2:cd:94:27 type: 1
           rssi:            -92
           response type:   4
           advertiser data: 18 09 5b 4c 47 5d 20 77 65 62 4f 53 20 54 56 20
    5.     addr:           63:14:2f:b9:9f:83 type: 1
           rssi:            -80
           response type:   3
        advertiser data: 1e ff 06 00 01 09 20 02 7c 33 a3 a7 cd c9 44 5b
    nsh>

## I2S

The I2S peripheral is accessible using either the generic I2S audio
driver or a specific audio codec driver. Also, it's possible to use the
I2S character driver to bypass the audio subsystem and develop specific
usages of the I2S peripheral.

<div class="note">

<div class="title">

Note

</div>

Note that the bit-width and sample rate can be modified "on-the-go" when
using audio-related drivers. That is not the case for the I2S character
device driver and such parameters are set on compile time through
<span class="title-ref">make menuconfig</span>.

</div>

<div class="warning">

<div class="title">

Warning

</div>

Some upper driver implementations might not handle both transmission and
reception configured at the same time on the same peripheral.

</div>

Please check for usage examples using the
\[<span class="title-ref">ESP32 DevKitC \</platform\](\`ESP32 DevKitC
\</platform.md)s/xtensa/esp32/boards/esp32-devkitc/index\></span>.

## Analog-to-digital converter (ADC)

Two ADC units are available for the ESP32:

  - ADC1 with 8 channels
  - ADC2 with 10 channels

Those units are independent and can be used simultaneously. During
bringup, GPIOs for selected channels are configured automatically to be
used as ADC inputs. If available, ADC calibration is automatically
applied (see [this
page](https://docs.espressif.com/projects/esp-idf/en/v5.1/esp32/api-reference/peripherals/adc_calibration.html)
for more details). Otherwise, a simple conversion is applied based on
the attenuation and resolution.

Each ADC unit is accessible using the ADC character driver, which
returns data for the enabled channels.

The ADC unit can be enabled in the menu `System Type --> ESP32
Peripheral Selection --> Analog-to-digital converter (ADC)`.

Then, it can be customized in the menu `System Type --> ADC
Configuration`, which includes operating mode, gain and channels.

<table>
<thead>
<tr class="header">
<th>Channel</th>
<th>ADC1 GPIO</th>
<th>ADC2 GPIO</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>0</td>
<td><blockquote>
<p>36</p>
</blockquote></td>
<td><blockquote>
<p>4</p>
</blockquote></td>
</tr>
<tr class="even">
<td>1</td>
<td><blockquote>
<p>37</p>
</blockquote></td>
<td><blockquote>
<p>0</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>2</td>
<td><blockquote>
<p>38</p>
</blockquote></td>
<td><blockquote>
<p>2</p>
</blockquote></td>
</tr>
<tr class="even">
<td>3</td>
<td><blockquote>
<p>39</p>
</blockquote></td>
<td><blockquote>
<p>15</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>4</td>
<td><blockquote>
<p>32</p>
</blockquote></td>
<td><blockquote>
<p>13</p>
</blockquote></td>
</tr>
<tr class="even">
<td>5</td>
<td><blockquote>
<p>33</p>
</blockquote></td>
<td><blockquote>
<p>12</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>6</td>
<td><blockquote>
<p>34</p>
</blockquote></td>
<td><blockquote>
<p>14</p>
</blockquote></td>
</tr>
<tr class="even">
<td><p>7 8 9</p></td>
<td><blockquote>
<p>35</p>
</blockquote></td>
<td><blockquote>
<p>27 25 26</p>
</blockquote></td>
</tr>
</tbody>
</table>

<div class="warning">

<div class="title">

Warning

</div>

ADC2 channels 1, 2 and 3 are used as strapping pins and can present
undefined behavior.

</div>

## Using QEMU

Get or build QEMU from [here](https://github.com/espressif/qemu/wiki).

Enable the `ESP32_QEMU_IMAGE` config found in `Board Selection --> ESP32
binary image for QEMU`.

Build and generate the QEMU image:

     make bootloader
     make ESPTOOL_BINDIR=.

A QEMU-compatible `nuttx.merged.bin` binary image will be created. It
can be run as:

     qemu-system-xtensa -nographic -machine esp32 -drive file=nuttx.merged.bin,if=mtd,format=raw

QEMU for ESP32 does not correctly define the chip revision as v3.0 so
you have two options:

  - \#define `ESP32_IGNORE_CHIP_REVISION_CHECK` in
    `arch/xtensa/src/esp32/esp32_start.c`
  - Emulate the efuse as described
    [here](https://github.com/espressif/esp-toolchain-docs/blob/main/qemu/esp32/README.md#emulating-esp32-eco3).

### QEMU Networking

Networking is possible using the openeth MAC driver. Enable
`ESP32_OPENETH` option and set the nic in QEMU:

     qemu-system-xtensa -nographic -machine esp32 -drive file=nuttx.merged.bin,if=mtd,format=raw -nic user,model=open_eth

## Secure Boot and Flash Encryption

### Secure Boot

Secure Boot protects a device from running any unauthorized (i.e.,
unsigned) code by checking that each piece of software that is being
booted is signed. On an ESP32, these pieces of software include the
second stage bootloader and each application binary. Note that the first
stage bootloader does not require signing as it is ROM code thus cannot
be changed. This is achieved using specific hardware in conjunction with
MCUboot (read more about MCUboot [here](https://docs.mcuboot.com/)).

The Secure Boot process on the ESP32 involves the following steps
performed:

1.  The first stage bootloader verifies the second stage bootloader's
    RSA-PSS signature. If the verification is successful, the first
    stage bootloader loads and executes the second stage bootloader.
2.  When the second stage bootloader loads a particular application
    image, the application's signature (RSA, ECDSA or ED25519) is
    verified by MCUboot. If the verification is successful, the
    application image is executed.

<div class="warning">

<div class="title">

Warning

</div>

Once enabled, Secure Boot will not boot a modified bootloader. The
bootloader will only boot an application firmware image if it has a
verified digital signature. There are implications for reflashing
updated images once Secure Boot is enabled. You can find more
information about the ESP32's Secure boot
[here](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/security/secure-boot-v2.html).

</div>

<div class="note">

<div class="title">

Note

</div>

As the bootloader image is built on top of the Hardware Abstraction
Layer component of [ESP-IDF](https://github.com/espressif/esp-idf), the
[API port by Espressif](https://docs.mcuboot.com/readme-espressif.html)
will be used by MCUboot rather than the original NuttX port.

</div>

### Flash Encryption

Flash encryption is intended for encrypting the contents of the ESP32's
off-chip flash memory. Once this feature is enabled, firmware is flashed
as plaintext, and then the data is encrypted in place on the first boot.
As a result, physical readout of flash will not be sufficient to recover
most flash contents.

<div class="warning">

<div class="title">

Warning

</div>

After enabling Flash Encryption, an encryption key is generated
internally by the device and cannot be accessed by the user for
re-encrypting data and re-flashing the system, hence it will be
permanently encrypted. Re-flashing an encrypted system is complicated
and not always possible. You can find more information about the ESP32's
Flash Encryption
[here](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/security/flash-encryption.html).

</div>

### Prerequisites

First of all, we need to install `imgtool` (a MCUboot utility
application to manipulate binary images) and `esptool` (the ESP32
toolkit):

     pip install imgtool esptool==4.8.dev4

We also need to make sure that the python modules are added to `PATH`:

     echo "PATH=PATH:/home/USER/.local/bin" >> ~/.bashrc

Now, we will create a folder to store the generated keys (such as
`~/signing_keys`):

     mkdir ~/signing_keys && cd ~/signing_keys

With all set up, we can now generate keys to sign the bootloader and
application binary images, respectively, of the compiled project:

     espsecure.py generate_signing_key --version 2 bootloader_signing_key.pem
     imgtool keygen --key app_signing_key.pem --type rsa-3072

<div class="important">

<div class="title">

Important

</div>

The contents of the key files must be stored securely and kept secret.

</div>

### Enabling Secure Boot and Flash Encryption

To enable Secure Boot for the current project, go to the project's NuttX
directory, execute `make menuconfig` and the following steps:

> 1.  Enable experimental features in `Build Setup --> Show experimental
>     options`;
> 2.  Enable MCUboot in `Application Configuration --> Bootloader
>     Utilities --> MCUboot`;
> 3.  Change image type to `MCUboot-bootable format` in `System Type -->
>     Application Image Configuration --> Application Image Format`;
> 4.  Enable building MCUboot from the source code by selecting `Build
>     binaries from source`; in `System Type --> Application Image
>     Configuration --> Source for bootloader binaries`;
> 5.  Enable Secure Boot in `System Type --> Application Image
>     Configuration --> Enable hardware Secure Boot in bootloader`;
> 6.  If you want to protect the SPI Bus against data sniffing, you can
>     enable Flash Encryption in `System Type --> Application Image
>     Configuration --> Enable Flash Encryption on boot`.

Now you can design an update and confirm agent to your application.
Check the [MCUboot design guide](https://docs.mcuboot.com/design.html)
and the [MCUboot Espressif port
documentation](https://docs.mcuboot.com/readme-espressif.html) for more
information on how to apply MCUboot. Also check some [notes about the
NuttX MCUboot
port](https://github.com/mcu-tools/mcuboot/blob/main/docs/readme-nuttx.md),
the [MCUboot porting
guide](https://github.com/mcu-tools/mcuboot/blob/main/docs/PORTING.md)
and some [examples of MCUboot applied in NuttX
applications](https://github.com/apache/nuttx-apps/tree/master/examples/mcuboot).

After you developed an application which implements all desired
functions, you need to flash it into the primary image slot of the
device (it will automatically be in the confirmed state, you can learn
more about image confirmation
[here](https://docs.mcuboot.com/design.html#image-swapping)). To flash
to the primary image slot, select `Application image primary slot` in
`System Type --> Application Image Configuration --> Target slot for
image flashing` and compile it using `make -j
ESPSEC_KEYDIR=~/signing_keys`.

When creating update images, make sure to change `System Type -->
Application Image Configuration --> Target slot for image flashing` to
`Application image secondary slot`.

<div class="important">

<div class="title">

Important

</div>

When deploying your application, make sure to disable UART Download Mode
by selecting `Permanently disabled` in `System Type --> Application
Image Configuration --> UART ROM download mode` and change usage mode to
`Release` in <span class="title-ref">System Type --\> Application Image
Configuration --\> Enable usage mode</span>. **After disabling UART
Download Mode you will not be able to flash other images through UART.**

</div>

## Things to Do

1.  Lazy co-processor save logic supported by Xtensa. That logic works
    like this:
    
    1.  CPENABLE is set to zero on each context switch, disabling all
        co-processors.
    2.  If/when the task attempts to use the disabled co-processor, an
        exception occurs
    3.  The co-processor exception handler re-enables the co-processor.
    
    Instead, the NuttX logic saves and restores CPENABLE on each context
    switch. This has disadvantages in that (1) co-processor context will
    be saved and restored even if the co-processor was never used, and
    (2) tasks must explicitly enable and disable co-processors.

2.  Currently the Xtensa port copies register state save information
    from the stack into the TCB. A more efficient alternative would be
    to just save a pointer to a register state save area in the TCB.
    This would add some complexity to signal handling and also to
    up\_initialstate(). But the performance improvement might be worth
    the effort.

3.  See SMP-related issues above

## \_<span class="title-ref">Managing esptool on virtual environment</span>

This section describes how to install `esptool`, `imgtool` or any other
Python packages in a proper environment.

Normally, a Linux-based OS would already have Python 3 installed by
default. Up to a few years ago, you could simply call `pip install` to
install packages globally. However, this is no longer recommended as it
can lead to conflicts between packages and versions. The recommended way
to install Python packages is to use a virtual environment.

A virtual environment is a self-contained directory that contains a
Python installation for a particular version of Python, plus a number of
additional packages. You can create a virtual environment for each
project you are working on, and install the required packages in that
environment.

Two alternatives are explained below, you can select any one of those.

### Using pipx (recommended)

`pipx` is a tool that makes it easy to install Python packages in a
virtual environment. To install `pipx`, you can run the following
command (using apt as example):

     apt install pipx

Once you have installed `pipx`, you can use it to install Python
packages in a virtual environment. For example, to install the `esptool`
package, you can run the following command:

     pipx install esptool

This will create a new virtual environment in the `~/.local/pipx/venvs`
directory, which contains the `esptool` package. You can now use the
`esptool` command as normal, and so will the build system.

Make sure to run `pipx ensurepath` to add the `~/.local/bin` directory
to your `PATH`. This will allow you to run the `esptool` command from
any directory.

### Using venv (alternative)

To create a virtual environment, you can use the `venv` module, which is
included in the Python standard library. To create a virtual
environment, you can run the following command:

     python3 -m venv myenv

This will create a new directory called `myenv` in the current
directory, which contains a Python installation and a copy of the Python
standard library. To activate the virtual environment, you can run the
following command:

     source myenv/bin/activate

This will change your shell prompt to indicate that you are now working
in the virtual environment. You can now install packages using `pip`.
For example, to install the `esptool` package, you can run the following
command:

     pip install esptool

This will install the `esptool` package in the virtual environment. You
can now use the `esptool` command as normal. When you are finished
working in the virtual environment, you can deactivate it by running the
following command:

     deactivate

This will return your shell prompt to its normal state. You can
reactivate the virtual environment at any time by running the `source
myenv/bin/activate` command again. You can also delete the virtual
environment by deleting the directory that contains it.

## Supported Boards

> boards/*/*
