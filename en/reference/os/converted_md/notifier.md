Notifier Chain {#notifier_chain}
==============

NuttX provides a callback list mechanism called *Notifier Chain*.
Notifier chain is essentially a list of callbacks used at certain times,
such as system asserting, powering off and restarting.

**Notifier chain** is very much like the Linux notifier chains, except
for some implementation differences.

Classes of Notifier Chain
-------------------------

There are currently two different classes of notifier.

### Atomic notifier chains

Atomic notifier chains: Chain callbacks run in interrupt/atomic context.
In Nuttx, callouts are allowed to block(In Linux, callouts in atomic
notifier chain are not allowed to block). One example of an Atomic
notifier chain is turning off FPU when asserting.

### Blocking notifier chains

Blocking notifier chains: Chain callbacks run in process context.
Callouts are allowed to block. One example of a blocking notifier chain
is when an orderly powering off is needed.

Common Notifier Chain Interfaces
--------------------------------

### Notifier Block Types

-   `struct notifier_block`. Defines one notifier callback entry.

### Notifier Chain Interfaces
