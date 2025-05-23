# SLIP

## SLIP Configuration

1.  Configure and build NuttX with SLIP enabled in the configuration.
    Load this into FLASH and start the device.

2.  Connect to a Linux box using a serial cable. This discussion assumes
    that the serial device is `/dev/ttyS0` on both the target and the
    Linux box.

3.  Reset on the target side and attach SLIP on the Linux side:
    
    ``` bash
     modprobe slip
     slattach -L -p slip -s 57600 /dev/ttyS0 &
    ```
    
    This should create an interface with a name like sl0, or sl1, etc.
    Add -d to get debug output. This will show the interface name.
    
    NOTE: The -L option is included to suppress use of hardware flow
    control. This is necessary only if you are not supporting hardware
    flow control on the target.
    
    NOTE: The Linux slip module hard-codes its MTU size to 296. So you
    might as well set `CONFIG_NET_ETH_MTU` to 296 as well.

4.  After turning over the line to the SLIP driver, you must configure
    the network interface. Again, you do this using the standard
    ifconfig and route commands. Assume that we have connected to a host
    PC with address 192.168.0.101 from your target with address
    10.0.0.2. On the Linux PC you would execute the following as root
    (assuming the SLIP is attached to device sl0):
    
    ``` bash
     ifconfig sl0 10.0.0.1 pointopoint 10.0.0.2 up
     route add 10.0.0.2 dev sl0
    ```

5.  For monitoring/debugging traffic:
    
    ``` bash
     tcpdump -n -nn -i sl0 -x -X -s 1500
    ```
    
    NOTE: If hardware handshake is not available, then you might try the
    slattach option-L which is supposed to enable "3-wire operation."
