# SocketCAN Device Drivers

  - `include/nuttx/net/netdev.h`. All structures and APIs needed to work
    with drivers are provided in this header file. The structure struct
    net\_driver\_s defines the interface and is passed to the network
    via `netdev_register()`.

  - `include/nuttx/can.h`. CAN & CAN FD frame data structures.

  - `int netdev_register(FAR struct net_driver_s *dev, enum net_lltype_e
    lltype)'`. Each driver registers itself by
    calling `netdev_register()`.

  - `Include/nuttx/net/can.h`. contains lookup tables for CAN dlc to CAN
    FD len sizes named
    
    ``` c
    extern const uint8_t g_can_dlc_to_len[16];
    extern const uint8_t g_len_to_can_dlc[65];
    ```

  - **Initialization sequence is as follows**.
    
    1.  `xxx_netinitialize(void)` is called on startup of NuttX in this
        function you call your own init function to initialize your CAN
        driver
    2.  In your own init function you create the net\_driver\_s
        structure set required init values and register the required
        callbacks for SocketCAN
    3.  Then you ensure that the CAN interface is in down mode (usually
        done by calling the d\_ifdown function)
    4.  Register the net\_driver\_s using netdev\_register

  - **Receive sequence is as follows**.
    
    1.  Device generates interrupt
    2.  Process this interrupt in your interrupt handler
    3.  When a new CAN frame has been received you process this frame
    4.  When the CAN frame is a normal CAN frame you allocate the
        can\_frame struct, when it's a CAN FD frame you allocate a
        canfd\_frame struct (note you can of course preallocate and just
        use the pointer).
    5.  Copy the frame from the driver to the struct you've allocated in
        the previous step.
    6.  Point the net\_driver\_s d\_buf pointer to the allocated
        can\_frame
    7.  Call the `can_input(FAR struct net_driver_s *dev)` function
        `include/nuttx/net/can.h`

  - **Transmit sequence is as follows**.
    
    1.  Socket layer executes d\_txavail callback
    2.  An example of the txavail function can be found in
        `arch/arm/src/s32k1xx/s32k1xx_flexcan.c`
    3.  An example of the txpoll function can be found in
        `arch/arm/src/s32k1xx/s32k1xx_flexcan.c`
    4.  In your `transmit(struct driver_s *priv)` function you check the
        length of `net_driver_s.d_len` whether it matches the size of a
        `struct can_frame` or `struct canfd_frame` then you cast the
        content of the `net_driver_s.d_buf` pointer to the correct CAN
        frame struct
