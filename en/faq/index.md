Create new subsections as needed.

FAQ
===

NSH Tricks
----------

### How to get an application available in the NSH?

You will need at least three things enabled inside NuttX menuconfig to
be able to see an application this displayed there: BUILTIN,
NSH\_BUILTIN\_APPS and the application itself. Enabling BUILTIN:

    Library Routines  --->
            [*] Support Builtin Applications

Enabling NSH\_BUILTIN\_APPS:

    Application Configuration  --->
            NSH Library  --->
                [*]   Enable built-in applications

Enabling Hello World Application:

    Application Configuration  --->
            Examples  --->
                [*]   "Hello, World!" example

After compilation you should see the hello at NSH:

``` {.shell}
NuttShell (NSH) NuttX-12.5.1
nsh> ?
help usage:  help [-v] [<cmd>]
  .           cp          exit        mkdir       set         unset
  [           cmp         expr        mkrd        sleep       uptime
  ?           dirname     false       mount       source      usleep
  alias       dd          fdinfo      mv          test        xd
  unalias     df          free        pidof       time
  basename    dmesg       help        printf      true
  break       echo        hexdump     pwd         truncate
  cat         env         kill        rm          uname
  cd          exec        ls          rmdir       umount
Builtin Apps:
  hello        nsh          sh
nsh>
```

Note: if you want to see the applications physically at /bin you can
enable BINFS:

    File Systems  --->
            [*] BINFS File System

### How to increase the command line length?

You can increase the Max command line length from 64 to other value,
this way:

    Application Configuration  --->
            NSH Library  --->
                Command Line Configuration  --->
                    (64) Max command line length

### How do I enable editing support on the command line?

You need to change Command Line Editor from \"Minimal readline\" to
\"Command Line Editor\", this way:

    Application Configuration  --->
        NSH Library  --->
            Command Line Configuration  --->
                Command Line Editor (Command Line Editor)  --->

### How to enable command line history?

You need to enable these options in the menuconfig:

    Application Configuration  --->
        System Libraries and NSH Add-Ons  --->
            -*- readline() Support  --->
                [*]     Command line history
                (80)      Command line history length
                (16)      Command line history records

Note: If you are using the \"Command Line Editor\" instead of the
\"readline\" then you need to use this other option:

    Application Configuration  --->
        System Libraries and NSH Add-Ons  --->
            -*- EMACS-like Command Line Editor  --->
                [*]   Command line history
                (80)    Command line history length
                (16)    Command line history records

### How to enable autocomplete on the command line?

You need to enable these options in the menuconfig:

    Application Configuration  --->
        System Libraries and NSH Add-Ons  --->
            -*- readline() Support  --->
                [*]     Tab completion
                (64)      Maximum built-in matches
                (64)      Maximum external command matches

Note: autocomplete is not enabled when \"Command Line Editor\" instead
of the \"readline\".

### How to interrupt an NSH Application using Ctrl\^C ?

You need to enable these options in the menuconfig:

    RTOS Features --->
        Signal Configuration --->
            [*] Default signal actions --->
                [*] SIGINT and SIGKILL
    Device Drivers --->
        Serial Driver Support --->
            [*] Serial TERMIOS support
            [*]   Support SIGINT
            (0x03)  Serial parse SIGINT characters

Board Initialization
--------------------

### How to start directly my application instead starting NSH?

You can start you application directly instead of starting the default
NSH terminal. Lets support your application is called \"hello\", then
you will modify the ENTRYPOINT to call \"hello\_main\" instead of
\"nsh\_main\":

    RTOS Features --->
        Tasks and Scheduling  --->
            (hello_main) Application entry point

### Why after putting my application on ENTRYPOINT it stops to work?

When you replace the ENTRYPOINT from \"nsh\_main\" to your application
some initialization flow are changed, for instance the NSH\_ARCHINIT is
not executed anymore and so some drivers initialization that are called
from it also stops to work.

You can fix it enabling the Board Late Initialization that will replace
the NSH\_ARCHINIT to call those drivers initialization. Just enable it:

    RTOS Features --->
        RTOS hooks --->
            [*] Custom board late initialization

Also you need to disable the architecture-specific initialization:

    Application Configuration --->
        NSH Library --->
            [ ] Have architecture-specific initialization

### Why isn\'t /dev/ttySx created when using USB Console even when UART is enabled?

If you don\'t use serial console then /dev/ttyS0 will not be created,
even if you enable the UART peripheral at \"System Type\".

You can fix it enabling the Serial Upper-Half Driver:

    Device Drivers --->
        Serial Driver Support --->
            [*]   Enable standard "upper-half" serial driver

Network
-------

### How to detect Ethernet cable connection/disconnection?

NuttX supports Ethernet connection/disconnection events from Ethernet
PHY using signals (see `nuttx/drivers/net/phy_notify.c`). The network
monitor thread at apps/netutils/netinit (see `CONFIG_NETINIT_MONITOR`)
will handle taking the network down if the cable is unplugged and
bringing it back up when the cable is restored. It is important to note
that your Ethernet controller driver of your MCU needs to support
CONFIG\_ARCH\_PHY\_INTERRUPT (and implement `arch_phy_irq()`).

### How to define the MTU and MSS for the network packets?

As you probably know the \"MSS = MTU - 40\", so you just need to setup
the MTU. If you search for MTU in the menuconfig you will not find it,
but you can setup the MTU using the `CONFIG_NET_ETH_PKTSIZE` here:

    Networking Support  --->
        Driver buffer configuration  --->
            (590) Ethernet packet buffer size

Then just figure it out using this formula:

> MTU = NET\_ETH\_PKTSIZE - 14
>
> MSS = MTU - 40

In this case you have MTU = 590 - 14 =\> MTU = 576!

And the MSS = 576 - 40 =\> MSS = 536.
