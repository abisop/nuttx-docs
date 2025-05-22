OS Data Structures
==================

Scalar Types
------------

Many of the types used to communicate with NuttX are simple scalar
types. These types are used to provide architecture independence of the
OS from the application. The scalar types used at the NuttX interface
include:

Hidden Interface Structures
---------------------------

Several of the types used to interface with NuttX are structures that
are intended to be hidden from the application. From the standpoint of
the application, these structures (and structure pointers) should be
treated as simple handles to reference OS resources. These hidden
structures include:

In order to maintain portability, applications should not reference
specific elements within these hidden structures. These hidden
structures will not be described further in this user\'s manual.

Access to the `errno` Variable
------------------------------

A pointer to the thread-specific `errno` value is available through a
function call:

User Interface Structures
-------------------------

:c`main_t`{.interpreted-text role="type"} defines the type of a task
entry point. :c`main_t`{.interpreted-text role="type"} is declared in
`sys/types.h`.

This structure is used to pass scheduling priorities to and from NuttX:

``` {.c}
struct sched_param
{
 int sched_priority;
};
```

This structure is used to pass timing information between the NuttX and
a user application:

``` {.c}
struct timespec
{
 time_t tv_sec;  /* Seconds */
 long   tv_nsec; /* Nanoseconds */
};
```

This structure is used to communicate message queue attributes between
NuttX and a MoBY application:

``` {.c}
struct mq_attr {
 size_t       mq_maxmsg;   /* Max number of messages in queue */
 size_t       mq_msgsize;  /* Max message size */
 unsigned     mq_flags;    /* Queue flags */
 size_t       mq_curmsgs;  /* Number of messages currently in queue */
};
```

The following structure defines the action to take for given signal:

``` {.c}
struct sigaction
{
 union
 {
   void (*_sa_handler)(int);
   void (*_sa_sigaction)(int, siginfo_t *, void *);
 } sa_u;
 sigset_t           sa_mask;
 int                sa_flags;
};
#define sa_handler   sa_u._sa_handler
#define sa_sigaction sa_u._sa_sigaction
```

The following types is used to pass parameters to/from signal handlers:

``` {.c}
typedef struct siginfo
{
 int          si_signo;
 int          si_code;
 union sigval si_value;
} siginfo_t;
```

This defines the type of the struct siginfo si\_value field and is used
to pass parameters with signals.

``` {.c}
union sigval
{
 int   sival_int;
 void *sival_ptr;
};
```

The following is used to attach a signal to a message queue to notify a
task when a message is available on a queue.

``` {.c}
struct sigevent
{
 int          sigev_signo;
 union sigval sigev_value;
 int          sigev_notify;
};
```
