# Mutual Exclusion lock

## nxmutex

Use <span class="title-ref">nxmutex</span> prefixed api to protect
resources. In fact, nxmutex is implemented based on nxsem. The
difference between nxmutex and nxsem is that nxmutex supports priority
inheritance by default, nxsem do not support priority inheritance by
default.

### Typical Usage

Call nxmutex\_init() for driver, when two tasks will use driver, their
timing will be:

| taskA             | taskB             |
| ----------------- | ----------------- |
| nxmutex\_lock()   | nxmutex\_lock()   |
| get lock running  | wait for lock     |
| nxmutex\_unlock() | wait for lock     |
| \-                | get lock running  |
| \-                | nxmutex\_unlock() |

## Priority inheritance

If <span class="title-ref">CONFIG\_PRIORITY\_INHERITANCE</span> is
chosen, the priority of the task holding the mutex may be changed. This
is an example:

> There are three tasks. Their priorities are high, medium, and low. We
> refer to them as <span class="title-ref">Htask</span>
> <span class="title-ref">Mtask</span>
> <span class="title-ref">Ltask</span>
> 
> <span class="title-ref">Htask</span> and
> <span class="title-ref">Ltask</span> will hold the same mutex.
> <span class="title-ref">Mtask</span> does not hold mutex

  - if <span class="title-ref">CONFIG\_PRIORITY\_INHERITANCE</span> is
    not chosen, task running order
    
    1.  <span class="title-ref">Ltask</span> hold a mutex first
    2.  Then <span class="title-ref">Htask</span> running,
        <span class="title-ref">Htask</span> can't hold the mutex,so
        wait
    3.  Then <span class="title-ref">Mtask</span> running, because
        <span class="title-ref">Mtask</span> priority higher than
        <span class="title-ref">Ltask</span>.
    4.  When <span class="title-ref">Mtask</span> finish,
        <span class="title-ref">Ltask</span> will start running.
    5.  When <span class="title-ref">Ltask</span> finish,
        <span class="title-ref">Htask</span> will start running.

From the above process, we can see that the medium-priority tasks run
ahead of the high-priority tasks, which is unacceptable.

  - if <span class="title-ref">CONFIG\_PRIORITY\_INHERITANCE</span> is
    chosen, task running order
    
    1.  <span class="title-ref">Ltask</span> hold a mutex first.
    2.  Then <span class="title-ref">Htask</span> running,
        <span class="title-ref">Htask</span> can't hold the mutex, then
        boost the priority of <span class="title-ref">Ltask</span>

  - to be the same as <span class="title-ref">Htask</span>.
    
    1.  Because <span class="title-ref">Ltask</span> priority is higher
        than <span class="title-ref">Mtask</span>,so
        <span class="title-ref">Mtask</span> not running.
    2.  When 'Ltask' finish, <span class="title-ref">Htask</span> will
        start running.
    3.  When <span class="title-ref">Htask</span> finish,
        <span class="title-ref">Mtask</span> will start running.

Priority inheritance prevents medium-priority tasks from running ahead
of high-priority tasks

## Api description
