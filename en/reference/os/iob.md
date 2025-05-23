# I/O Buffer Management

NuttX supports generic I/O buffer management (IOB) logic. This logic was
originally added to support network I/O buffering, but has been
generalized to meet buffering requirements by all device drivers. At the
time of this writing, IOBs are currently used not only be networking but
also by logic in `drivers/syslog` and `drivers/wireless`. NOTE that some
of the wording in this section still reflects those legacy roots as a
part of the networking subsystem. This objectives of this feature are:

> 1.  Provide common I/O buffer management logic for all drivers,
> 2.  Support I/O buffer allocation from both the tasking and interrupt
>     level contexts.
> 3.  Use a fixed amount of pre-allocated memory.
> 4.  No costly, non-deterministic dynamic memory allocation.
> 5.  When the fixed number of pre-allocated I/O buffers is exhausted,
>     further attempts to allocate memory from tasking logic will cause
>     the task to block and wait until a an I/O buffer to be freed.
> 6.  Each I/O buffer should be small, but can be chained together to
>     support buffering of larger thinks such as full size network
>     packets.
> 7.  Support *throttling* logic to prevent lower priority tasks from
>     hogging all available I/O buffering.

## Configuration Options

  - `CONFIG_MM_IOB`  
    Enables generic I/O buffer support. This setting will build the
    common I/O buffer (IOB) support library.

  - `CONFIG_IOB_NBUFFERS`  
    Number of pre-allocated I/O buffers. Each packet is represented by a
    series of small I/O buffers in a chain. This setting determines the
    number of preallocated I/O buffers available for packet data. The
    default value is setup for network support. The default is 8 buffers
    if neither TCP/UDP or write buffering is enabled (neither
    `CONFIG_NET_TCP_WRITE_BUFFERS` nor `CONFIG_NET_TCP`), 24 if only
    TCP/UDP is enabled, and 36 if both TCP/UDP and write buffering are
    enabled.

  - `CONFIG_IOB_BUFSIZE`  
    Payload size of one I/O buffer. Each packet is represented by a
    series of small I/O buffers in a chain. This setting determines the
    data payload each preallocated I/O buffer. The default value is 196
    bytes.

  - `CONFIG_IOB_NCHAINS`  
    Number of pre-allocated I/O buffer chain heads. These tiny nodes are
    used as *containers* to support queueing of I/O buffer chains. This
    will limit the number of I/O transactions that can be *in-flight* at
    any give time. The default value of zero disables this features.
    These generic I/O buffer chain containers are not currently used by
    any logic in NuttX. That is because their other other specialized
    I/O buffer chain containers that also carry a payload of usage
    specific information. The default value is zero if nether TCP nor
    UDP is enabled (i.e., neither `CONFIG_NET_TCP` && \!`CONFIG_NET_UDP`
    or eight if either is enabled.

  - `CONFIG_IOB_THROTTLE`  
    I/O buffer throttle value. TCP write buffering and read-ahead buffer
    use the same pool of free I/O buffers. In order to prevent
    uncontrolled incoming TCP packets from hogging all of the available,
    pre-allocated I/O buffers, a throttling value is required. This
    throttle value assures that I/O buffers will be denied to the
    read-ahead logic before TCP writes are halted. The default 0 if
    neither TCP write buffering nor TCP read-ahead buffering is enabled.
    Otherwise, the default is 8.

  - `CONFIG_IOB_DEBUG`  
    Force I/O buffer debug. This option will force debug output from I/O
    buffer logic. This is not normally something that would want to do
    but is convenient if you are debugging the I/O buffer logic and do
    not want to get overloaded with other un-related debug output. NOTE
    that this selection is not available if DEBUG features are not
    enabled (`CONFIG_DEBUG_FEATURES`) with IOBs are being used to syslog
    buffering logic (`CONFIG_SYSLOG_BUFFER`).

## Throttling

An allocation throttle was added. I/O buffer allocation logic supports a
throttle value originally for read-ahead buffering to prevent the
read-ahead logic from consuming all available I/O buffers and blocking
the write buffering logic. This throttle logic is only needed for
networking only if both write buffering and read-ahead buffering are
used. Of use of I/O buffering might have other motivations for
throttling.

## Public Types

This structure represents one I/O buffer. A packet is contained by one
or more I/O buffers in a chain. The `io_pktlen` is only valid for the
I/O buffer at the head of the chain.

``` c
struct iob_s
{
  /* Singly-link list support */

  FAR struct iob_s *io_flink;

  /* Payload */

#if CONFIG_IOB_BUFSIZE < 256
  uint8_t  io_len;      /* Length of the data in the entry */
  uint8_t  io_offset;   /* Data begins at this offset */
#else
  uint16_t io_len;      /* Length of the data in the entry */
  uint16_t io_offset;   /* Data begins at this offset */
#endif
  uint16_t io_pktlen;   /* Total length of the packet */

  uint8_t  io_data[CONFIG_IOB_BUFSIZE];
};
```

This container structure supports queuing of I/O buffer chains. This
structure is intended only for internal use by the IOB module.

``` c
#if CONFIG_IOB_NCHAINS > 0
struct iob_qentry_s
{
  /* Singly-link list support */

  FAR struct iob_qentry_s *qe_flink;

  /* Payload -- Head of the I/O buffer chain */

  FAR struct iob_s *qe_head;
};
#endif /* CONFIG_IOB_NCHAINS > 0 */
```

The I/O buffer queue head structure.

``` c
#if CONFIG_IOB_NCHAINS > 0
struct iob_queue_s
{
  /* Head of the I/O buffer chain list */

  FAR struct iob_qentry_s *qh_head;
  FAR struct iob_qentry_s *qh_tail;
};
#endif /* CONFIG_IOB_NCHAINS > 0 */
```

## Public Function Prototypes

>   - :c`iob_initialize()`
>   - :c`iob_alloc()`
>   - :c`iob_tryalloc()`
>   - :c`iob_free()`
>   - :c`iob_free_chain()`
>   - :c`iob_add_queue()`
>   - :c`iob_tryadd_queue()`
>   - :c`iob_remove_queue()`
>   - :c`iob_peek_queue()`
>   - :c`iob_free_queue()`
>   - :c`iob_free_queue_qentry()`
>   - :c`iob_get_queue_size()`
>   - :c`iob_copyin()`
>   - :c`iob_trycopyin()`
>   - :c`iob_copyout()`
>   - :c`iob_clone()`
>   - :c`iob_clone_partial()`
>   - :c`iob_concat()`
>   - :c`iob_trimhead()`
>   - :c`iob_trimhead_queue()`
>   - :c`iob_trimtail()`
>   - :c`iob_pack()`
>   - :c`iob_contig()`
>   - :c`iob_count()`
>   - :c`iob_dump()`
