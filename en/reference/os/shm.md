# Shared Memory

Shared memory interfaces are only available with the NuttX kernel build
(`CONFIG_BUILD_KERNEL=y`). These interfaces support user memory regions
that can be shared between multiple user processes. The user interfaces
are provided in the standard header file `include/sys/shm.h>`. All logic
to support shared memory is implemented within the NuttX kernel with the
exception of two low-level functions that are require to configure the
platform-specific MMU resources. Those interfaces are described below:
