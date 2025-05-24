APIs Exported by Board-Specific Logic to NuttX
==============================================

Exported board-specific interfaces are prototyped in the header file
`include/nuttx/board.h`. There are many interfaces exported from board-
to architecture-specific logic. But there are only a few exported from
board-specific logic to common NuttX logic. Those few of those related
to initialization will be discussed in this paragraph. There are others,
like those used by `` `boardctl() `` \<\#boardctl\>\`\_\_ that will be
discussed in other paragraphs.

All of the board-specific interfaces used by the NuttX OS logic are for
controlled board initialization. There are three points in time where
you can insert custom, board-specific initialization logic:

First, `<arch>_board_initialize()`: This function is *not* called from
the common OS logic, but rather from the architecture-specific power on
reset logic. This is used only for initialization of very low-level
things like configuration of GPIO pins, power settings, DRAM
initialization, etc. The OS has not been initialized at this point, so
you cannot allocate memory or initialize device drivers.

The other two board initialization *hooks* are called from the OS
start-up logic and are described in the following paragraphs:
