Building uClibc++
=================

Warning

Migrated from:
<https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=139629550>
and is probably outdated

A version of [uClibc++](http://cxx.uclibc.org/) has been ported to NuttX
and is available in the NuttX uClibc++ GIT repository at
[Bitbucket.org](https://bitbucket.org/nuttx/uclibc/) . This version of
uClibc++ was adapted for NuttX by the RGMP team.

This custom version of uClibc++ resides in the NuttX repository at:

> <https://bitbucket.org/nuttx/uclibc/>

rather than in the main NuttX source tree, due to licensing issues:
NuttX is licensed under the permissive, modified BSD License; uClibc++,
on the other hand, is licensed under the stricter GNU LGPL Version 3
license.

General build instructions are available in the uClibc++
[README.txt](https://bitbucket.org/nuttx/uclibc/src/master/README.txt)
file. Those instructions are not repeated here. This page documents
specific issues encountered when building this NuttX version of uClibc++
and how they are resolved.

Undefined Reference to `_impure_ptr`
------------------------------------

**Problem**

When building uClibc++, you may encounter an undefined reference to
`_impure_ptr` similar to:

``` {.none}
LD: nuttx
.../arm-none-eabi/lib/armv7e-m\libsupc++.a(vterminate.o): In function
`__gnu_cxx::__verbose_terminate_handler()`:
vterminate.cc:(.text._ZN9__gnu_cxx27__verbose_terminate_handlerEv+0xfc):
undefined reference to `_impure_ptr'
```

**Solution**

A definitive, elegant solution is not known, but the following
workaround has proven to work:

1.  Locate the directory where you can find `libsupc++`:

    ``` {.console}
    arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -print-file-name=libsupc++.a
    ```

2.  Go to that directory and save a copy of `vterminate.o` (in case you
    need it later):

    ``` {.console}
    cd <the-directory-containing-libsupc++.a>
    arm-none-eabi-ar.exe -x libsupc++.a vterminate.o
    ```

3.  Remove `vterminate.o` from the library. At build time, the uClibc++
    package will provide a usable replacement:

    ``` {.console}
    arm-none-eabi-ar.exe -d libsupc++.a vterminate.o
    ```

4.  At this point, NuttX should link with no problem. If you ever want
    to restore the original `vterminate.o` to `libsupc++.a`, you can do
    so by running:

    ``` {.console}
    arm-none-eabi-ar.exe rcs libsupc++.a vterminate.o
    ```

After removing `vterminate.o` from the standard library, the
uClibc++-provided `vterminate.o` becomes the active implementation and
prevents references to `_impure_ptr` from arising during linkage.

Note

Always exercise caution when modifying toolchain libraries. This
workaround is known to be effective but it replaces standard library
objects, which may have side effects in other toolchain usage scenarios.
