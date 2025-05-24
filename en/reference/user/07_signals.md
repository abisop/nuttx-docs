Signal Interfaces
=================

**Tasks and Signals**. NuttX provides signal interfaces for tasks and
pthreads. Signals are used to alter the flow control of tasks by
communicating asynchronous events within or between task contexts. Any
task or interrupt handler can post (or send) a signal to a particular
task using its task ID. The task being signaled will execute
task-specified signal handler function the next time that the task has
priority. The signal handler is a user-supplied function that is bound
to a specific signal and performs whatever actions are necessary
whenever the signal is received.

By default, here are no predefined actions for any signal. The default
action for all signals (i.e., when no signal handler has been supplied
by the user) is to ignore the signal. In this sense, all NuttX are *real
time* signals by default. If the configuration option
`CONFIG_SIG_DEFAULT=y` is included, some signals will perform their
default actions dependent upon addition configuration settings as
summarized in the following table:

  Signal    Action                 Additional Configuration
  --------- ---------------------- ------------------------------
  SIGUSR1   Abnormal Termination   CONFIG\_SIG\_SIGUSR1\_ACTION
  SIGUSR2   Abnormal Termination   CONFIG\_SIG\_SIGUSR2\_ACTION
  SIGALRM   Abnormal Termination   CONFIG\_SIG\_SIGALRM\_ACTION
  SIGPOLL   Abnormal Termination   CONFIG\_SIG\_SIGPOLL\_ACTION
  SIGSTOP   Suspend task           CONFIG\_SIG\_SIGSTOP\_ACTION
  SIGTSTP   Suspend task           CONFIG\_SIG\_SIGSTOP\_ACTION
  SIGCONT   Resume task            CONFIG\_SIG\_SIGSTOP\_ACTION
  SIGINT    Abnormal Termination   CONFIG\_SIG\_SIGKILL\_ACTION
  SIGKILL   Abnormal Termination   CONFIG\_SIG\_SIGKILL\_ACTION

Tasks may also suspend themselves and wait until a signal is received.

**Tasks Groups**. NuttX supports both tasks and pthreads. The primary
difference between tasks and pthreads is the tasks are much more
independent. Tasks can create pthreads and those pthreads will share the
resources of the task. The main task and its children pthreads together
are referred as a *task group*. A task group is used in NuttX to emulate
a POSIX *process*.

Note

Behavior of features related to task groups depend of NuttX
configuration settings. See also the[NuttX
Tasking](https://cwiki.apache.org/confluence/display/NUTTX/NuttX+Tasking)page
and the[Tasks vs. Threads
FAQ](https://cwiki.apache.org/confluence/display/NUTTX/Tasks+vs.+Threads+FAQ)for
additional information on tasks and threads in NuttX.

**Signaling Multi-threaded Task Groups**. The behavior of signals in the
multi-thread task group is complex. NuttX emulates a process model with
task groups and follows the POSIX rules for signaling behavior. Normally
when you signal the task group you would signal using the task ID of the
main task that created the group (in practice, a different task should
not know the IDs of the internal threads created within the task group);
that ID is remembered by the task group (even if the main task thread
exits).

Here are some of the things that should happen when you signal a
multi-threaded task group:

-   If a task group receives a signal then one and only one
    indeterminate thread in the task group which is not blocking the
    signal will receive the signal.
-   If a task group receives a signal and more than one thread is
    waiting on that signal, then one and only one indeterminate thread
    out of that waiting group will receive the signal.

You can mask out that signal using \'\'sigprocmask()\'\' (or
\'\'pthread\_sigmask()\'\'). That signal will then be effectively
disabled and will never be received in those threads that have the
signal masked. On creation of a new thread, the new thread will inherit
the signal mask of the parent thread that created it. So you if block
signal signals on one thread then create new threads, those signals will
also be blocked in the new threads as well.

You can control which thread receives the signal by controlling the
signal mask. You can, for example, create a single thread whose sole
purpose it is to catch a particular signal and respond to it: Simply
block the signal in the main task; then the signal will be blocked in
all of the pthreads in the group too. In the one \"signal processing\"
pthread, enable the blocked signal. This thread will then be only thread
that will receive the signal.

**Signal Interfaces**. The following signal handling interfaces are
provided by NuttX:

-   :c`sigemptyset`{.interpreted-text role="func"}
-   :c`sigfillset`{.interpreted-text role="func"}
-   :c`sigaddset`{.interpreted-text role="func"}
-   :c`sigdelset`{.interpreted-text role="func"}
-   :c`sigismember`{.interpreted-text role="func"}
-   :c`sigaction`{.interpreted-text role="func"}
-   :c`sigignore`{.interpreted-text role="func"}
-   :c`sigset`{.interpreted-text role="func"}
-   :c`sigprocmask`{.interpreted-text role="func"}
-   :c`sighold`{.interpreted-text role="func"}
-   :c`sigrelse`{.interpreted-text role="func"}
-   :c`sigpending`{.interpreted-text role="func"}
-   :c`sigsuspend`{.interpreted-text role="func"}
-   :c`sigpause`{.interpreted-text role="func"}
-   :c`sigwaitinfo`{.interpreted-text role="func"}
-   :c`sigtimedwait`{.interpreted-text role="func"}
-   :c`sigqueue`{.interpreted-text role="func"}
-   :c`kill`{.interpreted-text role="func"}
-   :c`pause`{.interpreted-text role="func"}

Equivalent to sigtimedwait() with a NULL timeout parameter. (see below).

> param set
>
> :   The set of pending signals to wait for.
>
> param info
>
> :   The returned signal values
>
> return
>
> :   Signal number that cause the wait to be terminated, otherwise -1
>     (`ERROR`) is returned.
>
> **POSIX Compatibility:** Comparable to the POSIX interface of the same
> name.
