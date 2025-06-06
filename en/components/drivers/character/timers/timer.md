Timer Drivers
=============

Files supporting the timer driver can be found in the following
locations:

-   **Interface Definition**. The header file for the NuttX timer driver
    reside at `include/nuttx/timers/timer.h`. This header file includes
    both the application level interface to the timer driver as well as
    the interface between the \"upper half\" and \"lower half\" drivers.
    The timer driver uses a standard character driver framework.
-   **\"Upper Half\" Driver**. The generic, \"upper half\" timer driver
    resides at `drivers/timers/timer.c`.
-   **\"Lower Half\" Drivers**. Platform-specific timer drivers reside
    in `arch/<architecture>/src/<hardware>` directory for the specific
    processor `<architecture>` and for the specific `<chip>` timer
    peripheral devices.

There are two ways to enable Timer Support along with the Timer Example.
The first is faster and simpler. Just run the following command to use a
ready config file with timer support and example included. You need to
check if there\'s a timer config file for your specific chip. You may
check it at the specific board\'s path:
`/boards/<arch>/<chip>/<variant>/config`.

``` {.console}
 ./tools/configure.sh <variant>:timer
```

And the second way is creating your own config file. To do so, follow
the next instructions.

Enabling the Timer Support and Example in `menuconfing`
-------------------------------------------------------

> 1.  Select Timer Instances
>
> To select these timers browse in the `menuconfig` using the following
> path:
>
> Go into menu
> `System Type --> <Chip> Peripheral Selection`{.interpreted-text
> role="menuselection"} and press `Enter`{.interpreted-text role="kbd"}.
>
> Then select one or more timers according to availability.
>
> 2.  Enable the Timer Support
>
> Go into menu
> `Device Drivers --> Timer Driver Support`{.interpreted-text
> role="menuselection"} and press `Enter`{.interpreted-text role="kbd"}.
> Then enable:
>
> -   \[x\] Timer Support
> -   \[x\] Timer Arch Implementation
>
> 3.  Include the Timer Example
>
> Go into menu
> `Application Configuration --> Examples`{.interpreted-text
> role="menuselection"} and press `Enter`{.interpreted-text role="kbd"}.
> Then select the Timer Example.
>
> -   \[x\] Timer example
>
> Below the option, it is possible to manually configure some parameters
> as the standard timer device path, the timeout, the sample rate in
> which the counter will be read, the number of samples to be executed,
> and other parameters.

Timer Example
-------------

The previously selected example will basically consult the timer status,
set a timer alarm interval, set a timer signal handler function to be
notified at the alarm, which only increments a variable, and then it
will start the timer. The application will periodically consult the
timer status at the sample rate previously configured through the
`menuconfig` to follow the time left until the timer expires. After the
samples have been read, the application stops the timer.

The [example
code](https://github.com/apache/nuttx-apps/blob/master/examples/timer/timer_main.c)
may be explored, its path is at `/examples/timer/timer_main.c` in the
apps\' repository.

In NuttX, the timer driver is a character driver and when a chip
supports multiple timers, each one is accessible through its respective
file in `/dev` directory. Each timer is registered using a unique
numeric identifier (i.e. `/dev/timer0`, `/dev/timer1`, \...).

Use the following command to run the example:

``` {.console}
`nsh> timer`
```

This command will use the timer 0. To use the others, specify it through
a parameter (where x is the timer number):

``` {.console}
`nsh> timer -d /dev/timerx`
```

Application Level Interface
---------------------------

The first necessary thing to be done in order to use the timer driver in
an application is to include the header file for the NuttX timer driver.
It contains the Application Level Interface to the timer driver. To do
so, include:

``` {.c}
#include <nuttx/timers/timer.h>
```

At an application level, the timer functionalities may be accessed
through `ioctl` systems calls. The available `ioctl` commands are:

> -   :c`TCIOC_START`{.interpreted-text role="macro"}
> -   :c`TCIOC_STOP`{.interpreted-text role="macro"}
> -   :c`TCIOC_GETSTATUS`{.interpreted-text role="macro"}
> -   :c`TCIOC_SETTIMEOUT`{.interpreted-text role="macro"}
> -   :c`TCIOC_NOTIFICATION`{.interpreted-text role="macro"}
> -   :c`TCIOC_MAXTIMEOUT`{.interpreted-text role="macro"}

These `ioctl` commands internally call lower-half layer operations and
the parameters are forwarded to these ops through the `ioctl` system
call. The return of a system call is the return of an operation. These
`struct timer_ops_s` keeps pointers to the implementation of each
operation. Following is the struct.

``` {.c}
struct timer_ops_s
{
   /* Required methods *******************************************************/

   /* Start the timer, resetting the time to the current timeout */

   CODE int (*start)(FAR struct timer_lowerhalf_s *lower);

   /* Stop the timer */

   CODE int (*stop)(FAR struct timer_lowerhalf_s *lower);

   /* Get the current timer status */

   CODE int (*getstatus)(FAR struct timer_lowerhalf_s *lower,
                           FAR struct timer_status_s *status);

   /* Set a new timeout value (and reset the timer) */

   CODE int (*settimeout)(FAR struct timer_lowerhalf_s *lower,
                           uint32_t timeout);

   /* Call the NuttX INTERNAL timeout callback on timeout.
      * NOTE:  Providing callback==NULL disable.
      * NOT to call back into applications.
      */

   CODE void (*setcallback)(FAR struct timer_lowerhalf_s *lower,
                              CODE tccb_t callback, FAR void *arg);

   /* Any ioctl commands that are not recognized by the "upper-half" driver
      * are forwarded to the lower half driver through this method.
      */

   CODE int (*ioctl)(FAR struct timer_lowerhalf_s *lower, int cmd,
                     unsigned long arg);

   /* Get the maximum supported timeout value */

   CODE int (*maxtimeout)(FAR struct timer_lowerhalf_s *lower,
                           FAR uint32_t *maxtimeout);
};
```

Since `ioctl` system calls expect a file descriptor, before using these
commands, it\'s necessary to open the timer device special file in order
to get a file descriptor. The following snippet demonstrates how to do
so:

``` {.c}
/* Open the timer device */

printf("Open %s\n", devname);

fd = open(devname, O_RDONLY);
if (fd < 0)
  {
    fprintf(stderr, "ERROR: Failed to open %s: %d\n",
            devname, errno);
    return EXIT_FAILURE;
  }
```

The `TCIOC_START` command calls the `start` operation, which is
described below.

This command may be used like so:

``` {.c}
/* Start the timer */

printf("Start the timer\n");

ret = ioctl(fd, TCIOC_START, 0);
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to start the timer: %d\n", errno);
    close(fd);
    return EXIT_FAILURE;
  }
```

The `TCIOC_STOP` command calls the `stop` operation, which is described
below.

This command may be used like so:

``` {.c}
/* Stop the timer */

printf("\nStop the timer\n");

ret = ioctl(fd, TCIOC_STOP, 0);
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to stop the timer: %d\n", errno);
    close(fd);
    return EXIT_FAILURE;
  }
```

The `TCIOC_GETSTATUS` command calls the `getstatus` operation, which is
described below.

This command may be used like so:

``` {.c}
/* Get timer status */

ret = ioctl(fd, TCIOC_GETSTATUS, (unsigned long)((uintptr_t)&status));
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to get timer status: %d\n", errno);
    close(fd);
    exit(EXIT_FAILURE);
  }

/* Print the timer status */

printf("  flags: %08lx timeout: %lu timeleft: %lu\n",
       (unsigned long)status.flags, (unsigned long)status.timeout,
       (unsigned long)status.timeleft);
```

The `TCIOC_SETTIMEOUT` command calls the `settimeout` operation, which
is described below.

This command may be used like so:

``` {.c}
/* Set the timer interval */

printf("Set timer interval to %lu\n",
       (unsigned long)CONFIG_EXAMPLES_TIMER_INTERVAL);

ret = ioctl(fd, TCIOC_SETTIMEOUT, CONFIG_EXAMPLES_TIMER_INTERVAL);
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to set the timer interval: %d\n", errno);
    close(fd);
    return EXIT_FAILURE;
  }
```

The `TCIOC_NOTIFICATION` is used to configure the timer callback to
notify the application via a signal when the timer expires. This command
calls the `setcallback` operation. Which will not be described here,
since the application does not set a callback directly. Instead, the
user should configure a signal handler to catch notifications, and then,
configure a timer notifier to notify and to signal the previously
configured signal handler. For a better performance, a separate pthread
may be configured to wait on sigwaitinfo() for timer events.

In any case, this command expects a read-only pointer to a struct
[timer\_notify\_s]{.title-ref}. This struct contains 2 fields: `pid`
(`pid_t`), that indicates the ID of the task/thread to receive the
signal and `event` (`struct sigevent`), which describes the way a task
will be notified.

This command may be used like so:

``` {.c}
printf("Configure the notification\n");

notify.pid   = getpid();
notify.event.sigev_notify = SIGEV_SIGNAL;
notify.event.sigev_signo  = CONFIG_EXAMPLES_TIMER_SIGNO;
notify.event.sigev_value.sival_ptr = NULL;

ret = ioctl(fd, TCIOC_NOTIFICATION, (unsigned long)((uintptr_t)&notify));
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to set the timer handler: %d\n", errno);
    close(fd);
    return EXIT_FAILURE;
  }
```

The `TCIOC_MAXTIMEOUT` command calls the `maxtimeout` operation, which
is described below.

This command may be used like so:

``` {.c}
/* Get the maximum timer timeout  */

printf("Get the maximum timer timeout\n");

ret = ioctl(fd, TCIOC_MAXTIMEOUT, (uint32_t*)(&max_timeout));
if (ret < 0)
  {
    fprintf(stderr, "ERROR: Failed to reat the timer's maximum timeout: %d\n", errno);
    close(fd);
    return EXIT_FAILURE;
  }

/* Print the maximum supported timeout */

printf("Maximum supported timeout: %" PRIu32 "\n", max_timeout);
```

Those snippets were taken from the Example which provides a great
resource to demonstrate how to use those `ioctl` commands.
