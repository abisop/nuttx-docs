# Named Message Queue Interfaces

NuttX supports POSIX named message queues for inter-task communication.
Any task may send or receive messages on named message queues. Interrupt
handlers may send messages via named message queues.

>   - :c`mq_open`
>   - :c`mq_close`
>   - :c`mq_unlink`
>   - :c`mq_send`
>   - :c`mq_timedsend`
>   - :c`mq_receive`
>   - :c`mq_timedreceive`
>   - :c`mq_notify`
>   - :c`mq_setattr`
>   - :c`mq_getattr`
