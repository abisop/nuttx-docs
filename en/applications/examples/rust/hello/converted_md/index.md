[hello]{.title-ref} Example in Rust
===================================

This example demonstrates how to use Rust\'s powerful features in a
NuttX environment, including:

-   **JSON Serialization/Deserialization**: Using the popular
    [serde]{.title-ref} and [serde\_json]{.title-ref} crates to work
    with JSON data
-   **Async Runtime**: Demonstrates basic usage of the
    [tokio]{.title-ref} async runtime
-   **C Interoperability**: Shows how to expose Rust functions to be
    called from C code

Key Features
------------

1.  JSON Handling
    -   Defines a [Person]{.title-ref} struct with
        [Serialize]{.title-ref} and [Deserialize]{.title-ref} traits
    -   Serializes Rust structs to JSON strings
    -   Deserializes JSON strings into Rust structs
    -   Demonstrates pretty-printing JSON
2.  Async Runtime
    -   Initializes a single-threaded [tokio]{.title-ref} runtime
    -   Runs a simple async task that prints a message
3.  C Interop
    -   Exports [hello\_rust\_cargo\_main]{.title-ref} function with
        [\#\[no\_mangle\]]{.title-ref} for C calling
    -   Uses [extern \"C\"]{.title-ref} to define the C ABI

The example shows how Rust\'s modern features can be used in embedded
systems while maintaining compatibility with C-based systems.

This example serves as a foundation for building more complex Rust
applications in NuttX that need to handle JSON data and async
operations.
