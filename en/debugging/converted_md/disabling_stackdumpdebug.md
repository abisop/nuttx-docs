Disabling the Stack Dump During Debugging
=========================================

::: {.warning}
::: {.title}
Warning
:::

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Disabling+the+Stack+Dump+During+Debugging>
:::

The stack dump routine can clutter the output of GDB during debugging.
To disable it, set this configuration option in the defconfig file of
the board configuration:

``` {.c}
CONFIG_ARCH_STACKDUMP=n
```
