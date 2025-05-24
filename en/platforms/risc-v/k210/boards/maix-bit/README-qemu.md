1.  Download and install toolchain

\$ curl
https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86\_64-linux-ubuntu14.tar.gz

2.  Build and install qemu

\$ git clone https://github.com/qemu/qemu \$ cd qemu \$ ./configure
--target-list=riscv64-softmmu \$ make \$ sudo make install

3.  Modify defconfig

--- a/boards/risc-v/k210/maix-bit/configs/nsh/defconfig +++
b/boards/risc-v/k210/maix-bit/configs/nsh/defconfig @@ -25,6 +25,7 @@
CONFIG\_EXAMPLES\_HELLO=y CONFIG\_FS\_PROCFS=y
CONFIG\_IDLETHREAD\_STACKSIZE=2048 CONFIG\_INTELHEX\_BINARY=y
+CONFIG\_K210\_WITH\_QEMU=y CONFIG\_LIBC\_PERROR\_STDOUT=y
CONFIG\_LIBC\_STRERROR=y

4.  Configure and build NuttX

\$ mkdir ./nuttx; cd ./nuttx \$ git clone
https://github.com/apache/nuttx.git nuttx \$ git clone
https://github.com/apache/nuttx-apps.git apps \$ cd nuttx \$ make
distclean \$ ./tools/configure.sh maix-bit:nsh \$ make V=1

5.  Run the nuttx with qemu

\$ qemu-system-riscv64 -nographic -machine sifive\_u -bios ./nuttx

NOTE: To run nuttx for kostest, gdb needs to be used to load both
nuttx\_user.elf and nuttx

\$ qemu-system-riscv64 -nographic -machine sifive\_u -s -S \$
riscv64-unknown-elf-gdb -ex 'target extended-remote:1234' -ex 'load
nuttx\_user.elf' -ex 'load nuttx' -ex 'c'

6.  TODO

Support FPU Support RISC-V User mode
