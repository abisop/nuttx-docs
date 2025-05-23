# Power Management

<div class="todo">

This needs to be updated to account for the different governors besides
the activity-based one.

</div>

NuttX supports a simple power management (PM) sub-system which:

>   - Monitors activity from drivers (and from other parts of the
>     system), and
>   - Provides hooks to place drivers (and the whole system) into reduce
>     power modes of operation.

![figure](pm.png)

The PM sub-system integrates the MCU idle loop with a collection of
device drivers to support:

>   - Reports of relevant driver or other system activity.
>   - Registration and callback mechanism to interface with individual
>     device drivers.
>   - IDLE time polling of overall driver activity.
>   - Coordinated, global, system-wide transitions to lower power usage
>     states.

**Low Power Consumption States**. Various "sleep" and low power
consumption states have various names and are sometimes used in
conflicting ways. In the NuttX PM logic, we will use the following
terminology:

>   - `NORMAL`  
>     The normal, full power operating mode.
> 
>   - `IDLE`  
>     This is still basically normal operational mode, the system is,
>     however, `IDLE` and some simple simple steps to reduce power
>     consumption provided that they do not interfere with normal
>     Operation. Simply dimming the a backlight might be an example some
>     that that would be done when the system is idle.
> 
>   - `STANDBY`  
>     Standby is a lower power consumption mode that may involve more
>     extensive power management steps such has disabling clocking or
>     setting the processor into reduced power consumption modes. In
>     this state, the system should still be able to resume normal
>     activity almost immediately.
> 
>   - `SLEEP`  
>     The lowest power consumption mode. The most drastic power
>     reduction measures possible should be taken in this state. It may
>     require some time to get back to normal operation from `SLEEP`
>     (some MCUs may even require going through reset).

**Power Management Domains**. Each PM interfaces includes a integer
*domain* number. By default, only a single power domain is supported
(`CONFIG_PM_NDOMAINS=1`). But that is configurable; any number of PM
domains can be supported. Multiple PM domains might be useful, for
example, if you would want to control power states associated with a
network separately from power states associated with a user interface.

## Interfaces

All PM interfaces are declared in the file `include/nuttx/power/pm.h`.

## Callbacks
