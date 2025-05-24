The list of related kernel configurations
=========================================

The premise of this list : NuttX12.4.0, cxd56xx, non-SMP and Flat build.

I found following kernel configurations by analyzing the boot sequence.
I think it is good to consider them, although almost of them might be
set as default.

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Category \| Item \| Comment \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Memory Map \| CONFIG\_RAM\_START \|
[arch/Kconfig](https://github.com/apache/nuttx/blob/master/arch/Kconfig)
\| + +\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +
\| \| CONFIG\_RAM\_SIZE \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| \| CONFIG\_IDLETHREAD\_STACKSIZE \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| \| CONFIG\_MM\_REGIONS \|
[mm/Kconfig](https://github.com/apache/nuttx/blob/master/mm/Kconfig) \|
+
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| \| CONFIG\_ARCH\_HAVE\_EXTRA\_HEAPS \|
[arch/Kconfig](https://github.com/apache/nuttx/blob/master/arch/Kconfig)
\|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Interrupt \| CONFIG\_ARCH\_RAMVECTORS \|
[arch/Kconfig](https://github.com/apache/nuttx/blob/master/arch/Kconfig)
\| + +\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +
\| \| CONFIG\_ARCH\_IRQPRIO \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_ARCH\_INTERRUPTSTACK \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_SUPPRESS\_INTERRUPTS \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_SUPPRESS\_TIMER\_INTS \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| \| CONFIG\_IRQCHAIN \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Timer \| CONFIG\_SYSTEMTICK\_EXTCLK \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\| + +\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +
\| \| CONFIG\_SCHED\_TICKLESS \| \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Serial \| CONFIG\_STANDARD\_SERIAL \|
[serial/Kconfig](https://github.com/apache/nuttx/blob/master/drivers/serial/Kconfig)\|
+
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| \| CONFIG\_DEV\_CONSOLE \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| Board \| CONFIG\_BOARD\_EARLY\_INITIALIZE \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\| + +\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +
\| \| CONFIG\_BOARD\_LATE\_INITIALIZE \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_INIT\_ENTRYPOINT \| \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| POSIX API \| CONFIG\_PRIORITY\_INHERITANCE \|
[sched/Kconfig](https://github.com/apache/nuttx/blob/master/sched/Kconfig)
\| + +\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +
\| \| CONFIG\_SEM\_PREALLOCHOLDERS \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_DISABLE\_MQUEUE \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_DISABLE\_MQUEUE\_SYSV \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_PREALLOC\_MQ\_MSGS \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_PREALLOC\_MQ\_IRQ\_MSGS \| \| +
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ + \| \|
CONFIG\_MQ\_MAXMSGSIZE \| \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
