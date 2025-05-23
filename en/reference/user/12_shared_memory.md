# Shared Memory Interfaces

Shared memory interfaces are only available with the NuttX kernel build
(`CONFIG_BUILD_KERNEL=y`). These interfaces support user memory regions
that can be shared between multiple user processes. Shared memory
interfaces:

>   - :c`shmget`
>   - :c`shmat`
>   - :c`shmctl`
>   - :c`shmdt`

## Functions
