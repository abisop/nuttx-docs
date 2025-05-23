# Configuring

Apache NuttX is a very configurable: nearly all features can be
configured in or out of the system. This makes it possible to compile a
build tailored for your hardware and application.

The Apache NuttX configuration system uses Linux's [kconfig
system](https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt)
which includes various frontends that allow you to modify configuration
easily. Usually, the `menuconfig` frontend is used, which is a console
based menu system (more info
[here](https://en.wikipedia.org/wiki/Menuconfig)).

As previously explained in
\[<span class="title-ref">compiling\_make</span>, the
fir\](<span class="title-ref">compiling\_make</span>, the fir.md)st step
is to load a premade configuration for your board. Then, you can modify
this configuration to your liking. In this example, we will show how you
modify the default configuration of the `sim` build, a build of NuttX
which runs on your own computer.

1.  Initialize Board Configuration
    
    > 
    > 
    > ``` console
    >  cd nuttx
    >  ./tools/configure.sh -l sim:nsh
    >   Copy files
    >   Select CONFIG_HOST_LINUX=y
    >   Refreshing...
    > ```

2.  Build & run
    
    > 
    > 
    > ``` console
    >  make clean; make
    >  ./nuttx
    > login: admin
    > password: Administrator
    > User Logged-in!
    > nsh>
    > ```
    
    From another terminal window, kill the simulator:
    
    > 
    > 
    > ``` console
    >  pkill nuttx
    > ```

3.  Modify configuration
    
    In this case we will remove the login feature (which will boot
    straight to the prompt). To do so, we use the `menuconfig` frontend.
    
    > 
    > 
    > ``` console
    >  make menuconfig
    > ```
    
    Here's what you should see:
    
    ![Screenshot of menuconfig system main
    screen](../_static/images/menuconfig.png)
    
    The NSH Login setting is under `Application Configuration --> NSH
    Library`. You can use `🢁` and `🢃` keys to navigate and `↵` to enter
    a submenu. To disable the corresponding setting go to `Console
    Login` and press `spacebar` to it (so that it has a blank space
    instead of a star in it).
    
    Now you need to exit `menuconfig` and save the modified
    configuration. Use the `🡸` and `🡺` arrow keys to navigate the lower
    menu. If you select `Exit` you will be prompted to save the config.

4.  Build with the new Configuration
    
    > 
    > 
    > ``` console
    >  make
    > ```

5.  Run
    
    > 
    > 
    > ``` console
    >  ./nuttx
    > NuttShell (NSH) NuttX-8.2
    > MOTD: username=admin password=Administrator
    > ```
    
    Success\!

<div class="tip">

<div class="title">

Tip

</div>

If you find that message of the day (MOTD) annoying and want to turn
that off, it's configured in `Application Configuration --> NSH Library
--> Message of the Day (MOTD)`.

</div>

## Fast configuration changes

If you know exactly which configuration symbol you want to change, you
can use the `kconfig-tweak` tool (comes with the `kconfig-frontends`
package) to quickly change a setting without going into the
configuration frontend. This is useful to change settings such as debug
options:

``` console
 kconfig-tweak --disable CONFIG_DEBUG_NET
 make olddefconfig  # needed to have the kconfig system check the config
 kconfig-tweak --enable CONFIG_DEBUG_NET
 make olddefconfig
```

This is also useful to script configuration changes that you perform
often:

``` bash
#!/bin/bash

kconfig-tweak --disable CONFIG_DEBUG_ALERT
kconfig-tweak --disable CONFIG_DEBUG_FEATURES
kconfig-tweak --disable CONFIG_DEBUG_ERROR
kconfig-tweak --disable CONFIG_DEBUG_WARN
kconfig-tweak --disable CONFIG_DEBUG_INFO
kconfig-tweak --disable CONFIG_DEBUG_ASSERTIONS
kconfig-tweak --disable CONFIG_DEBUG_NET
kconfig-tweak --disable CONFIG_DEBUG_NET_ERROR
kconfig-tweak --disable CONFIG_DEBUG_NET_WARN
kconfig-tweak --disable CONFIG_DEBUG_NET_INFO
kconfig-tweak --disable CONFIG_DEBUG_SYMBOLS
kconfig-tweak --disable CONFIG_DEBUG_NOOPT
kconfig-tweak --disable CONFIG_SYSLOG_TIMESTAMP
make oldconfig
```

## Reference configuration

Defconfig supports the use of `#include` statements to reference other
configuration files:

    CONFIG_XXX1=y
    CONFIG_XXX2=y
    #include "configs/system.config"
    #include "configs/net.config"

The default header file search path includes:

  - Current directory;
  - `{boards}/configs/common`;
  - `{boards}/common/configs`;

## Merge configuration

Multiple config fragments can be merged manually using the
tools/merge\_config.py script.

``` console
 cd nuttx
 ./tools/merge_config.py -o defconfig .config1 .config2
```
