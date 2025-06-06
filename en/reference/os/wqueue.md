Work Queues
===========

**Work Queues**. NuttX provides *work queues*. Work queues are threads
that service a queue of work items to be performed. They are useful for
off-loading work to a different threading context, for delayed
processing, or for serializing activities.

Classes of Work Queues
----------------------

There are three different classes of work queues, each with different
properties and intended usage. These classes of work queues along with
the common work queue interface are described in the following
paragraphs.

### High Priority Kernel Work queue

The dedicated high-priority work queue is intended to handle delayed
processing from interrupt handlers. This work queue is required for some
drivers but, if there are no complaints, can be safely disabled. The
high priority worker thread also performs garbage collection \--
completing any delayed memory deallocations from interrupt handlers. If
the high-priority worker thread is disabled, then that clean up will be
performed either by (1) the low-priority worker thread, if enabled, and
if not (2) the IDLE thread instead (which runs at the lowest of priority
and may not be appropriate if memory reclamation is of high priority)

**Device Driver Bottom Half**. The high-priority worker thread is
intended to serve as the *bottom half* for device drivers. As a
consequence it must run at a very high, fixed priority rivalling the
priority of the interrupt handler itself. Typically, the high priority
work queue should be the highest priority thread in your system (the
default priority is 224).

**Thread Pool**. The work queues can be configured to support multiple,
low-priority threads. This is essentially a *thread pool* that provides
multi-threaded servicing of the queue work. This breaks the strict
serialization of the \"queue\" (and hence, the work queue is no longer a
queue at all).

Multiple worker threads are required to support, for example, I/O
operations that stall waiting for input. If there is only a single
thread, then the entire work queue processing would stall in such cases.
Such behavior is necessary to support asynchronous I/O, AIO, for
example.

**Compared to the Low Priority Kernel Work Queue**. For less critical,
lower priority, application oriented worker thread support, consider
enabling the lower priority work queue. The lower priority work queue
runs at a lower priority, of course, but has the added advantage that it
supports *priority inheritance* (if `CONFIG_PRIORITY_INHERITANCE=y` is
also selected): The priority of the lower priority worker thread can
then be adjusted to match the highest priority client.

**Configuration Options**.

-   `CONFIG_SCHED_HPWORK`. Enables the high priority work queue.
-   `CONFIG_SCHED_HPNTHREADS`. The number of threads in the
    high-priority queue\'s thread pool. Default: 1
-   `CONFIG_SCHED_HPWORKPRIORITY`. The execution priority of the
    high-priority worker thread. Default: 224
-   `CONFIG_SCHED_HPWORKSTACKSIZE`. The stack size allocated for the
    worker thread in bytes. Default: 2048.

### Low Priority Kernel Work Queue

This lower priority work queue is better suited for more extended,
application oriented processing such as file system clean-up, memory
garbage collection and asynchronous I/O operations.

**Compared to the High Priority Work Queue**. The lower priority work
queue runs at a lower priority than the high priority work queue, of
course, and so is inappropriate to serve as a driver *bottom half*. It
is, otherwise, very similar to the high priority work queue and most of
the discussion above for the high priority work queue applies equally
here. The lower priority work queue does have one important property,
however, that makes it better suited for some tasks:

**Priority Inheritance**. The lower priority worker thread(s) support
*priority inheritance* (if \<config\> CONFIG\_PRIORITY\_INHERITANCE is
also selected): The priority of the lower priority worker thread can
then be adjusted to match the highest priority client.

> **NOTE:** This priority inheritance feature is not automatic. The
> lower priority worker thread will always have a fixed priority unless
> additional logic calls `lpwork_boostpriority()` to raise the priority
> of the lower priority worker thread (typically called before
> scheduling the work) and then calls the matching
> `lpwork_restorepriority()` when the work is completed (typically
> called within the work handler at the completion of the work).
> Currently, only the NuttX asynchronous I/O logic uses this dynamic
> prioritization feature.

The higher priority worker thread, on the other hand, is intended to
serve as the *bottom half* for device drivers. As a consequence must run
at a very high, fixed priority. Typically, it should be the highest
priority thread in your system.

**Configuration Options**.

-   `CONFIG_SCHED_LPWORK`. If CONFIG\_SCHED\_LPWORK is selected then a
    lower-priority work queue will be enabled.
-   `CONFIG_SCHED_LPNTHREADS`. The number of threads in the low-priority
    queue\'s thread pool. Default: 1
-   `CONFIG_SCHED_LPWORKPRIORITY`. The minimum execution priority of the
    lower priority worker thread. The priority of the all worker threads
    start at this priority. If priority inheritance is in effect, the
    priority may be boosted from this level. Default: 50.
-   `CONFIG_SCHED_LPWORKPRIOMAX`. The maximum execution priority of the
    lower priority worker thread. Lower priority worker threads will be
    started at `CONFIG_SCHED_LPWORKPRIORITY` but their priority may be
    boosted due to priority inheritance. The boosted priority of the low
    priority worker thread will not, however, ever exceed
    `CONFIG_SCHED_LPWORKPRIOMAX`. This limit would be necessary, for
    example, if the higher priority worker thread were to defer work to
    the lower priority thread. Clearly, in such a case, you would want
    to limit the maximum priority of the lower priority work thread.
    Default: 176.
-   `CONFIG_SCHED_LPWORKSTACKSIZE`. The stack size allocated for the
    lower priority worker thread. Default: 2048.

### User-Mode Work Queue

**Work Queue Accessibility**. The high- and low-priority worker threads
are kernel-mode threads. In the normal, *flat* NuttX build, these work
queues are useful to application code and may be shared. However, in the
NuttX protected and kernel build modes, kernel mode code is isolated and
cannot be accessed from user-mode code.

**User-Mode Work Queue**. if either `CONFIG_BUILD_PROTECTED` or
`CONFIG_BUILD_KERNEL` are selected, then the option to enable a special
user-mode work queue is enabled. The interface to the user-mode work
queue is identical to that of the kernel-mode work queues and the
user-mode work queue is functionally equivalent to the high priority
work queue. It differs in that its implementation does not depend on
internal, kernel-space facilities.

**Configuration Options**.

-   `CONFIG_LIBC_USRWORK`. If CONFIG\_LIBC\_USRWORK is also defined then
    the user-mode work queue will be enabled.
-   `CONFIG_LIBC_USRWORKPRIORITY`. The execution priority of the
    user-mode priority worker thread. Default: 100
-   `CONFIG_LIBC_USRWORKSTACKSIZE`. The stack size allocated for the
    lower priority worker thread. Default: 2048.

Common Work Queue Interfaces
----------------------------

### Work Queue IDs

**Work queue IDs**. All work queues use the identical interface
functions (at least identical in terms of the function *signature*). The
first parameter passed to the work queue interface function identifies
the work queue:

**Kernel-Mode Work Queue IDs:**

-   `HPWORK`. This ID of the high priority work queue that should only
    be used for high-priority, time-critical, driver bottom-half
    functions.
-   `LPWORK`. This is the ID of the low priority work queue that can be
    used for any purpose. If `CONFIG_SCHED_LPWORK` is not defined, then
    there is only one kernel work queue and `LPWORK` is equal to
    `HPWORK`.

**User-Mode Work Queue IDs:**

-   `USRWORK`. This is the ID of the user-mode work queue that can be
    used for any purpose by applications. In a flat build, `USRWORK` is
    equal to `LPWORK` so that user applications will use the lower
    priority work queue (if there is one).

### Work Queue Interface Types

-   `typedef void (*worker_t)(FAR void *arg);` Defines the type of the
    work callback.
-   `struct work_s`. Defines one entry in the work queue. This is a
    client-allocated structure. Work queue clients should not reference
    any field in this structure since they are subject to change. The
    user only needs this structure in order to declare instances of the
    work structure. Handling of all fields is performed by the work
    queue interfaces described below.

### Work Queue Interfaces
