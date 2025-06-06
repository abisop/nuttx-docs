libxx
=====

This directory contains three C++ library:

-   A fragmentary C++ library that will allow to build only the simplest
    of C++ applications. In the deeply embedded world, that is probably
    all that is necessary.

    At present, only the following are supported here:

    ``` {.C}
    void *operator new(std::size_t nbytes)
    ```

    ``` {.C}
    void operator delete(void* ptr)
    ```

    ``` {.C}
    void operator delete[](void *ptr)
    ```

    ``` {.C}
    void __cxa_pure_virtual(void)
    ```

    ``` {.C}
    int __aeabi_atexit(void* object, void (*destroyer)(void*), void *dso_handle)
    ```

    ``` {.C}
    int __cxa_atexit(__cxa_exitfunc_t func, FAR void *arg, FAR void *dso_handle)
    ```

    This implementation is selected when neither of the following two
    options are enabled.

-   LLVM \"libc++\" C++ library (<http://libcxx.llvm.org/>) This
    implementation is selected with CONFIG\_LIBCXX=y.

-   uClibc++ C++ library (<http://cxx.uclibc.org/>) This implementation
    is selected with CONFIG\_UCLIBCXX=y.

operator new
------------

This operator should take a type of `size_t`. But size\_t has an unknown
underlying type. In the nuttx `sys/types.h` header file, `size_t` is
typed as `uint32_t` (which is determined by architecture-specific
logic). But the C++ compiler may believe that `size_t` is of a different
type resulting in compilation errors in the operator. Using the
underlying integer type instead of size\_t seems to resolve the
compilation issues. Need to REVISIT this.

Once some C++ compilers, this will cause an error:

    Problem:     "'operator new' takes size_t ('...') as first parameter"
    Workaround:  Add -fpermissive to the compilation flags
