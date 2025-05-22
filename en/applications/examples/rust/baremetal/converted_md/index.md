[baremetal]{.title-ref} Hello World in Rust
===========================================

This example demonstrates how to create a simple \"Hello World\" program
in Rust for a bare-metal environment. The program is compiled using the
[rustc]{.title-ref} compiler directly, without relying on any operating
system or standard library.

The key aspects of this example include:

-   **No Standard Library**: The program uses the
    [\#!\[no\_std\]]{.title-ref} attribute, which means it does not link
    against the standard library. This is essential for bare-metal
    programming where the standard library is not available.
-   **No Main Function**: The program uses the
    [\#!\[no\_main\]]{.title-ref} attribute, which indicates that the
    program does not have a standard [main]{.title-ref} function.
    Instead, it defines a custom entry point.
-   **Panic Handler**: A custom panic handler is defined using the
    [\#\[panic\_handler\]]{.title-ref} attribute. This handler is called
    when a panic occurs, and in this case, it enters an infinite loop to
    halt the program.
-   **C Interoperability**: The program uses the [extern
    \"C\"]{.title-ref} block to declare the [printf]{.title-ref}
    function from the C standard library. This allows the Rust program
    to call C functions directly.
-   **Entry Point**: The [hello\_rust\_main]{.title-ref} function is the
    entry point of the program. It is marked with
    [\#\[no\_mangle\]]{.title-ref} to prevent the Rust compiler from
    mangling its name, making it callable from C.
-   **Printing**: The program uses the [printf]{.title-ref} function to
    print \"Hello, Rust!!\" to the console. The [printf]{.title-ref}
    function is called using the [unsafe]{.title-ref} block because it
    involves calling a C function.

This example is a great starting point for understanding how to write
and compile Rust programs for bare-metal environments, where you have
full control over the hardware and no operating system overhead.
