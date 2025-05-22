Mutual Exclusion lock
=====================

nxmutex
-------

Use [nxmutex]{.title-ref} prefixed api to protect resources. In fact,
nxmutex is implemented based on nxsem. The difference between nxmutex
and nxsem is that nxmutex supports priority inheritance by default,
nxsem do not support priority inheritance by default.

### Typical Usage

Call nxmutex\_init() for driver, when two tasks will use driver, their
timing will be:

  taskA               taskB
  ------------------- -------------------
  nxmutex\_lock()     nxmutex\_lock()
  get lock running    wait for lock
  nxmutex\_unlock()   wait for lock
  \-                  get lock running
  \-                  nxmutex\_unlock()

Priority inheritance
--------------------

If [CONFIG\_PRIORITY\_INHERITANCE]{.title-ref} is chosen, the priority
of the task holding the mutex may be changed. This is an example:

> There are three tasks. Their priorities are high, medium, and low. We
> refer to them as [Htask]{.title-ref} [Mtask]{.title-ref}
> [Ltask]{.title-ref}
>
> [Htask]{.title-ref} and [Ltask]{.title-ref} will hold the same mutex.
> [Mtask]{.title-ref} does not hold mutex

if [CONFIG\_PRIORITY\_INHERITANCE]{.title-ref} is not chosen, task running order

:   1.  [Ltask]{.title-ref} hold a mutex first
    2.  Then [Htask]{.title-ref} running, [Htask]{.title-ref} can\'t
        hold the mutex,so wait
    3.  Then [Mtask]{.title-ref} running, because [Mtask]{.title-ref}
        priority higher than [Ltask]{.title-ref}.
    4.  When [Mtask]{.title-ref} finish, [Ltask]{.title-ref} will start
        running.
    5.  When [Ltask]{.title-ref} finish, [Htask]{.title-ref} will start
        running.

From the above process, we can see that the medium-priority tasks run
ahead of the high-priority tasks, which is unacceptable.

if [CONFIG\_PRIORITY\_INHERITANCE]{.title-ref} is chosen, task running order

:   1.  [Ltask]{.title-ref} hold a mutex first.
    2.  Then [Htask]{.title-ref} running, [Htask]{.title-ref} can\'t
        hold the mutex, then boost the priority of [Ltask]{.title-ref}

to be the same as [Htask]{.title-ref}.

:   1.  Because [Ltask]{.title-ref} priority is higher than
        [Mtask]{.title-ref},so [Mtask]{.title-ref} not running.
    2.  When \'Ltask\' finish, [Htask]{.title-ref} will start running.
    3.  When [Htask]{.title-ref} finish, [Mtask]{.title-ref} will start
        running.

Priority inheritance prevents medium-priority tasks from running ahead
of high-priority tasks

Api description
---------------
