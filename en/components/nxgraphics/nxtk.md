# NX Tool Kit (`NXTK`)

NXTK implements where the *framed window*. NX framed windows consist of
three components within one NX window:

> 1.  The window *border*,
> 2.  The main *client window* area, and
> 3.  A *toolbar* area

Each sub-window represents a region within one window. [Figure
1](#screenshot) shows some simple NX framed windows. NXTK allows these
sub-windows to be managed more-or-less independently:

>   - Each component has its own callbacks for redraw and position
>     events as well as mouse and keyboard inputs. The client sub-window
>     callbacks are registered when the framed window is created with a
>     call to :c`nxtk_openwindow`; Separate toolbar sub-window callbacks
>     are reigistered when the toolbar is added using
>     :c`nxtk_opentoolbar`. (NOTES: (1) only the client sub-window
>     receives keyboard input and, (2) border callbacks are not
>     currently accessible by the user).
>   - All position informational provided within the callback is
>     relative to the specific sub-window. That is, the origin (0,0) of
>     the coordinate system for each sub-window begins at the top left
>     corner of the subwindow. This means that toolbar logic need not be
>     concerned about client window geometry (and vice versa) and, for
>     example, common toolbar logic can be used with different windows.
