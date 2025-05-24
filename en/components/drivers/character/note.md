Note Driver Interface
=====================

Note driver is the interface to access the instrumentation data. The
following devices are provided.

-   `notectl`{.interpreted-text role="ref"}
-   `noteram`{.interpreted-text role="ref"}

Notectl Device (`/dev/notectl`)
-------------------------------

> `/dev/notectl` is the device to control an instrumentation filter in
> NuttX kernel. The device has only ioctl function to control the
> filter.

### `/dev/notectl` Header Files

> The header file `include/nuttx/note/notectl_driver.h` provides the
> interface definitions of the device.

### `/dev/notectl` Data Structures

### `/dev/notectl` Ioctls

Noteram Device (`/dev/note`)
----------------------------

> `/dev/note` is the device to get the trace (instrumentation) data. The
> device has read function to get the data and ioctl function to control
> the buffer mode.

### `/dev/note` Header Files

> The header file `include/nuttx/note/noteram_driver.h` provides the
> interface definitions of the device.

### `/dev/note` Data Structures

### `/dev/note` Ioctls

Filter control APIs
-------------------

The following APIs are the functions to control note filters directly.
These are kernel APIs and application can use them only in FLAT build.

The header file `include/nuttx/sched_note.h` is needed to use the
following APIs.

### API description
