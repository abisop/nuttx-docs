# ADC Drivers

  - `include/nuttx/analog/adc.h`. All structures and APIs needed to work
    with ADC drivers are provided in this header file. This header file
    includes:
    1.  Structures and interface descriptions needed to develop a
        low-level, architecture-specific, ADC driver.
    2.  To register the ADC driver with a common ADC character driver.
    3.  Interfaces needed for interfacing user programs with the common
        ADC character driver.
  - `drivers/analog/adc.c`. The implementation of the common ADC
    character driver.

## Application Programming Interface

The first necessary thing to be done in order to use the ADC driver from
an application is to include the correct header filer. It contains the
Application Programming Interface to the ADC driver. To do so, include:

``` c
#include <nuttx/analog/adc.h>
```

ADC driver is registered as a POSIX character device file into `/dev`
namespace. It is necessary to open the device to get a file descriptor
for further operations. This can be done with standard POSIX `open()`
call.

Standard POSIX `read()` operation may be used to read the measured data
from the controller. The driver utilizes FIFO queue for received
measurements and `read()` operation gets data from this queue. Structure
`adc_msg_s` (or array of these structures) should be passed to buffer
parameter of `read()` call. This structure represents one ADC
measurement.

``` c
begin_packed_struct struct adc_msg_s
{
  /* The 8-bit ADC Channel */
  uint8_t      am_channel;
  /* ADC convert result (4 bytes) */
  int32_t      am_data;
} end_packed_struct;
```

User may perform polling operation on the driver with `poll()` call. The
controller also may be configured/controlled at run time with numerous
`ioctl()` calls. Following commands are supported:

>   - :c`ANIOC_TRIGGER`
>   - :c`ANIOC_WDOG_UPPER`
>   - :c`ANIOC_WDOG_LOWER`
>   - :c`ANIOC_GET_NCHANNELS`
>   - :c`ANIOC_RESET_FIFO`
>   - :c`ANIOC_SAMPLES_ON_READ`

The `ANIOC_TRIGGER` command triggers one conversion. This call is used
when software trigger conversion is configured. The opposite to software
trigger is a hardware trigger. This may be some timer driver for
example.

This command is used to set the upper threshold for the watchdog.

This command is used to set the lower threshold for the watchdog.

The `ANIOC_GET_NCHANNELS` gets the number of used/configured channels
for given opened instance. This is the only portable way how to get the
number of channels from the driver.

This `ioctl` command clears the FIFO queue in which measured data are
stored.

The `ANIOC_SAMPLES_ON_READ` returns number of samples/measured data
waiting in the FIFO queue to be read.

It is possible for a controller to support its specific ioctl commands.
These should be described in controller specific documentation.

### Application Example

An example application can be found in `nuttx-apps` repository under
path `examples/adc`. It is an example application that reads the data
from the defined number of channels.

## Configuration

This section describes ADC driver configuration in `Kconfig`. The reader
should refer to target documentation for target specific configuration.

ADC peripheral is enabled by `CONFIG_ANALOG` and `CONFIG_ADC` options,
respectively. The user can configure FIFO queue size with configuration
option `CONFIG_ADC_FIFOSIZE`. This variable defines the size of the ADC
ring buffer that is used to queue received ADC data until they can be
retrieved by the application by reading from the ADC character device.
Since this is a ring buffer, the actual number of bytes that can be
retained in buffer is (`CONFIG_ADC_FIFOSIZE - 1`).

Configuration option `CONFIG_ADC_NPOLLWAITERS` defines number of threads
that can be waiting on poll.

## External Devices

NuttX also provides support for various external ADC devices. These
usually communicates with MCU with I2C or SPI peripherals.

> */*
