Network Devices
===============

-   `include/nuttx/net/netdev.h`. All structures and APIs needed to work
    with network drivers are provided in this header file. The structure
    `struct net_driver_s` defines the interface and is passed to the
    network via `netdev_register()`.
-   `include/nuttx/net/netdev_lowerhalf.h`. (Recommended for new
    drivers, see `Network Drivers <netdriver>`{.interpreted-text
    role="ref"}) This header file defines the interface between the
    network device and the network stack. The network device is a
    lower-half driver that provides the network stack with the ability
    to send and receive packets.

IP Addresses
------------

The structure `struct net_driver_s` now supports one IPv4 address and
multiple IPv6 addresses. Multiple IPv6 addresses is common in modern
network devices. For example, a network device may have a link-local
address and a global address. The link-local address is used for
neighbor discovery protocol and the global address is used for
communication with the Internet.

### Configuration Options

`CONFIG_NETDEV_MULTIPLE_IPv6`

:   Enable support for multiple IPv6 addresses per network device.
    Depends on `CONFIG_NET_IPv6`.

`CONFIG_NETDEV_MAX_IPv6_ADDR`

:   Maximum number of IPv6 addresses that can be assigned to a single
    network device. Normally a link-local address and a global address
    are needed.

### IPv4 Interfaces

Now we only support one IPv4 address per network device, and directly
use the :c`d_ipaddr`{.interpreted-text role="member"},
:c`d_draddr`{.interpreted-text role="member"} and
:c`d_netmask`{.interpreted-text role="member"} in
:c`net_driver_s`{.interpreted-text role="struct"}.

### IPv6 Interfaces

Now we support multiple IPv6 addresses per network device, and use the
:c`d_ipv6`{.interpreted-text role="member"} in
:c`net_driver_s`{.interpreted-text role="struct"} to store the IPv6
addresses. For historical reason, we keep the old name
:c`d_ipv6addr`{.interpreted-text role="member"} and
:c`d_ipv6netmask`{.interpreted-text role="member"} for backward
compatibility. Please use :c`d_ipv6`{.interpreted-text role="member"}
for new drivers.

Managing the IPv6 addresses by provided APIs would be more flexible:

> -   :c`netdev_ipv6_add()`{.interpreted-text role="func"}
> -   :c`netdev_ipv6_del()`{.interpreted-text role="func"}
> -   :c`netdev_ipv6_srcaddr()`{.interpreted-text role="func"}
> -   :c`netdev_ipv6_lladdr()`{.interpreted-text role="func"}
> -   :c`netdev_ipv6_lookup()`{.interpreted-text role="func"}
> -   :c`netdev_ipv6_foreach()`{.interpreted-text role="func"}

### Ioctls for IP Addresses

> -   :c`SIOCGIFADDR`{.interpreted-text role="macro"}
> -   :c`SIOCSIFADDR`{.interpreted-text role="macro"}
> -   :c`SIOCDIFADDR`{.interpreted-text role="macro"}
> -   :c`SIOCGLIFADDR`{.interpreted-text role="macro"}
> -   :c`SIOCSLIFADDR`{.interpreted-text role="macro"}
> -   :c`SIOCGIFNETMASK`{.interpreted-text role="macro"}
> -   :c`SIOCSIFNETMASK`{.interpreted-text role="macro"}
> -   :c`SIOCGLIFNETMASK`{.interpreted-text role="macro"}
> -   :c`SIOCSLIFNETMASK`{.interpreted-text role="macro"}
