Task Control Interfaces
=======================

Warning

This section name is duplicate with the first, how should it be named?

-   **Scheduler locking interfaces**. These *non-standard* interfaces
    are used to enable and disable pre-emption and to test is
    pre-emption is currently enabled.

    > -   :c`sched_lock`{.interpreted-text role="func"}
    > -   :c`sched_unlock`{.interpreted-text role="func"}
    > -   :c`sched_lockcount`{.interpreted-text role="func"}

-   **Task synchronization interfaces** are used to wait for termination
    of child tasks.

    > -   :c`waitpid`{.interpreted-text role="func"}
    > -   :c`waitid`{.interpreted-text role="func"}
    > -   :c`wait`{.interpreted-text role="func"}

-   **Task Exit Hooks** may be used to register callback functions that
    are executed when a *task group* terminates. A task group is the
    functional analog of a process: It is a group that consists of the
    main task thread and of all of the pthreads created by the main task
    thread or any of the other pthreads within the task group. Members
    of a task group share certain resources such as environment
    variables, file descriptors, `FILE` streams, sockets, pthread keys
    and open message queues.

    > -   :c`atexit`{.interpreted-text role="func"}
    > -   :c`on_exit`{.interpreted-text role="func"}

    Note

    Behavior of features related to task group\'s depend of NuttX
    configuration settings. See the discussion of \"Parent and Child
    Tasks,\" below. See also the[NuttX
    Tasking](https://cwiki.apache.org/confluence/display/NUTTX/NuttX+Tasking)page
    and the[Tasks vs. Threads
    FAQ](https://cwiki.apache.org/confluence/display/NUTTX/Tasks+vs.+Threads+FAQ)for
    additional information on tasks and threads in NuttX.

    A *task group* terminates when the last thread within the group
    exits.

Parent and Child Tasks
----------------------

The task synchronization interfaces historically depend upon parent and
child relationships between tasks. But default, NuttX does not use any
parent/child knowledge. However, there are three important configuration
options that can change that.

> -   `CONFIG_SCHED_HAVE_PARENT`: If this setting is defined, then it
>     instructs NuttX to remember the task ID of the parent task when
>     each new child task is created. This support enables some
>     additional features (such as `SIGCHLD`) and modifies the behavior
>     of other interfaces. For example, it makes `waitpid()` more
>     standards complete by restricting the waited-for tasks to the
>     children of the caller.
>
> -   `CONFIG_SCHED_CHILD_STATUS`: If this option is selected, then the
>     exit status of the child task will be retained after the child
>     task exits. This option should be selected if you require
>     knowledge of a child process\'s exit status. Without this setting,
>     `wait()`, `waitpid()` or `waitid()` may fail. For example, if you
>     do:
>
>     > 1.  Start child task
>     > 2.  Wait for exit status (using :c`wait`{.interpreted-text
>     >     role="func"}, :c`waitpid`{.interpreted-text role="func"} or
>     >     :c`waitid`{.interpreted-text role="func"}).
>
>     This may fail because the child task may run to completion before
>     the wait begins. There is a non-standard work-around in this case:
>     The above sequence will work if you disable pre-emption using
>     :c`sched_lock`{.interpreted-text role="func"} prior to starting
>     the child task, then re-enable pre-emption with
>     :c`sched_unlock`{.interpreted-text role="func"} after the wait
>     completes. This works because the child task is not permitted to
>     run until the wait is in place.
>
>     The standard solution would be to enable
>     `CONFIG_SCHED_CHILD_STATUS`. In this case the exit status of the
>     child task is retained after the child exits and the wait will
>     successful obtain the child task\'s exit status whether it is
>     called before the child task exits or not.
>
> -   `CONFIG_PREALLOC_CHILDSTATUS`. To prevent runaway child status
>     allocations and to improve allocation performance, child task exit
>     status structures are pre-allocated when the system boots. This
>     setting determines the number of child status structures that will
>     be pre-allocated.
>
>     Obviously, if tasks spawn children indefinitely and never have the
>     exit status reaped, then you may have a memory leak! (See
>     **Warning** below)

Warning

If you enable the `CONFIG_SCHED_CHILD_STATUS` feature, then your
application must either (1) take responsibility for reaping the child
status with `wait()`, `waitpid()` or `waitid()`, or (2) suppress
retention of child status. If you do not reap the child status, then you
have a memory leak and your system will eventually fail.

Retention of child status can be suppressed on the parent using logic
like:

``` {.c}
struct sigaction sa;

sa.sa_handler = SIG_IGN;
sa.sa_flags = SA_NOCLDWAIT;
int ret = sigaction(SIGCHLD, &sa, NULL);
```

Functions
---------
