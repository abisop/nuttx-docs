NX
==

Overview
--------

NX provides a tiny windowing system in the spirit of X, but greatly
scaled down and appropriate for most resource-limited embedded
environments. The current NX implementation supports the general
following, high-level features:

-   **Virtual Vertical Graphics Space** Windows that reside in a
    virtual, vertical space so that it makes sense to talk about one
    window being on top of another and obscuring the window below it.
-   **Client/Server Model** A standard client server/model was adopted.
    NX may be considered a server and other logic that presents the
    windows are NX clients.
-   **Multi-User Support** NX includes front-end logic to an NX server
    daemon that can serve multiple NX client threads. The NX sever
    thread/daemon serializes graphics operations from multiple clients.
-   **Minimal Graphics Toolset** The actual implementation of the
    graphics operations is performed by common, back-end logic. This
    back-end supports only a primitive set of graphic and rendering
    operations.
-   **Device Interface** NX supports any graphics device either of two
    device interfaces:
    1.  Any device with random access video memory using the NuttX
        framebuffer driver interface (see include/nuttx/video/fb.h).
    2.  Any LCD-like device than can accept raster line runs through a
        parallel or serial interface (see include/nuttx/lcd/lcd.h). By
        default, NX is configured to use the frame buffer driver unless
        CONFIG\_NX\_LCDDRIVER is defined =y in your NuttX configuration
        file.
-   **Transparent to NX Client** The window client on \"sees\" the
    sub-window that is operates in and does not need to be concerned
    with the virtual, vertical space (other that to respond to redraw
    requests from NX when needed).
-   **Framed Windows and Toolbars** NX also adds the capability to
    support windows with frames and toolbars on top of the basic
    windowing support. These are windows such as those shown in the
    screenshot above. These framed windows sub-divide one one window
    into three relatively independent subwindows: A frame, the contained
    window and an (optional) toolbar window.
-   **Mouse Support** NX provides support for a mouse or other X/Y
    pointing devices. APIs are provided to allow external devices to
    give X/Y position information and mouse button presses to NX. NX
    will then provide the mouse input to the relevant window clients via
    callbacks. Client windows only receive the mouse input callback if
    the mouse is positioned over a visible portion of the client window;
    X/Y position is provided to the client in the relative coordinate
    system of the client window.
-   **Keyboard input** NX also supports keyboard/keypad devices. APIs
    are provided to allow external devices to give keypad information to
    NX. NX will then provide the mouse input to the top window on the
    display (the window that has the focus) via a callback function.

Pre-Processor Definitions
-------------------------

The default server message queue name used by the
:c`nx_run`{.interpreted-text role="macro"} macro:

``` {.c}
#define NX_DEFAULT_SERVER_MQNAME "/dev/nxs"
```

Mouse button bits:

``` {.c}
#define NX_MOUSE_NOBUTTONS    0x00
#define NX_MOUSE_LEFTBUTTON   0x01
#define NX_MOUSE_CENTERBUTTON 0x02
#define NX_MOUSE_RIGHTBUTTON  0x04
```

NX Types
--------

The interface to the NX server is managed using a opaque handle:

The interface to a specific window is managed using an opaque handle:

These define callbacks that must be provided to
:c`nx_openwindow`{.interpreted-text role="func"}. These callbacks will
be invoked as part of the processing performed by
:c`nx_eventhandler`{.interpreted-text role="func"}.

Starting the NX Server
----------------------

The *NX Server* is a kernel daemon that receives and serializes graphic
commands. Before you can use the NX graphics system, you must first
start this daemon. There are two ways that this can be done:

1.  The NX server may be started in your board startup logic by simply
    calling the function `nxmu_start()`. The board startup logic usually
    resides the the `boards/arch/chip/board/src` directory. The board
    startup logic can run automatically during the early system if
    `CONFIG_BOARD_LATE_INITIALIZE` is defined in the configuration. Or,
    the board startup logic can execute under control of the application
    by calling :c`boardctl`{.interpreted-text role="func"} as:

    ``` {.c}
    boardctl(BOARDIOC_INIT, arg)
    ```

    The board initialization logic will run in either case and the
    simple call to `nxmu_start()` will start the NX server.

2.  The NX server may also be started later by the application via
    :c`boardctl`{.interpreted-text role="func"} as:

    ``` {.c}
    boardctl(BOARDIOC_NX_START, arg)
    ```

NX Server Callbacks
-------------------

Set the color of the background.

param handle

:   The handle created by :c`nx_openwindow`{.interpreted-text
    role="func"} or :c`nx_requestbkgd`{.interpreted-text role="func"}

param color

:   The color to use in the background

return

:   `OK` on success; `ERROR` on failure with `errno` set appropriately

Move a rectangular region within the window.

param hwnd

:   The handle returned by :c`nx_openwindow`{.interpreted-text
    role="func"} or :c`nx_requestbkgd`{.interpreted-text role="func"}
    that specifies the window within which the move is to be done

param rect

:   Describes the (source) rectangular region to move

param offset

:   The offset to move the region

return

:   `OK` on success; `ERROR` on failure with `errno` set appropriately
