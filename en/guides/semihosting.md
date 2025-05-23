# Semihosting

<div class="warning">

<div class="title">

Warning

</div>

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Semihosting>

</div>

Relevant files:

``` bash
fs/hostfs/
arch/arm/include/armv7-m/syscall.h
arch/arm/src/common/up_hostfs.c
```

Mounting:

``` bash
mount -t hostfs -o fs=/host/path /local/path
```
