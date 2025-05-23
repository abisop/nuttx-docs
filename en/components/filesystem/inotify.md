# Inotify

Inotify is a kernel subsystem designed for monitoring filesystem events.
It enables applications to monitor changes to files and directories in
real-time, such as creation, deletion, modification, renaming, and more.
inotify offers an efficient way to detect changes in the filesystem
without the need for polling, thereby conserving system resources.

## CONFIG

``` c
COFNIG_FS_NOTIFY=y
```

## User Space API

All inotify user interfaces are declared in the file
`include/sys/inotify.h`. And the usage is consistent with the Linux
version.

## Reading events from an inotify file descriptor

To determine what events have occurred, an application read from the
inotify file descriptor. If no events have so far occurred, then,
assuming a blocking file descriptor, read will block until at least one
event occurs

Each successful read returns a buffer containing one or more of the
following structures:

``` c
struct inotify_event {
  int      wd;       /* Watch descriptor */
  uint32_t mask;     /* Mask describing event */
  uint32_t cookie;   /* Unique cookie associating related
                       events (for rename(2)) */
  uint32_t len;      /* Size of name field */
  char     name[];   /* Optional null-terminated name */
};
```

**wd** identifies the watch for which this event occurs. It is one of
the watch descriptors returned by a previous call to
inotify\_add\_watch.

**mask** contains bits that describe the event that occurred

**cookie** is a unique integer that connects related events. Currently,
this is used only for rename events, and allows the resulting pair of
IN\_MOVED\_FROM and IN\_MOVED\_TO events to be connected by the
application For all other event types, cookie is set to 0.

The **name** field is present only when an event is returned for a file
inside a watched directory; it identifies the filename within the
watched directory. This filename is null-terminated, and may include
further null bytes ('0') to align subsequent reads to a suitable address
boundary.

The **len** field counts all of the bytes in name, including the null
bytes; the length of each inotify\_event structure is thus sizeof(struct
inotify\_event)+len.

## inotify events

The **inotify\_add\_watch** mask argument and the mask field of the
inotify\_event structure returned when reading an inotify file
descriptor are both bit masks identifying inotify events. The following
bits can be specified in mask when calling inotify\_add\_watch and may
be returned in the mask field returned by read.

> **IN\_ACCESS** :File was accessed
> 
> **IN\_MODIFY** :File was modified (`write()` or `truncate()`)
> 
> **IN\_ATTRIB** :Metadata changed
> 
> **IN\_OPEN** :File was opened
> 
> **IN\_CLOSE\_WRITE** :File opened for writing was closed
> 
> **IN\_CLOSE\_NOWRITE** : File not opened for writing was closed
> 
> **IN\_MOVED\_FROM** :File was moved from X
> 
> **IN\_MOVED\_TO** :File was moved to Y
> 
> **IN\_CREATE** :Subfile was created
> 
> **IN\_DELETE** :Subfile was deleted
> 
> **IN\_DELETE\_SELF** :Self was deleted
> 
> **IN\_MOVE\_SELF** :Self was moved

## Examples

Suppose an application is watching the directory `dir` and the file
`dir/myfile` for all events. The examples below show some events that
will be generated for these two objects.

>   - fd = open("dir/myfile", O\_RDWR);  
>     Generates **IN\_OPEN** events for both `dir` and `dir/myfile`.
> 
>   - read(fd, buf, count);  
>     Generates **IN\_ACCESS** events for both `dir` and `dir/myfile`.
> 
>   - write(fd, buf, count);  
>     Generates **IN\_MODIFY** events for both `dir` and `dir/myfile`.
> 
>   - fchmod(fd, mode);  
>     Generates **IN\_ATTRIB** events for both `dir` and `dir/myfile`.

## NOTE

Inotify file descriptors can be monitored using select, poll, and epoll.
When an event is available, the file descriptor indicates as readable.
