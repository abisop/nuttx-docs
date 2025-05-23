# Environment Variables

NuttX supports environment variables that can be used to control the
behavior of programs. In the spirit of NuttX the environment variable
behavior attempts to emulate the behavior of environment variables in
the multi-processing OS:

  - **Task environments**. When a new task is created using
    [task\_create](#taskcreate), the environment of the child task is an
    inherited, exact copy of the environment of the parent. However,
    after child task has been created, subsequent operations by the
    child task on its environment does not alter the environment of the
    parent. No do operations by the parent effect the child's
    environment. The environments start identical but are independent
    and may diverge.
  - **Thread environments**. When a pthread is created using
    [pthread\_create](#pthreadcreate), the child thread also inherits
    that environment of the parent. However, the child does not receive
    a copy of the environment but, rather, shares the same environment.
    Changes to the environment are visible to all threads with the same
    parentage.

## Programming Interfaces

The following environment variable programming interfaces are provided
by NuttX and are described in detail in the following paragraphs.

>   - :c`getenv`
>   - :c`putenv`
>   - :c`clearenv`
>   - :c`setenv`
>   - :c`unsetenv`

## Disabling Environment Variable Support

All support for environment variables can be disabled by setting
`CONFIG_DISABLE_ENVIRON` in the board configuration file.

## Functions
