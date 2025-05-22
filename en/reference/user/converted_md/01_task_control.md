Task Control Interfaces
=======================

**Tasks**. NuttX is a flat address OS. As such it does not support
*processes* in the way that, say, Linux does. NuttX only supports simple
threads running within the same address space. However, the programming
model makes a distinction between *tasks* and *pthreads*:

> -   *tasks* are threads which have a degree of independence
> -   [pthreads](#Pthread) share some resources.

**File Descriptors and Streams**. This applies, in particular, in the
area of opened file descriptors and streams. When a task is started
using the interfaces in this section, it will be created with at most
three open files.

If `CONFIG_DEV_CONSOLE` is defined, the first three file descriptors
(corresponding to stdin, stdout, stderr) will be duplicated for the new
task. Since these file descriptors are duplicated, the child task can
free close them or manipulate them in any way without effecting the
parent task. File-related operations (open, close, etc.) within a task
will have no effect on other tasks. Since the three file descriptors are
duplicated, it is also possible to perform some level of redirection.

pthreads, on the other hand, will always share file descriptors with the
parent thread. In this case, file operations will have effect only all
pthreads the were started from the same parent thread.

**Executing Programs within a File System**. NuttX also provides
internal interfaces for the execution of separately built programs that
reside in a file system. These internal interfaces are, however,
non-standard and are documented with the NuttX binary loader and NXFLAT
documentation.

**Task Control Interfaces**. The following task control interfaces are
provided by NuttX:

::: {.note}
::: {.title}
Note
:::

Maybe this can be converted into a table, or could otherwise be replaced
by the index if these are sectioned in this way.
:::

Non-standard task control interfaces inspired by VxWorks interfaces:

> -   :c`task_create`{.interpreted-text role="func"}
> -   :c`task_delete`{.interpreted-text role="func"}
> -   :c`task_restart`{.interpreted-text role="func"}

Non-standard extensions to VxWorks-like interfaces to support POSIX
[Cancellation
Points](https://cwiki.apache.org/confluence/display/NUTTX/Cancellation+Points).

> -   :c`task_setcancelstate`{.interpreted-text role="func"}
> -   :c`task_setcanceltype`{.interpreted-text role="func"}
> -   :c`task_testcancel`{.interpreted-text role="func"}

Standard interfaces

> -   :c`exit`{.interpreted-text role="func"}
> -   :c`getpid`{.interpreted-text role="func"}

Standard `vfork` and `exec[v|l]` interfaces:

> -   :c`vfork`{.interpreted-text role="func"}
> -   :c`exec`{.interpreted-text role="func"}
> -   :c`execv`{.interpreted-text role="func"}
> -   :c`execl`{.interpreted-text role="func"}

Standard `posix_spawn` interfaces:

> -   :c`posix_spawn`{.interpreted-text role="func"} and
>     :c`posix_spawnp`{.interpreted-text role="func"}
> -   :c`posix_spawn_file_actions_init`{.interpreted-text role="func"}
> -   :c`posix_spawn_file_actions_destroy`{.interpreted-text
>     role="func"}
> -   :c`posix_spawn_file_actions_addclose`{.interpreted-text
>     role="func"}
> -   :c`posix_spawn_file_actions_adddup2`{.interpreted-text
>     role="func"}
> -   :c`posix_spawn_file_actions_addopen`{.interpreted-text
>     role="func"}
> -   :c`posix_spawnattr_init`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_getflags`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_getschedparam`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_getschedpolicy`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_getsigmask`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_setflags`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_setschedparam`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_setschedpolicy`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_setsigmask`{.interpreted-text role="func"}

Non-standard task control interfaces inspired by `posix_spawn`:

> -   :c`task_spawn`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_getstacksize`{.interpreted-text role="func"}
> -   :c`posix_spawnattr_setstacksize`{.interpreted-text role="func"}

Functions
---------
