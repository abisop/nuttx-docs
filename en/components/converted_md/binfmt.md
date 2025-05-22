Binary Loader {#binfmt}
=============

The purpose of a *binary loader* is to load and execute modules in
various *binary formats* that reside in a file system. Loading refers
instantiating the binary module in some fashion, usually copy all or
some of the binary module into memory and then linking the module with
other components. In most architectures, it is the base FLASH code that
is the primary component that the binary module must link with because
that is where the RTOS and primary tasks reside. Program modules can
then be executed after they have been loaded.

**Binary Formats**. The binary loader provides generic support for
different binary formats. It supports a *registration interface* that
allows the number of support binary formats to be loaded at run time.
Each binary format provides a common, interface for use by the binary
loader. When asked to load a binary, the binary loader will query each
registered binary format, providing it with the path of the binary
object to be loaded. The binary loader will stop when first binary
format the recognizes the binary object and successfully loads it or
when all registered binary formats have attempt loading the binary
object and failed.

At present, the following binary formats are support by NuttX:

> -   **ELF**. Standard ELF formatted files.
> -   **NXFLAT**. NuttX NXFLAT formatted files. More information about
>     the NXFLAT binary format can be found in the `NXFLAT
>     documentation <nxflat>`{.interpreted-text role="ref"}.

**Executables and Libraries** The generic binary loader logic does not
care what it is that it being loaded. It could load an executable
program or a library. There are no strict rules, but a library will tend
to export symbols and a program will tend to import symbols: The program
will use the symbols exported by the library. However, at this point in
time, none of the supported binary formats support exporting of symbols.

**binfmt**. In the NuttX source code, the short name `binfmt` is used to
refer to the NuttX binary loader. This is the name of the directory
containing the binary loader and the name of the header files and
variables used by the binary loader.

The name `binfmt` is the same name used by the Linux binary loader.
However, the NuttX binary loader is an independent development and
shares nothing with the Linux binary loader other the same name and the
same basic functionality.

Binary Loader Interface
-----------------------

### Header Files

The interface to the binary loader is described in the header file
`include/nuttx/binfmt/binfmt.h`. A brief summary of the data structures
and interfaces prototyped in that header file are listed below.

### Data Structures

When a binary format registers with the binary loader, it provides a
pointer to a write-able instance of :c`binfmt_s`{.interpreted-text
role="struct"}.

### Function Interfaces

#### Binary format management

#### Basic module management

::: {.tip}
::: {.title}
Tip
:::

The function :c`exec`{.interpreted-text role="func"} is a convenience
function that wraps :c`load_module`{.interpreted-text role="func"} and
:c`exec_module`{.interpreted-text role="func"} into one call.
:::

#### `PATH` traversal logic

Release all resources set aside by envpath\_init when the handle value
was created. The handle value is invalid on return from this function.
Attempts to all :c`envpath_next`{.interpreted-text role="func"} or
:c`envpath_release`{.interpreted-text role="func"} with such a stale
handle will result in undefined (i.e., not good) behavior.

> param handle
>
> :   The handle value returned by :c`envpath_init`{.interpreted-text
>     role="func"}.

Symbol Tables
-------------

**Symbol Tables**. Symbol tables are lists of name value mappings: The
name is a string that identifies a symbol, and the value is an address
in memory where the symbol of that name has been positioned. In most
NuttX architectures symbol tables are required, as a minimum, in order
to dynamically link the loaded binary object with the base code on
FLASH. Since the binary object was separately built and separately
linked, these symbols will appear as *undefined* symbols in the binary
object. The binary loader will use the symbol table to look up the
symbol by its name and to provide the address associated with the symbol
as needed to perform the dynamic linking of the binary object to the
base FLASH code.

Some toolchains will prefix symbols with an underscore. To support these
toolchains the `CONFIG_SYMTAB_DECORATED` setting may be defined. This
will cause a leading underscore to be ignored on *undefined* symbols
during dynamic linking.

### Symbol Table Header Files

The interface to the symbol table logic is described in the header file
`include/nuttx/binfmt/symtab.h`. A brief summary of the data structures
and interfaces prototyped in that header file are listed below.

### Symbol Table Data Structures

### Symbol Table Function Interfaces

Configuration Variables
-----------------------

> -   `CONFIG_BINFMT_DISABLE`: By default, support for loadable binary
>     formats is built. This logic may be suppressed be defining this
>     setting.
> -   `CONFIG_BINFMT_CONSTRUCTORS`: Build in support for C++
>     constructors in loaded modules.
> -   `CONFIG_SYMTAB_ORDEREDBYNAME`: Symbol tables are order by name
>     (rather than value).
> -   `CONFIG_SYMTAB_DECORATED`: Symbols will have a leading underscore
>     in object files.

Additional configuration options may be required for the each enabled
binary format.
