Segger RTT drivers
==================

Note

Segger drivers works only with J-Link debug probes. Sometimes it\'s
possible to replace vendor-specific debug interface with J-Link OB
firmware. For details look at [Segger
website](https://www.segger.com/downloads/jlink)

Supported Segger drivers:

-   Serial over RTT - `CONFIG_SERIAL_RTTx`,
-   Console over RTT - `CONFIG_SERIAL_RTT_CONSOLE_CHANNEL`
-   Segger SystemView - `CONFIG_SEGGER_SYSVIEW`
-   Note RTT - `CONFIG_NOTE_RTT`

Segger SystemView
-----------------

1.  Steps to enable SystemView support:

2.  Make sure your architecture supports a high-performance counter. In
    most cases it will be:

    `CONFIG_ARCH_PERF_EVENTS=y`{.interpreted-text role="menuselection"}

    In that case, the the architecture logic must initialize the perf
    counter with `up_perf_init()`.

3.  Enable instrumentation support:

    `CONFIG_SCHED_INSTRUMENTATION=y`{.interpreted-text
    role="menuselection"}

4.  Configure instrumentation support. Available options for SystemView
    are:

    `CONFIG_SCHED_INSTRUMENTATION_SWITCH=y`{.interpreted-text
    role="menuselection"}

    `CONFIG_SCHED_INSTRUMENTATION_SYSCALL=y`{.interpreted-text
    role="menuselection"}

    `CONFIG_SCHED_INSTRUMENTATION_IRQHANDLER=y`{.interpreted-text
    role="menuselection"}

5.  Make sure that `CONFIG_TASK_NAME_SIZE > 0`, otherwise task/thread
    names will not be displayed correctly

6.  Enable Note Driver support and disable Note RAM driver:

    `CONFIG_DRIVERS_NOTE=y`{.interpreted-text role="menuselection"}

    `CONFIG_DRIVERS_NOTERAM=n`{.interpreted-text role="menuselection"}

7.  Enable Note RTT and Segger SystemView support:

    `CONFIG_NOTE_RTT=y`{.interpreted-text role="menuselection"}

    `CONFIG_SEGGER_SYSVIEW=y`{.interpreted-text role="menuselection"}

8.  Configure RTT channel and RTT buffer size for SystemView:

    `CONFIG_SEGGER_SYSVIEW_RTT_CHANNEL=0`{.interpreted-text
    role="menuselection"}

    `CONFIG_SEGGER_SYSVIEW_RTT_BUFFER_SIZE=1024`{.interpreted-text
    role="menuselection"}

    In case SystemView returns buffer overflow errors, you should
    increase `CONFIG_NOTE_RTT_BUFFER_SIZE_UP`.

9.  Use SystemView for heap tracing:

Refer to example configuration at `stm32f429i-disco/configs/systemview`.
Make sure that `CONFIG_SCHED_INSTRUMENTATION_HEAP` is enabled.

Example of screenshot from SystemView:

![image](sysview.png){.align-center width="800px"}
