Events
======

Events groups are synchronization primitives that allow tasks to wait
for multiple conditions to be met before proceeding. They are
particularly useful in scenarios where a task needs to wait for several
events to occur simultaneously. This concept can be particularly
powerful in real-time operating systems (RTOS).

Overview
--------

An event group consists of a set of binary flags, each representing a
specific event. Tasks can set, clear, and wait on these flags. When a
task waits on an event group, it can specify which flags it is
interested in and whether it wants to wait for all specified flags to be
set or just any one of them.

Configuration Options
---------------------

`CONFIG_SCHED_EVENTS`

:   This option enables event objects. Threads may wait on event objects
    for specific events, but both threads and ISRs may deliver events to
    event objects.

Common Events Interfaces
------------------------

### Events Types

-   `nxevent_t`. Defines one event group entry.
-   `nxevent_mask_t`. Defines one events mask value.

### Notifier Chain Interfaces
