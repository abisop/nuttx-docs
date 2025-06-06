Network support with VPNKit
===========================

The simulation can be configured to use VPNKit to provide network
support. While this was developed for macOS, it should work on other
platforms as well.

Configuration
-------------

``` {.bash}
CONFIG_SIM_NETDEV=y
CONFIG_SIM_NETDEV_TAP is not set
CONFIG_SIM_NETDEV_VPNKIT=y
CONFIG_SIM_NETDEV_VPNKIT_PATH="/tmp/vpnkit-nuttx"
```

You can use the `sim:vpnkit` configuration, which includes the above
settings.

``` {.bash}
./tools/configure.sh sim:vpnkit
```

VPNKit setup
------------

See [https://github.com/moby/vpnkit]{.title-ref} for build instructions.

If you have Docker Desktop for Mac installed on your machine, you can
find a vpnkit binary at:

``` {.bash}
/Applications/Docker.app/Contents/Resources/bin/com.docker.vpnkit
```

A docker image containing a static Linux binary is also available:

[https://hub.docker.com/r/djs55/vpnkit]{.title-ref}

How to run
----------

You can use it as the following:

``` {.bash}
% vpnkit --ethernet /tmp/vpnkit-nuttx &
% ./nuttx
```

NuttX\'s `CONFIG_SIM_NETDEV_VPNKIT_PATH` should match vpnkit\'s
`--ethernet` option.
