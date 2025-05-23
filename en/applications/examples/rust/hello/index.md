# <span class="title-ref">hello</span> Example in Rust

This example demonstrates how to use Rust's powerful features in a NuttX
environment, including:

  - **JSON Serialization/Deserialization**: Using the popular
    <span class="title-ref">serde</span> and
    <span class="title-ref">serde\_json</span> crates to work with JSON
    data
  - **Async Runtime**: Demonstrates basic usage of the
    <span class="title-ref">tokio</span> async runtime
  - **C Interoperability**: Shows how to expose Rust functions to be
    called from C code

## Key Features

1.  JSON Handling
      - Defines a <span class="title-ref">Person</span> struct with
        <span class="title-ref">Serialize</span> and
        <span class="title-ref">Deserialize</span> traits
      - Serializes Rust structs to JSON strings
      - Deserializes JSON strings into Rust structs
      - Demonstrates pretty-printing JSON
2.  Async Runtime
      - Initializes a single-threaded
        <span class="title-ref">tokio</span> runtime
      - Runs a simple async task that prints a message
3.  C Interop
      - Exports <span class="title-ref">hello\_rust\_cargo\_main</span>
        function with <span class="title-ref">\#\[no\_mangle\]</span>
        for C calling
      - Uses <span class="title-ref">extern "C"</span> to define the C
        ABI

The example shows how Rust's modern features can be used in embedded
systems while maintaining compatibility with C-based systems.

This example serves as a foundation for building more complex Rust
applications in NuttX that need to handle JSON data and async
operations.
