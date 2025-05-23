# <span class="title-ref">baremetal</span> Hello World in Rust

This example demonstrates how to create a simple "Hello World" program
in Rust for a bare-metal environment. The program is compiled using the
<span class="title-ref">rustc</span> compiler directly, without relying
on any operating system or standard library.

The key aspects of this example include:

  - **No Standard Library**: The program uses the
    <span class="title-ref">\#\!\[no\_std\]</span> attribute, which
    means it does not link against the standard library. This is
    essential for bare-metal programming where the standard library is
    not available.
  - **No Main Function**: The program uses the
    <span class="title-ref">\#\!\[no\_main\]</span> attribute, which
    indicates that the program does not have a standard
    <span class="title-ref">main</span> function. Instead, it defines a
    custom entry point.
  - **Panic Handler**: A custom panic handler is defined using the
    <span class="title-ref">\#\[panic\_handler\]</span> attribute. This
    handler is called when a panic occurs, and in this case, it enters
    an infinite loop to halt the program.
  - **C Interoperability**: The program uses the
    <span class="title-ref">extern "C"</span> block to declare the
    <span class="title-ref">printf</span> function from the C standard
    library. This allows the Rust program to call C functions directly.
  - **Entry Point**: The
    <span class="title-ref">hello\_rust\_main</span> function is the
    entry point of the program. It is marked with
    <span class="title-ref">\#\[no\_mangle\]</span> to prevent the Rust
    compiler from mangling its name, making it callable from C.
  - **Printing**: The program uses the
    <span class="title-ref">printf</span> function to print "Hello,
    Rust\!\!" to the console. The <span class="title-ref">printf</span>
    function is called using the <span class="title-ref">unsafe</span>
    block because it involves calling a C function.

This example is a great starting point for understanding how to write
and compile Rust programs for bare-metal environments, where you have
full control over the hardware and no operating system overhead.
