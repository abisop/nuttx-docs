Address Environments
====================

CPUs that support memory management units (MMUs) may provide *address
environments* within which tasks and their child threads execute. The
configuration indicates the CPUs ability to support address environments
by setting the configuration variable `CONFIG_ARCH_HAVE_ADDRENV=y`. That
will enable the selection of the actual address environment support
which is indicated by the selection of the configuration variable
`CONFIG_ARCH_ADDRENV=y`. These address environments are created only
when tasks are created via `exec()` or `exec_module()` (see
`include/nuttx/binfmt/binfmt.h`).

When `CONFIG_ARCH_ADDRENV=y` is set in the board configuration, the
CPU-specific logic must provide a set of interfaces as defined in the
header file `include/nuttx/arch.h`. These interfaces are listed below
and described in detail in the following paragraphs.

The CPU-specific logic must provide two categories in interfaces:

1.  **Binary Loader Support**. These are low-level interfaces used in
    `binfmt/` to instantiate tasks with address environments. These
    interfaces all operate on type `arch_addrenv_t` which is an abstract
    representation of a task group\'s address environment and the type
    must be defined in`arch/arch.h` if `CONFIG_ARCH_ADDRENV` is defined.
    These low-level interfaces include:

    -   :c`up_addrenv_create()`{.interpreted-text role="func"}: Create
        an address environment.
    -   :c`up_addrenv_destroy()`{.interpreted-text role="func"}: Destroy
        an address environment.
    -   :c`up_addrenv_vtext()`{.interpreted-text role="func"}: Returns
        the virtual base address of the `.text` address environment.
    -   :c`up_addrenv_vdata()`{.interpreted-text role="func"}: Returns
        the virtual base address of the `.bss`/`.data` address
        environment.
    -   :c`up_addrenv_heapsize()`{.interpreted-text role="func"}: Return
        the initial heap size.
    -   :c`up_addrenv_select()`{.interpreted-text role="func"}:
        Instantiate an address environment.
    -   :c`up_addrenv_clone()`{.interpreted-text role="func"}: Copy an
        address environment from one location to another.

2.  **Tasking Support**. Other interfaces must be provided to support
    higher-level interfaces used by the NuttX tasking logic. These
    interfaces are used by the functions in `sched/` and all operate on
    the task group which as been assigned an address environment by
    `up_addrenv_clone()`.

    -   :c`up_addrenv_attach()`{.interpreted-text role="func"}: Clone
        the group address environment assigned to a new thread. This
        operation is done when a pthread is created that share\'s the
        same address environment.
    -   :c`up_addrenv_detach()`{.interpreted-text role="func"}: Release
        the thread\'s reference to a group address environment when a
        task/thread exits.

3.  **Dynamic Stack Support**. `CONFIG_ARCH_STACK_DYNAMIC=y` indicates
    that the user process stack resides in its own address space. This
    option is also *required* if `CONFIG_BUILD_KERNEL` and
    `CONFIG_LIBC_EXECFUNCS` are selected. Why? Because the caller\'s
    stack must be preserved in its own address space when we instantiate
    the environment of the new process in order to initialize it.

    **NOTE:** The naming of the `CONFIG_ARCH_STACK_DYNAMIC` selection
    implies that dynamic stack allocation is supported. Certainly this
    option must be set if dynamic stack allocation is supported by a
    platform. But the more general meaning of this configuration
    environment is simply that the stack has its own address space.

    If `CONFIG_ARCH_STACK_DYNAMIC=y` is selected then the platform
    specific code must export these additional interfaces:

    -   :c`up_addrenv_ustackalloc()`{.interpreted-text role="func"}:
        Create a stack address environment
    -   :c`up_addrenv_ustackfree()`{.interpreted-text role="func"}:
        Destroy a stack address environment.
    -   :c`up_addrenv_vustack()`{.interpreted-text role="func"}: Returns
        the virtual base address of the stack
    -   :c`up_addrenv_ustackselect()`{.interpreted-text role="func"}:
        Instantiate a stack address environment

4.  If `CONFIG_ARCH_KERNEL_STACK` is selected, then each user process
    will have two stacks: (1) a large (and possibly dynamic) user stack
    and (2) a smaller kernel stack. However, this option is *required*
    if both `CONFIG_BUILD_KERNEL` and `CONFIG_LIBC_EXECFUNCS` are
    selected. Why? Because when we instantiate and initialize the
    address environment of the new user process, we will temporarily
    lose the address environment of the old user process, including its
    stack contents. The kernel C logic will crash immediately with no
    valid stack in place.

    If `CONFIG_ARCH_KERNEL_STACK=y` is selected then the platform
    specific code must export these additional interfaces:

    -   :c`up_addrenv_kstackalloc`{.interpreted-text role="func"}:
        Allocate the process kernel stack.
