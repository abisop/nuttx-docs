# Disabling the Stack Dump During Debugging

<div class="warning">

<div class="title">

Warning

</div>

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Disabling+the+Stack+Dump+During+Debugging>

</div>

The stack dump routine can clutter the output of GDB during debugging.
To disable it, set this configuration option in the defconfig file of
the board configuration:

``` c
CONFIG_ARCH_STACKDUMP=n
```
