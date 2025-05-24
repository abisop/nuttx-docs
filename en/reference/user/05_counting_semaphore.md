Counting Semaphore Interfaces
=============================

**Semaphores**. Semaphores are the basis for synchronization and mutual
exclusion in NuttX. NuttX supports POSIX semaphores.

Semaphores are the preferred mechanism for gaining exclusive access to a
resource. sched\_lock() and sched\_unlock() can also be used for this
purpose. However, sched\_lock() and sched\_unlock() have other
undesirable side-effects in the operation of the system: sched\_lock()
also prevents higher-priority tasks from running that do not depend upon
the semaphore-managed resource and, as a result, can adversely affect
system response times.

Priority Inversion. Proper use of semaphores avoids the issues of
`sched_lock()`. However, consider the following example:

> 1.  Some low-priority task, *Task C*, acquires a semaphore in order to
>     get exclusive access to a protected resource.
> 2.  *Task C* is suspended to allow some high-priority task,
> 3.  *Task A* attempts to acquire the semaphore held by *Task C* and
>     gets blocked until *Task C* relinquishes the semaphore.
> 4.  *Task C* is allowed to execute again, but gets suspended by some
>     medium-priority *Task B*.

At this point, the high-priority *Task A* cannot execute until *Task B*
(and possibly other medium-priority tasks) completes and until *Task C*
relinquishes the semaphore. In effect, the high-priority task, *Task A*
behaves as though it were lower in priority than the low-priority task,
*Task C*! This phenomenon is called *priority inversion*.

Some operating systems avoid priority inversion by *automatically*
increasing the priority of the low-priority *Task C* (the operable
buzz-word for this behavior is *priority inheritance*). NuttX supports
this behavior, but only if `CONFIG_PRIORITY_INHERITANCE` is defined in
your OS configuration file. If `CONFIG_PRIORITY_INHERITANCE` is not
defined, then it is left to the designer to provide implementations that
will not suffer from priority inversion. The designer may, as examples:

> -   Implement all tasks that need the semaphore-managed resources at
>     the same priority level,
> -   Boost the priority of the low-priority task before the semaphore
>     is acquired, or
> -   Use sched\_lock() in the low-priority task.

Priority Inheritance. As mentioned, NuttX does support *priority
inheritance* provided that `CONFIG_PRIORITY_INHERITANCE` is defined in
your OS configuration file. However, the implementation and
configuration of the priority inheritance feature is sufficiently
complex that more needs to be said. How can a feature that can be
described by a single, simple sentence require such a complex
implementation:

> -   `CONFIG_SEM_PREALLOCHOLDERS`. First of all, in NuttX priority
>     inheritance is implement on POSIX counting semaphores. The reason
>     for this is that these semaphores are the most primitive waiting
>     mechanism in NuttX; Most other waiting facilities are based on
>     semaphores. So if priority inheritance is implemented for POSIX
>     counting semaphores, then most NuttX waiting mechanisms will have
>     this capability.
>
>     Complexity arises because counting semaphores can have numerous
>     holders of semaphore counts. Therefore, in order to implement
>     priority inheritance across all holders, then internal data
>     structures must be allocated to manage the various holders
>     associated with a semaphore. The setting
>     `CONFIG_SEM_PREALLOCHOLDERS` defines the maximum number of
>     different threads (minus one per semaphore instance) that can take
>     counts on a semaphore with priority inheritance support. This
>     setting defines the size of a single pool of pre-allocated
>     structures. It may be set to zero if priority inheritance is
>     disabled OR if you are only using semaphores as mutexes (only one
>     holder) OR if no more than two threads participate using a
>     counting semaphore.
>
>     The cost associated with setting `CONFIG_SEM_PREALLOCHOLDERS` is
>     slightly increased code size and around 6-12 bytes times the value
>     of `CONFIG_SEM_PREALLOCHOLDERS`.
>
> -   **Increased Susceptibility to Bad Thread Behavior**. These various
>     structures tie the semaphore implementation more tightly to the
>     behavior of the implementation. For examples, if a thread executes
>     while holding counts on a semaphore, or if a thread exits without
>     call `sem_destroy()` then. Or what if the thread with the boosted
>     priority re-prioritizes itself? The NuttX implement of priority
>     inheritance attempts to handle all of these types of corner cases,
>     but it is very likely that some are missed. The worst case result
>     is that memory could by stranded within the priority inheritance
>     logic.

Locking versus Signaling Semaphores. Semaphores (and mutexes) may be
used for many different purposes. One typical use is for mutual
exclusion and locking of resources: In this usage, the thread that needs
exclusive access to a resources takes the semaphore to get access to the
resource. The same thread subsequently releases the semaphore count when
it no longer needs exclusive access. Priority inheritance is intended
just for this usage case.

In a different usage case, a semaphore may to be used to signal an
event: One thread A waits on a semaphore for an event to occur. When the
event occurs, another thread B will post the semaphore waking the
waiting thread A. This is a completely different usage model; notice
that in the mutual exclusion case, the same thread takes and posts the
semaphore. In the signaling case, one thread takes the semaphore and a
different thread posts the semaphore. Priority inheritance should
*never* be used in this signaling case. Subtle, strange behaviors may
result.

Semaphore does not support priority inheritance by default. If you need
to use a semaphore as a mutex you need to change its default behavior.

In user space, it is recommended to use pthread\_mutex instead of
semaphore for resource protection

When priority inheritance is enabled with `CONFIG_PRIORITY_INHERITANCE`,
the default *protocol* for the semaphore will be to use priority
inheritance. For signaling semaphores, priority inheritance must be
explicitly disabled by calling `` `sem_setprotocol ``
\<\#semsetprotocol\>[\_\_ with
]{.title-ref}[SEM\_PRIO\_NONE]{.title-ref}[. For the case of pthread
mutexes, ]{.title-ref}`pthread_mutexattr_setprotocol`
\<\#pthreadmutexattrsetprotocol\>[\_\_ with
]{.title-ref}[PTHREAD\_PRIO\_NONE]{.title-ref}\`.

This is discussed in much more detail on this [Wiki
page](https://cwiki.apache.org/confluence/display/NUTTX/Signaling+Semaphores+and+Priority+Inheritance).

**POSIX semaphore interfaces:**

-   :c`sem_init`{.interpreted-text role="func"}
-   :c`sem_destroy`{.interpreted-text role="func"}
-   :c`sem_open`{.interpreted-text role="func"}
-   :c`sem_close`{.interpreted-text role="func"}
-   :c`sem_unlink`{.interpreted-text role="func"}
-   :c`sem_wait`{.interpreted-text role="func"}
-   :c`sem_timedwait`{.interpreted-text role="func"}
-   :c`sem_trywait`{.interpreted-text role="func"}
-   :c`sem_post`{.interpreted-text role="func"}
-   :c`sem_getvalue`{.interpreted-text role="func"}
-   :c`sem_getprotocol`{.interpreted-text role="func"}
-   :c`sem_setprotocol`{.interpreted-text role="func"}
