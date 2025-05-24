File System Interfaces
======================

NuttX File System Overview
--------------------------

**Overview**. NuttX includes an optional, scalable file system. This
file-system may be omitted altogether; NuttX does not depend on the
presence of any file system.

**Pseudo Root File System**. A simple *in-memory*, *pseudo* file system
can be enabled by default. This is an *in-memory* file system because it
does not require any storage medium or block driver support. Rather,
file system contents are generated on-the-fly as referenced via standard
file system operations (open, close, read, write, etc.). In this sense,
the file system is *pseudo* file system (in the same sense that the
Linux `/proc` file system is also referred to as a pseudo file system).

Any user supplied data or logic can be accessed via the pseudo-file
system. Built in support is provided for character and block
`driver <drivers-porting>`{.interpreted-text role="ref"} *nodes* in the
any pseudo file system directory. (By convention, however, all driver
nodes should be in the `/dev` pseudo file system directory).

**Mounted File Systems** The simple in-memory file system can be
extended my mounting block devices that provide access to true file
systems backed up via some mass storage device. NuttX supports the
standard `mount()` command that allows a block driver to be bound to a
mount-point within the pseudo file system and to a a file system. At
present, NuttX supports only the VFAT file system.

**Comparison to Linux** From a programming perspective, the NuttX file
system appears very similar to a Linux file system. However, there is a
fundamental difference: The NuttX root file system is a pseudo file
system and true file systems may be mounted in the pseudo file system.
In the typical Linux installation by comparison, the Linux root file
system is a true file system and pseudo file systems may be mounted in
the true, root file system. The approach selected by NuttX is intended
to support greater scalability from the very tiny platform to the
moderate platform.

**File System Interfaces**. The NuttX file system simply supports a set
of standard, file system APIs (`open()`, `close()`, `read()`, `write`,
etc.) and a registration mechanism that allows devices drivers to a
associated with *nodes* in a file-system-like name space.

Driver Operations
-----------------

### `fcntl.h`

### `unistd.h`

### `sys/ioctl.h`

### `poll.h`

### `sys/select.h`

### Directory Operations (`dirent.h`)

### UNIX Standard Operations (`unistd.h`)

``` {.c}
#include <unistd.h>

/* Task Control Interfaces */

pid_t   vfork(void);
pid_t   getpid(void);
void    _exit(int status) noreturn_function;
unsigned int sleep(unsigned int seconds);
void    usleep(unsigned long usec);
int     pause(void);

/* File descriptor operations */

int     close(int fd);
int     dup(int fd);
int     dup2(int fd1, int fd2);
int     fsync(int fd);
off_t   lseek(int fd, off_t offset, int whence);
ssize_t read(int fd, FAR void *buf, size_t nbytes);
ssize_t write(int fd, FAR const void *buf, size_t nbytes);
ssize_t pread(int fd, FAR void *buf, size_t nbytes, off_t offset);
ssize_t pwrite(int fd, FAR const void *buf, size_t nbytes, off_t offset);

/* Check if a file descriptor corresponds to a terminal I/O file */

int     isatty(int fd);

/* Memory management */

#if defined(CONFIG_ARCH_ADDRENV) && defined(CONFIG_MM_PGALLOC) && \
    defined(CONFIG_ARCH_USE_MMU)
FAR void *sbrk(intptr_t incr);
#endif

/* Special devices */

int     pipe(int fd[2]);

/* Working directory operations */

int     chdir(FAR const char *path);
FAR char *getcwd(FAR char *buf, size_t size);

/* File path operations */

int     access(FAR const char *path, int amode);
int     rmdir(FAR const char *pathname);
int     unlink(FAR const char *pathname);

#ifdef CONFIG_PSEUDOFS_SOFTLINKS
int     link(FAR const char *path1, FAR const char *path2);
ssize_t readlink(FAR const char *path, FAR char *buf, size_t bufsize);
#endif

/* Execution of programs from files */

#ifdef CONFIG_LIBC_EXECFUNCS
int     execl(FAR const char *path, ...);
int     execv(FAR const char *path, FAR char * const argv[]);
#endif

/* Networking */

#ifdef CONFIG_NET
int     gethostname(FAR char *name, size_t size);
int     sethostname(FAR const char *name, size_t size);
#endif

/* Other */

int     getopt(int argc, FAR char * const argv[], FAR const char *optstring);
```

### Standard I/O

``` {.c}
#include <stdio.h>

/* Operations on streams (FILE) */

void   clearerr(FAR FILE *stream);
int    fclose(FAR FILE *stream);
int    fflush(FAR FILE *stream);
int    feof(FAR FILE *stream);
int    ferror(FAR FILE *stream);
int    fileno(FAR FILE *stream);
int    fgetc(FAR FILE *stream);
int    fgetpos(FAR FILE *stream, FAR fpos_t *pos);
FAR char *fgets(FAR char *s, int n, FAR FILE *stream);
void   flockfile(FAR FILE *stream);
FAR FILE *fopen(FAR const char *path, FAR const char *type);
int    fprintf(FAR FILE *stream, FAR const char *format, ...);
int    fputc(int c, FAR FILE *stream);
int    fputs(FAR const char *s, FAR FILE *stream);
size_t fread(FAR void *ptr, size_t size, size_t n_items, FAR FILE *stream);
FAR FILE *freopen(FAR const char *path, FAR const char *mode,
         FAR FILE *stream);
int    fseek(FAR FILE *stream, long int offset, int whence);
int    fsetpos(FAR FILE *stream, FAR fpos_t *pos);
long   ftell(FAR FILE *stream);
int    ftrylockfile(FAR FILE *stream);
void   funlockfile(FAR FILE *stream);
size_t fwrite(FAR const void *ptr, size_t size, size_t n_items, FAR FILE *stream);
FAR char *gets(FAR char *s);
FAR char *gets_s(FAR char *s, rsize_t n);
void   setbuf(FAR FILE *stream, FAR char *buf);
int    setvbuf(FAR FILE *stream, FAR char *buffer, int mode, size_t size);
int    ungetc(int c, FAR FILE *stream);

/* Operations on the stdout stream, buffers, paths, and the whole printf-family *    /

int    printf(FAR const char *format, ...);
int    puts(FAR const char *s);
int    rename(FAR const char *source, FAR const char *target);
int    sprintf(FAR char *dest, FAR const char *format, ...);
int    asprintf(FAR char **ptr, FAR const char *fmt, ...);
int    snprintf(FAR char *buf, size_t size, FAR const char *format, ...);
int    sscanf(FAR const char *buf, FAR const char *fmt, ...);
void   perror(FAR const char *s);

int    vprintf(FAR const char *s, va_list ap);
int    vfprintf(FAR FILE *stream, FAR const char *s, va_list ap);
int    vsprintf(FAR char *buf, FAR const char *s, va_list ap);
int    vasprintf(FAR char **ptr, FAR const char *fmt, va_list ap);
int    vsnprintf(FAR char *buf, size_t size, FAR const char *format, va_list ap);
int    vsscanf(FAR char *buf, FAR const char *s, va_list ap);

/* Operations on file descriptors including:
 *
 * POSIX-like File System Interfaces (fdopen), and
 * Extensions from the Open Group Technical Standard, 2006, Extended API Set
 *   Part 1 (dprintf and vdprintf)
 */

FAR FILE *fdopen(int fd, FAR const char *type);
int    dprintf(int fd, FAR const char *fmt, ...);
int    vdprintf(int fd, FAR const char *fmt, va_list ap);

/* Operations on paths */

FAR char *tmpnam(FAR char *s);
FAR char *tempnam(FAR const char *dir, FAR const char *pfx);
int       remove(FAR const char *path);

#include <sys/stat.h>

int mkdir(FAR const char *pathname, mode_t mode);
int mkfifo(FAR const char *pathname, mode_t mode);
int stat(FAR const char *path, FAR struct stat *buf);
int fstat(int fd, FAR struct stat *buf);

#include <sys/statfs.h>

int statfs(FAR const char *path, FAR struct statfs *buf);
int fstatfs(int fd, FAR struct statfs *buf);
```

### Standard Library (`stdlib.h`)

Generally addresses other operating system interfaces. However, the
following may also be considered as file system interfaces:

### Asynchronous I/O

``` {.c}
#include <aio.h>

int aio_cancel(int, FAR struct aiocb *aiocbp);
int aio_error(FAR const struct aiocb *aiocbp);
int aio_fsync(int, FAR struct aiocb *aiocbp);
int aio_read(FAR struct aiocb *aiocbp);
ssize_t aio_return(FAR struct aiocb *aiocbp);
int aio_suspend(FAR const struct aiocb * const list[], int nent,
                FAR const struct timespec *timeout);
int aio_write(FAR struct aiocb *aiocbp);
int lio_listio(int mode, FAR struct aiocb * const list[], int nent,
               FAR struct sigevent *sig);
```

### Standard String Operations

``` {.c}
#include <string.h>

char  *strchr(const char *s, int c);
FAR char *strdup(const char *s);
const char *strerror(int);
size_t strlen(const char *);
size_t strnlen(const char *, size_t);
char  *strcat(char *, const char *);
char  *strncat(char *, const char *, size_t);
int    strcmp(const char *, const char *);
int    strncmp(const char *, const char *, size_t);
int    strcasecmp(const char *, const char *);
int    strncasecmp(const char *, const char *, size_t);
char  *strcpy(char *dest, const char *src);
char  *strncpy(char *, const char *, size_t);
char  *strpbrk(const char *, const char *);
char  *strchr(const char *, int);
char  *strrchr(const char *, int);
size_t strspn(const char *, const char *);
size_t strcspn(const char *, const char *);
char  *strstr(const char *, const char *);
char  *strtok(char *, const char *);
char  *strtok_r(char *, const char *, char **);

void  *memset(void *s, int c, size_t n);
void  *memcpy(void *dest, const void *src, size_t n);
int    memcmp(const void *s1, const void *s2, size_t n);
void  *memmove(void *dest, const void *src, size_t count);

#include <strings.h>

#define bcmp(b1,b2,len)  memcmp(b1,b2,(size_t)len)
#define bcopy(b1,b2,len) memmove(b2,b1,len)
#define bzero(s,n)       memset(s,0,n)
#define index(s,c)       strchr(s,c)
#define rindex(s,c)      strrchr(s,c)

int    ffs(int j);
int    strcasecmp(const char *, const char *);
int    strncasecmp(const char *, const char *, size_t);
```

### Pipes and FIFOs

### `mmap()` and eXecute In Place (XIP)

NuttX operates in a flat open address space and is focused on MCUs that
do support Memory Management Units (MMUs). Therefore, NuttX generally
does not require `mmap()` functionality and the MCUs generally cannot
support true memory-mapped files.

However, memory mapping of files is the mechanism used by NXFLAT, the
NuttX tiny binary format, to get files into memory in order to execute
them. `mmap()` support is therefore required to support NXFLAT. There
are two conditions where `mmap()` can be supported:

1.  `mmap()` can be used to support *eXecute In Place* (XIP) on random
    access media under the following very restrictive conditions:

    a.  Any file system that maps files contiguously on the media should
        implement the mmap file operation. By comparison, most file
        system scatter files over the media in non-contiguous sectors.
        As of this writing, ROMFS is the only file system that meets
        this requirement.
    b.  The underlying block driver supports the `BIOC_XIPBASE` `ioctl`
        command that maps the underlying media to a randomly accessible
        address. At present, only the RAM/ROM disk driver does this.

    Some limitations of this approach are as follows:

    a.  Since no real mapping occurs, all of the file contents are
        \"mapped\" into memory.
    b.  All mapped files are read-only.
    c.  There are no access privileges.

2.  If `CONFIG_FS_RAMMAP` is defined in the configuration, then `mmap()`
    will support simulation of memory mapped files by copying files
    whole into RAM. These copied files have some of the properties of
    standard memory mapped files. There are many, many exceptions
    exceptions, however. Some of these include:

    a.  The goal is to have a single region of memory that represents a
        single file and can be shared by many threads. That is, given a
        filename a thread should be able to open the file, get a file
        descriptor, and call `mmap()` to get a memory region. Different
        file descriptors opened with the same file path should get the
        same memory region when mapped.

        The limitation in the current design is that there is
        insufficient knowledge to know that these different file
        descriptors correspond to the same file. So, for the time being,
        a new memory region is created each time that `rammmap()` is
        called. Not very useful!

    b.  The entire mapped portion of the file must be present in memory.
        Since it is assumed that the MCU does not have an MMU,
        on-demanding paging in of file blocks cannot be supported. Since
        the while mapped portion of the file must be present in memory,
        there are limitations in the size of files that may be memory
        mapped (especially on MCUs with no significant RAM resources).

    c.  All mapped files are read-only. You can write to the in-memory
        image, but the file contents will not change.

    d.  There are no access privileges.

    e.  Since there are no processes in NuttX, all `mmap()` and
        `munmap()` operations have immediate, global effects. Under
        Linux, for example, `munmap()` would eliminate only the mapping
        with a process; the mappings to the same file in other processes
        would not be effected.

    f.  Like true mapped file, the region will persist after closing the
        file descriptor. However, at present, these ram copied file
        regions are *not* automatically \"unmapped\" (i.e., freed) when
        a thread is terminated. This is primarily because it is not
        possible to know how many users of the mapped region there are
        and, therefore, when would be the appropriate time to free the
        region (other than when munmap is called).

        NOTE: Note, if the design limitation of a) were solved, then it
        would be easy to solve exception d) as well.

### Fdsan

FD (file descriptor) is widely used in system software development, and
almost all implementations of posix os (including nuttx) use FD as an
index. the value of fd needs to be allocated starting from the minimum
available value of 3, and each process has a copy, so the same fd value
is very easy to reuse in the program.

In multi threaded or multi process environments without address
isolation, If the ownership, global variables, and competition
relationships of fd are not properly handled, there may be issues with
fd duplication or accidental closure. Further leading to the following
issues, which are difficult to troubleshoot.

1.  Security vulnerability: the fd we wrote is not the expected fd and
    will be accessed by hackers to obtain data
2.  Program exceptions or crashes: write or read fd failures, and
    program logic errors
3.  The structured file XML or database is damaged: the data format
    written to the database is not the expected format.

The implementation principle of fdsan is based on the implementation of
Android
<https://android.googlesource.com/platform/bionic/+/master/docs/fdsan.md>
