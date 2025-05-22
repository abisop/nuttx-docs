Symmetric Multiprocessing (SMP) Application
===========================================

According to Wikipedia: \"Symmetric multiprocessing (SMP) involves a
symmetric multiprocessor system hardware and software architecture where
two or more identical processors connect to a single, shared main
memory, have full access to all I/O devices, and are controlled by a
single operating system instance that treats all processors equally,
reserving none for special purposes. Most multiprocessor systems today
use an SMP architecture. In the case of multi-core processors, the SMP
architecture applies to the cores, treating them as separate processors.

\"SMP systems are tightly coupled multiprocessor systems with a pool of
homogeneous processors running independently, each processor executing
different programs and working on different data and with capability of
sharing common resources (memory, I/O device, interrupt system and so
on) and connected using a system bus or a crossbar.\"

For a technical description of the NuttX implementation of SMP, see the
NuttX [SMP Wiki
Page](https://cwiki.apache.org/confluence/display/NUTTX/SMP).
