# Network Devices

  - `include/nuttx/net/netdev.h`. All structures and APIs needed to work
    with network drivers are provided in this header file. The structure
    `struct net_driver_s` defines the interface and is passed to the
    network via `netdev_register()`.
  - `include/nuttx/net/netdev_lowerhalf.h`. (Recommended for new
    drivers, see `Network Drivers <netdriver>`) This header file defines
    the interface between the network device and the network stack. The
    network device is a lower-half driver that provides the network
    stack with the ability to send and receive packets.

## IP Addresses

The structure `struct net_driver_s` now supports one IPv4 address and
multiple IPv6 addresses. Multiple IPv6 addresses is common in modern
network devices. For example, a network device may have a link-local
address and a global address. The link-local address is used for
neighbor discovery protocol and the global address is used for
communication with the Internet.

### Configuration Options

  - `CONFIG_NETDEV_MULTIPLE_IPv6`  
    Enable support for multiple IPv6 addresses per network device.
    Depends on `CONFIG_NET_IPv6`.

  - `CONFIG_NETDEV_MAX_IPv6_ADDR`  
    Maximum number of IPv6 addresses that can be assigned to a single
    network device. Normally a link-local address and a global address
    are needed.

### IPv4 Interfaces

Now we only support one IPv4 address per network device, and directly
use the :c`d_ipaddr`, :c`d_draddr` and :c`d_netmask` in
:c`net_driver_s`.

### IPv6 Interfaces

Now we support multiple IPv6 addresses per network device, and use the
:c`d_ipv6` in :c`net_driver_s` to store the IPv6 addresses. For
historical reason, we keep the old name :c`d_ipv6addr` and
:c`d_ipv6netmask` for backward compatibility. Please use :c`d_ipv6` for
new drivers.

Managing the IPv6 addresses by provided APIs would be more flexible:

>   - :c`netdev_ipv6_add()`
>   - :c`netdev_ipv6_del()`
>   - :c`netdev_ipv6_srcaddr()`
>   - :c`netdev_ipv6_lladdr()`
>   - :c`netdev_ipv6_lookup()`
>   - :c`netdev_ipv6_foreach()`

### Ioctls for IP Addresses

>   - :c`SIOCGIFADDR`
>   - :c`SIOCSIFADDR`
>   - :c`SIOCDIFADDR`
>   - :c`SIOCGLIFADDR`
>   - :c`SIOCSLIFADDR`
>   - :c`SIOCGIFNETMASK`
>   - :c`SIOCSIFNETMASK`
>   - :c`SIOCGLIFNETMASK`
>   - :c`SIOCSLIFNETMASK`
