Named Message Queue Interfaces
==============================

NuttX supports POSIX named message queues for inter-task communication.
Any task may send or receive messages on named message queues. Interrupt
handlers may send messages via named message queues.

> -   :c`mq_open`{.interpreted-text role="func"}
> -   :c`mq_close`{.interpreted-text role="func"}
> -   :c`mq_unlink`{.interpreted-text role="func"}
> -   :c`mq_send`{.interpreted-text role="func"}
> -   :c`mq_timedsend`{.interpreted-text role="func"}
> -   :c`mq_receive`{.interpreted-text role="func"}
> -   :c`mq_timedreceive`{.interpreted-text role="func"}
> -   :c`mq_notify`{.interpreted-text role="func"}
> -   :c`mq_setattr`{.interpreted-text role="func"}
> -   :c`mq_getattr`{.interpreted-text role="func"}
