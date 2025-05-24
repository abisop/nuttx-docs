Task Scheduling Interfaces
==========================

By default, NuttX performs strict priority scheduling: Tasks of higher
priority have exclusive access to the CPU until they become blocked. At
that time, the CPU is available to tasks of lower priority. Tasks of
equal priority are scheduled FIFO.

Optionally, a NuttX task or thread can be configured with round-robin or
*sporadic* scheduler. The round-robin is similar to priority scheduling
*except* that tasks with equal priority and share CPU time via
*time-slicing*. The time-slice interval is a constant determined by the
configuration setting `CONFIG_RR_INTERVAL` to a positive, non-zero
value. Sporadic scheduling scheduling is more complex, varying the
priority of a thread over a *replenishment* period. Support for sporadic
scheduling is enabled by the configuration option
`CONFIG_SCHED_SPORADIC`.

The OS interfaces described in the following paragraphs provide a
POSIX-compliant interface to the NuttX scheduler:

> -   :c`sched_setparam`{.interpreted-text role="func"}
> -   :c`sched_getparam`{.interpreted-text role="func"}
> -   :c`sched_setscheduler`{.interpreted-text role="func"}
> -   :c`sched_getscheduler`{.interpreted-text role="func"}
> -   :c`sched_yield`{.interpreted-text role="func"}
> -   :c`sched_get_priority_max`{.interpreted-text role="func"}
> -   :c`sched_get_priority_min`{.interpreted-text role="func"}
> -   :c`sched_rr_get_interval`{.interpreted-text role="func"}

Functions
---------
