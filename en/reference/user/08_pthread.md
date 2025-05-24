Pthread Interfaces
==================

NuttX does not support *processes* in the way that, say, Linux does.
NuttX only supports simple threads or tasks running within the same
address space. However, NuttX does support the concept of a *task
group*. A task group is the functional analog of a process: It is a
group that consists of the main task thread and of all of the pthreads
created by the main thread or any of the other pthreads within the task
group. Members of a task group share certain resources such as
environment variables, file descriptors, `FILE` streams, sockets,
pthread keys and open message queues.

Note

Behavior of features related to task groups depend of NuttX
configuration settings. See also the[NuttX
Tasking](https://cwiki.apache.org/confluence/display/NUTTX/NuttX+Tasking)page
and the[Tasks vs. Threads
FAQ](https://cwiki.apache.org/confluence/display/NUTTX/Tasks+vs.+Threads+FAQ)for
additional information on tasks and threads in NuttX.

The following pthread interfaces are supported in some form by NuttX:

**pthread control interfaces**. Interfaces that allow you to create and
manage pthreads.

> -   :c`pthread_attr_init`{.interpreted-text role="func"}
> -   :c`pthread_attr_destroy`{.interpreted-text role="func"}
> -   :c`pthread_attr_setschedpolicy`{.interpreted-text role="func"}
> -   :c`pthread_attr_getschedpolicy`{.interpreted-text role="func"}
> -   :c`pthread_attr_setschedparam`{.interpreted-text role="func"}
> -   :c`pthread_attr_getschedparam`{.interpreted-text role="func"}
> -   :c`pthread_attr_setinheritsched`{.interpreted-text role="func"}
> -   :c`pthread_attr_getinheritsched`{.interpreted-text role="func"}
> -   :c`pthread_attr_setstacksize`{.interpreted-text role="func"}
> -   :c`pthread_attr_getstacksize`{.interpreted-text role="func"}
> -   :c`pthread_create`{.interpreted-text role="func"}
> -   :c`pthread_detach`{.interpreted-text role="func"}
> -   :c`pthread_exit`{.interpreted-text role="func"}
> -   :c`pthread_cancel`{.interpreted-text role="func"}
> -   :c`pthread_setcancelstate`{.interpreted-text role="func"}
> -   :c`pthread_setcanceltype`{.interpreted-text role="func"}
> -   :c`pthread_testcancel`{.interpreted-text role="func"}
> -   :c`pthread_cleanup_pop`{.interpreted-text role="func"}
> -   :c`pthread_cleanup_push`{.interpreted-text role="func"}
> -   :c`pthread_join`{.interpreted-text role="func"}
> -   :c`pthread_yield`{.interpreted-text role="func"}
> -   :c`pthread_self`{.interpreted-text role="func"}
> -   :c`pthread_getschedparam`{.interpreted-text role="func"}
> -   :c`pthread_setschedparam`{.interpreted-text role="func"}

**Thread Specific Data**. These interfaces can be used to create pthread
*keys* and then to access thread-specific data using these keys. Each
*task group* has its own set of pthread keys. NOTES: (1) pthread keys
create in one *task group* are not accessible in other task groups. (2)
The main task thread does not have thread-specific data.

> -   :c`pthread_key_create`{.interpreted-text role="func"}
> -   :c`pthread_setspecific`{.interpreted-text role="func"}
> -   :c`pthread_getspecific`{.interpreted-text role="func"}
> -   :c`pthread_key_delete`{.interpreted-text role="func"}

**pthread Mutexes**.

> -   :c`pthread_mutexattr_init`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_destroy`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_getpshared`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_setpshared`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_gettype`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_settype`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_getprotocol`{.interpreted-text role="func"}
> -   :c`pthread_mutexattr_setprotocol`{.interpreted-text role="func"}
> -   :c`pthread_mutex_init`{.interpreted-text role="func"}
> -   :c`pthread_mutex_destroy`{.interpreted-text role="func"}
> -   :c`pthread_mutex_lock`{.interpreted-text role="func"}
> -   :c`pthread_mutex_timedlock`{.interpreted-text role="func"}
> -   :c`pthread_mutex_trylock`{.interpreted-text role="func"}
> -   :c`pthread_mutex_unlock`{.interpreted-text role="func"}

**Condition Variables**.

> -   :c`pthread_condattr_init`{.interpreted-text role="func"}
> -   :c`pthread_condattr_destroy`{.interpreted-text role="func"}
> -   :c`pthread_cond_init`{.interpreted-text role="func"}
> -   :c`pthread_cond_destroy`{.interpreted-text role="func"}
> -   :c`pthread_cond_broadcast`{.interpreted-text role="func"}
> -   :c`pthread_cond_signal`{.interpreted-text role="func"}
> -   :c`pthread_cond_wait`{.interpreted-text role="func"}
> -   :c`pthread_cond_timedwait`{.interpreted-text role="func"}

**Barriers**.

> -   :c`pthread_barrierattr_init`{.interpreted-text role="func"}
> -   :c`pthread_barrierattr_destroy`{.interpreted-text role="func"}
> -   :c`pthread_barrierattr_setpshared`{.interpreted-text role="func"}
> -   :c`pthread_barrierattr_getpshared`{.interpreted-text role="func"}
> -   :c`pthread_barrier_init`{.interpreted-text role="func"}
> -   :c`pthread_barrier_destroy`{.interpreted-text role="func"}
> -   :c`pthread_barrier_wait`{.interpreted-text role="func"}

**Initialization**.

> -   :c`pthread_once`{.interpreted-text role="func"}

**Signals**.

> -   :c`pthread_kill`{.interpreted-text role="func"}
> -   :c`pthread_sigmask`{.interpreted-text role="func"}

No support for the following pthread interfaces is provided by NuttX:

> -   `pthread_attr_getguardsize`. get and set the thread guardsize
>     attribute.
> -   `pthread_attr_getscope`. get and set the contentionscope
>     attribute.
> -   `pthread_attr_setguardsize`. get and set the thread guardsize
>     attribute.
> -   `pthread_attr_setscope`. get and set the contentionscope
>     attribute.
> -   `pthread_getconcurrency`. get and set the level of concurrency.
> -   `pthread_getcpuclockid`. access a thread CPU-time clock.
> -   `pthread_mutex_getprioceiling`. get and set the priority ceiling
>     of a mutex.
> -   `pthread_mutex_setprioceiling`. get and set the priority ceiling
>     of a mutex.
> -   `pthread_mutexattr_getprioceiling`. get and set the prioceiling
>     attribute of the mutex attributes object.
> -   `pthread_mutexattr_setprioceiling`. get and set the prioceiling
>     attribute of the mutex attributes object.
> -   `pthread_setconcurrency`. get and set the level of concurrency.
