NuttX File System
=================

NuttX includes an optional, scalable file system. This file-system may
be omitted altogether; NuttX does not depend on the presence of any file
system.

**Pseudo Root File System**. A simple *in-memory*, *pseudo* file system
can be enabled by default. This is an *in-memory* file system because it
does not require any storage medium or block driver support. Rather,
file system contents are generated on-the-fly as referenced via standard
file system operations (open, close, read, write, etc.). In this sense,
the file system is *pseudo* file system (in the same sense that the
Linux `/proc` file system is also referred to as a pseudo file system).

Any user supplied data or logic can be accessed via the pseudo-file
system. Built in support is provided for character and block drivers in
the `/dev` pseudo file system directory.

**Mounted File Systems** The simple in-memory file system can be
extended my mounting block devices that provide access to true file
systems backed up via some mass storage device. NuttX supports the
standard `mount()` command that allows a block driver to be bound to a
mountpoint within the pseudo file system and to a file system. At
present, NuttX supports the standard VFAT and ROMFS file systems, a
special, wear-leveling NuttX FLASH File System (NXFFS), as well as a
Network File System client (NFS version 3, UDP).

**Comparison to Linux** From a programming perspective, the NuttX file
system appears very similar to a Linux file system. However, there is a
fundamental difference: The NuttX root file system is a pseudo file
system and true file systems may be mounted in the pseudo file system.
In the typical Linux installation by comparison, the Linux root file
system is a true file system and pseudo file systems may be mounted in
the true, root file system. The approach selected by NuttX is intended
to support greater scalability from the very tiny platform to the
moderate platform.

Virtual File System (VFS)
-------------------------

Virtual File System provides a unified interface for various file
systems to be able to co-exist together by exposing a blueprint that
each file system needs to implement. This also allows the file system to
be free from worry about the device driver implementations for storage
devices, as they also expose a unified way of accessing the underlying
devices.

### How VFS works

Threads are controllable sequences of instruction execution with their
own stacks. Each task in NuttX is represented by a Task Control Block
(TCB) (TCB is defined in `include/nuttx/sched.h`) and tasks are
organized in task lists.

All threads that are created by `pthread_create()` are part of the same
task group. A task group (defined in `include/nuttx/sched.h`) is a
shared structure pointed to by the TCBs of all the threads that belong
to the same task group, and this task group contains all the resources
shared across the task group which includes *file descriptors* in the
form of a **file list**.

A file list (defined in `include/nuttx/fs/fs.h`) contains file
structures that denote open files (along with a spinlock to manage
access to the file list). With the devices listed in the
`root file system <root_fs>`{.interpreted-text role="ref"} (on points
like `/dev/led`, `/dev/mmcsd0`, etc. which are henceforth called
blockdriver mount points) in an unmounted state, storage devices can be
mounted using the `mount()` command (to any point like `/dir/abcd`) with
any specific supported file system, which internally calls its
implemented `mountpt_operations->bind()` method and passes the
blockdriver\'s mount point inode to it, thus creating a **mount point**.
The blockdriver mount point inode will have a `mountpt->i_private` which
contains any (file system dependent) information about the mount and is
to be filled by the file system during the execution of
`mountpt_operations->bind()` (and usually this data includes a pointer
to the blockdriver mount point as well). After that, according to system
calls, the other exposed functions of the filesystem are called as per
need.

### VFS Interface

VFS allows file systems to expose their own implementations of methods
belonging to a unified interface:

-   **File operations**

Note

POSIX requires that a `read()` after a `write()` should get the newly
written data, but not all file systems conform to POSIX, especially as
POSIX requires atomic writes, which is not usually implemented as it can
impact performance.

To be POSIX compliant in concurrent situations, either the writes have
to be atomic, or read is blocked with a lock until an on-going write is
finished, which, as stated, would impact performance.

Note

According to POSIX, `lseek()` to any point after the end of the file
*does not* by itself increase the size of the file. Later writes to this
part will, however, increase it to at least the end of the written data,
and the \"gap\" before this written data should be filled with `\0` in
case of any reads after such a write operation.

Note

NuttX operates in a flat open address space. Therefore, it generally
does not require `mmap()` functionality. There are two notable
exceptions where `mmap()` functionality is required:

1.  `mmap()` is the API that is used to support direct access to random
    access media under the following very restrictive conditions:

> a.  The filesystem implements the mmap file operation. Any file system
>     that maps files contiguously on the media should support this
>     ioctl. (vs. file system that scatter files over the media in
>     non-contiguous sectors). As of this writing, ROMFS is the only
>     file system that meets this requirement.
> b.  The underlying block driver supports the BIOC\_XIPBASE ioctl
>     command that maps the underlying media to a randomly accessible
>     address. At present, only the RAM/ROM disk driver does this.

2.  If CONFIG\_FS\_RAMMAP is defined in the configuration, then mmap()
    will support simulation of memory mapped files by copying files
    whole into RAM.

-   **Additional open file specific operations**

```{=html}
<!-- -->
```
-   **Directory operations**

```{=html}
<!-- -->
```
-   **Volume-relations operations**

```{=html}
<!-- -->
```
-   **Path operations**

The file systems can have their own implementations for these functions
under-the-hood, but the user does not have to worry about the underlying
file system during file I/O, as the file system has to expose its
implementations in a unified interface.

Note

Each file system has to globally expose their implementations of the
unified interface as defined by `struct mountpt_operations` (in
`include/fs/fs.h`) to one of the lists defined in `fs/mount/fs_mount.c`
depending on the type of the file system.

They also need their own [magic
number](https://en.wikipedia.org/wiki/Magic_number_(programming)) to be
listed in `include/sys` and in `fs_gettype` function (in
`fs/mount/fs_gettype.c`) for identification of the filesystem.

File systems
------------

NuttX provides support for a variety of file systems out of the box.

> aio.rst binfs.rst cromfs.rst fat.rst hostfs.rst littlefs.rst mmap.rst
> mnemofs.rst nfs.rst nxffs.rst partition.rst procfs.rst romfs.rst
> rpmsgfs.rst smartfs.rst shmfs.rst spiffs.rst tmpfs.rst unionfs.rst
> userfs.rst zipfs.rst inotify.rst nuttxfs.rst nxflat.rst pseudofs.rst
> special\_files\_dev\_num.rst v9fs.rst

### FS Categories

File systems can be divided into these categories on the basis of the
drivers they require:

1.  They require a block device driver. They include vfat, romfs,
    smartfs, and littlefs.
2.  They require MTD drivers. They include romfs, spiffs, littlefs.
3.  They require neither block nor MTD drivers. They include nxffs,
    tmpfs, nfs binfs, procfs, userfs, hostfs, cromfs, unionfs, rpmsgfs,
    and zipfs.

The requirements are specified by declaring the filesystem in the proper
array in `fs/mount/fs_mount.c`.
