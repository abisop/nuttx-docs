MPS2 AN521 Board
================

This board configuration will use QEMU to emulate generic ARM v8-M
series hardware platform and provides support for these devices:

-   ARM Generic Timer
-   CMSDK UART controller

Getting Started
---------------

1.  Configuring NuttX and compile (Single Core):

         ./tools/configure.sh -l mps2-an521:nsh
         make

Running with qemu:

     qemu-system-arm -M mps2-an521 -nographic -chardev stdio,id=con,mux=on \
    -serial chardev:con -mon chardev=con,mode=readline -kernel ./nuttx

Debugging with QEMU
-------------------

The nuttx ELF image can be debugged with QEMU.

1.  To debug the nuttx (ELF) with symbols, make sure the following
    change have applied to defconfig:

        CONFIG_DEBUG_SYMBOLS=y

2.  Run QEMU (at shell terminal 1):

        qemu-system-arm -M mps2-an521 -nographic -chardev stdio,id=con,mux=on \
        -serial chardev:con -mon chardev=con,mode=readline -kernel ./nuttx -S -s

3.  Run gdb with TUI, connect to QEMU, load nuttx and continue (at shell
    terminal 2):

         arm-none-eabi-gdb -tui --eval-command='target remote localhost:1234' nuttx
