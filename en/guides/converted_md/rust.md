Rust in NuttX
=============

::: {.warning}
::: {.title}
Warning
:::

This guide is under development. Rust support in NuttX is experimental.
:::

Introduction
------------

NuttX is exploring Rust integration to provide memory safety guarantees
and modern language features while maintaining its small footprint and
real-time capabilities.

This guide covers:

-   Setting up Rust toolchain for NuttX development
-   Building Rust components with NuttX
-   Interoperability between Rust and C
-   Testing Rust components

Prerequisites
-------------

-   Rust toolchain installed (rustup recommended)
-   NuttX build environment configured
-   Basic knowledge of Rust and NuttX development

Supported Platforms
-------------------

-   AArch64
-   ARMv7-A
-   ARMv6-M
-   ARMv7-M
-   ARMv8-M
-   RISCV32
-   RISCV64
-   X86
-   X86\_64

Getting Started
---------------

1.  Install Rust toolchain and switch to nightly

Please refer to the official Rust installation guide for more details:
<https://www.rust-lang.org/tools/install>

``` {.bash}
rustup toolchain install nightly
rustup default nightly
```

2.  Prepare NuttX build environment

Please ensure that you have a working NuttX build environment, and with
the following PR merged or cherry-picked:

-   <https://github.com/apache/nuttx-apps/pull/2487>
-   <https://github.com/apache/nuttx/pull/15469>

3.  Enable essential kernel configurations

Please enable the following configurations in your NuttX configuration:

-   CONFIG\_SYSTEM\_TIME64
-   CONFIG\_FS\_LARGEFILE
-   CONFIG\_TLS\_NELEM = 16
-   CONFIG\_DEV\_URANDOM

The [rv-virt:nsh]{.title-ref} board using make as the build system is
recommended for testing Rust applications as it has been verified to
work with this configuration.

For [rv-virt:nsh]{.title-ref} board, you should disable
[CONFIG\_ARCH\_FPU]{.title-ref} configuration since RISCV32 with FPU is
not supported yet.

4.  Enable sample application

Please enable the sample application in your NuttX configuration: -
CONFIG\_EXAMPLES\_HELLO\_RUST\_CARGO

5.  Build and run the sample application

Build the NuttX image and run it on your target platform:

``` {.bash}
qemu-system-riscv32 -semihosting -M virt,aclint=on -cpu rv32 -smp 8 -bios nuttx/nuttx -nographic

NuttShell (NSH) NuttX-12.8.0
nsh> hello_rust_cargo
{"name":"John","age":30}
{"name":"Jane","age":25}
Deserialized: Alice is 28 years old
Pretty JSON:
{
"name": "Alice",
"age": 28
}
Hello world from tokio!
```

Congratulations! You have successfully built and run a Rust application
on NuttX.

Specifying Target CPU for Optimization
--------------------------------------

To optimize your Rust application for a specific CPU, you can use the
[RUSTFLAGS]{.title-ref} environment variable to specify the target CPU.
This can significantly improve performance by enabling CPU-specific
optimizations.

The [RUSTFLAGS]{.title-ref} environment variable is particularly useful
when you are working with CPUs that share the same Instruction Set
Architecture (ISA) but have different microarchitectures. For example,
both the Cortex-M33 and Cortex-M55 share the [thumbv8m.main]{.title-ref}
target name, but they have different performance characteristics and
features. By specifying the actual CPU core, you can take advantage of
the specific optimizations and features of the target CPU, leading to
better performance and efficiency.

For instance, if you are targeting a Cortex-M33, you would set the
[RUSTFLAGS]{.title-ref} environment variable as follows:

``` {.bash}
export RUSTFLAGS="-C target-cpu=cortex-m33"
```

And for a Cortex-M55, you would use:

``` {.bash}
export RUSTFLAGS="-C target-cpu=cortex-m55"
```

This ensures that the Rust compiler generates optimized code tailored to
the specific CPU core, rather than a generic ISA.

1.  Set the [RUSTFLAGS]{.title-ref} environment variable to include the
    [\--target-cpu]{.title-ref} flag:

``` {.bash}
export RUSTFLAGS="-C target-cpu=your_cpu_model"
```

Replace [your\_cpu\_model]{.title-ref} with the specific CPU model you
are targeting. For example, for an ARM Cortex-M4, you would use:

``` {.bash}
export RUSTFLAGS="-C target-cpu=cortex-m4"
```

2.  Build your NuttX image with the specified target CPU:

``` {.bash}
make
```

This will ensure that the Rust compiler generates optimized code for the
specified CPU.

Editor Integration
------------------

To enable proper IDE support for Rust development in NuttX, you\'ll need
to configure your editor to recognize the Rust project structure
correctly. This section focuses on VS Code with rust-analyzer, which is
the most popular setup.

1.  Create or update [.vscode/settings.json]{.title-ref} in your NuttX
    workspace:

``` {.json}
{
    "rust-analyzer.linkedProjects": [
        "nuttx-apps/examples/rust/slint/Cargo.toml"
    ]
}
```

2.  (Optional) If you\'re using a custom target specification, you can
    set the [rust-analyzer.cargo.target]{.title-ref} setting:

``` {.json}
{
    "rust-analyzer.cargo.target": "thumbv8m.main-nuttx-eabihf"
}
```

::: {.note}
::: {.title}
Note
:::

Since NuttX now supports the Rust standard library (std), specifying an
exact target triple is usually not necessary. The default host target
should work fine for most cases.

If you\'re working with a crate that tightly depends on the NuttX
target, you can specify the target triple as shown above to get more
accurate code analysis.
:::

This configuration helps rust-analyzer understand your project structure
and provide accurate code analysis, auto-completion, and other IDE
features while working with Rust code in NuttX.
