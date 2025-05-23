# Pthread Interfaces

NuttX does not support *processes* in the way that, say, Linux does.
NuttX only supports simple threads or tasks running within the same
address space. However, NuttX does support the concept of a *task
group*. A task group is the functional analog of a process: It is a
group that consists of the main task thread and of all of the pthreads
created by the main thread or any of the other pthreads within the task
group. Members of a task group share certain resources such as
environment variables, file descriptors, `FILE` streams, sockets,
pthread keys and open message queues.

<div class="note">

<div class="title">

Note

</div>

Behavior of features related to task groups depend of NuttX
configuration settings. See also the[NuttX
Tasking](https://cwiki.apache.org/confluence/display/NUTTX/NuttX+Tasking)page
and the[Tasks vs. Threads
FAQ](https://cwiki.apache.org/confluence/display/NUTTX/Tasks+vs.+Threads+FAQ)for
additional information on tasks and threads in NuttX.

</div>

The following pthread interfaces are supported in some form by NuttX:

**pthread control interfaces**. Interfaces that allow you to create and
manage pthreads.

>   - :c`pthread_attr_init`
>   - :c`pthread_attr_destroy`
>   - :c`pthread_attr_setschedpolicy`
>   - :c`pthread_attr_getschedpolicy`
>   - :c`pthread_attr_setschedparam`
>   - :c`pthread_attr_getschedparam`
>   - :c`pthread_attr_setinheritsched`
>   - :c`pthread_attr_getinheritsched`
>   - :c`pthread_attr_setstacksize`
>   - :c`pthread_attr_getstacksize`
>   - :c`pthread_create`
>   - :c`pthread_detach`
>   - :c`pthread_exit`
>   - :c`pthread_cancel`
>   - :c`pthread_setcancelstate`
>   - :c`pthread_setcanceltype`
>   - :c`pthread_testcancel`
>   - :c`pthread_cleanup_pop`
>   - :c`pthread_cleanup_push`
>   - :c`pthread_join`
>   - :c`pthread_yield`
>   - :c`pthread_self`
>   - :c`pthread_getschedparam`
>   - :c`pthread_setschedparam`

**Thread Specific Data**. These interfaces can be used to create pthread
*keys* and then to access thread-specific data using these keys. Each
*task group* has its own set of pthread keys. NOTES: (1) pthread keys
create in one *task group* are not accessible in other task groups. (2)
The main task thread does not have thread-specific data.

>   - :c`pthread_key_create`
>   - :c`pthread_setspecific`
>   - :c`pthread_getspecific`
>   - :c`pthread_key_delete`

**pthread Mutexes**.

>   - :c`pthread_mutexattr_init`
>   - :c`pthread_mutexattr_destroy`
>   - :c`pthread_mutexattr_getpshared`
>   - :c`pthread_mutexattr_setpshared`
>   - :c`pthread_mutexattr_gettype`
>   - :c`pthread_mutexattr_settype`
>   - :c`pthread_mutexattr_getprotocol`
>   - :c`pthread_mutexattr_setprotocol`
>   - :c`pthread_mutex_init`
>   - :c`pthread_mutex_destroy`
>   - :c`pthread_mutex_lock`
>   - :c`pthread_mutex_timedlock`
>   - :c`pthread_mutex_trylock`
>   - :c`pthread_mutex_unlock`

**Condition Variables**.

>   - :c`pthread_condattr_init`
>   - :c`pthread_condattr_destroy`
>   - :c`pthread_cond_init`
>   - :c`pthread_cond_destroy`
>   - :c`pthread_cond_broadcast`
>   - :c`pthread_cond_signal`
>   - :c`pthread_cond_wait`
>   - :c`pthread_cond_timedwait`

**Barriers**.

>   - :c`pthread_barrierattr_init`
>   - :c`pthread_barrierattr_destroy`
>   - :c`pthread_barrierattr_setpshared`
>   - :c`pthread_barrierattr_getpshared`
>   - :c`pthread_barrier_init`
>   - :c`pthread_barrier_destroy`
>   - :c`pthread_barrier_wait`

**Initialization**.

>   - :c`pthread_once`

**Signals**.

>   - :c`pthread_kill`
>   - :c`pthread_sigmask`

No support for the following pthread interfaces is provided by NuttX:

>   - `pthread_attr_getguardsize`. get and set the thread guardsize
>     attribute.
>   - `pthread_attr_getscope`. get and set the contentionscope
>     attribute.
>   - `pthread_attr_setguardsize`. get and set the thread guardsize
>     attribute.
>   - `pthread_attr_setscope`. get and set the contentionscope
>     attribute.
>   - `pthread_getconcurrency`. get and set the level of concurrency.
>   - `pthread_getcpuclockid`. access a thread CPU-time clock.
>   - `pthread_mutex_getprioceiling`. get and set the priority ceiling
>     of a mutex.
>   - `pthread_mutex_setprioceiling`. get and set the priority ceiling
>     of a mutex.
>   - `pthread_mutexattr_getprioceiling`. get and set the prioceiling
>     attribute of the mutex attributes object.
>   - `pthread_mutexattr_setprioceiling`. get and set the prioceiling
>     attribute of the mutex attributes object.
>   - `pthread_setconcurrency`. get and set the level of concurrency.
