Quadrature Encoder Drivers
==========================

NuttX supports a low-level, two-part Quadrature Encoder driver.

1.  An \"upper half\", generic driver that provides the common
    Quadrature Encoder interface to application level code, and
2.  A \"lower half\", platform-specific driver that implements the
    low-level timer controls to implement the Quadrature Encoder
    functionality.

Files supporting the Quadrature Encoder can be found in the following
locations:

-   **Interface Definition**. The header file for the NuttX Quadrature
    Encoder driver reside at `include/nuttx/sensors/qencoder.h`. This
    header file includes both the application level interface to the
    Quadrature Encoder driver as well as the interface between the
    \"upper half\" and \"lower half\" drivers. The Quadrature Encoder
    module uses a standard character driver framework.
-   **\"Upper Half\" Driver**. The generic, \"upper half\" Quadrature
    Encoder driver resides at `drivers/sensors/qencoder.c`.
-   **\"Lower Half\" Drivers**. Platform-specific Quadrature Encoder
    drivers reside in `arch/<architecture>/src/<hardware>` directory for
    the specific processor `<architecture>` and for the specific
    `<chip>` Quadrature Encoder peripheral devices.

Application Programming Interface
---------------------------------

The first thing to be done in order to use the quadrature encoder driver
from an application is to include the correct header filer. It contains
the Application Programming Interface to the driver. To do so, include

``` {.c}
#include <nuttx/sensors/qencoder.h>
```

Quadrature encoder driver is registered as a POSIX character device file
into `/dev` namespace. It is necessary to open the device to get a file
descriptor for further operations. This can be done with standard POSIX
`open()` call.

The driver is accessed only through `ioctl` interface, functions `read`
and `write` does not have any affect. Following `ioctl` commands are
available:

> -   :c`QEIOC_POSITION`{.interpreted-text role="macro"}
> -   :c`QEIOC_RESET`{.interpreted-text role="macro"}
> -   :c`QEIOC_SETPOSMAX`{.interpreted-text role="macro"}
> -   :c`QEIOC_SETINDEX`{.interpreted-text role="macro"}
> -   :c`QEIOC_GETINDEX`{.interpreted-text role="macro"}

This call gets the current position from the encoder driver. Argument of
the call is a pointer to `int32_t` variable.

This command resets the current encoder positition to zero.

The `QEIOC_SETPOSMAX` call sets the maximum position for the encoder. An
argument is an `uint32_t` variable with the maximum position value.

This ioctl sets the index position of the encoder. An argument is an
`uint32_t` variable with the maximum position value.

This ioctl gets the index position of the encoder. An argument is a
pointer to `qe_index_s` structure.

``` {.c}
struct qe_index_s
{
   /* Qencoder actual position */
   int32_t qenc_pos;
   /* Index last position */
   int32_t indx_pos;
   /* Number of index occurrences */
   int16_t indx_cnt;
};
```

The pointer to this structure is used as an argument to `QEIOC_GETINDEX`
ioctl command. It gets the current encoder position, the last position
of index and the number of index occurrences.

### Application Example

An example application can be found in `nuttx-apps` repository under
path `examples/qencoder`. It demonstrates the basic data read from an
encoder device.

``` {.console}
nsh> qe
1.  0
2.  0
3.  0
4.  1
5.  1
6.  1
7.  2
8.  2
9.  3
```

Configuration
-------------

This section describes qencoder driver configuration in `Kconfig`. The
reader should refer to target documentation for target specific
configuration.

The `CONFIG_SENSORS` option has to be enabled in order to use the
qencoder peripheral. The peripheral itself is enabled by
`CONFIG_SENSORS_QENCODER` option.
