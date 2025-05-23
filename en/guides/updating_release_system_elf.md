# Updating a Release System with ELF Programs

<div class="warning">

<div class="title">

Warning

</div>

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Updating+a+Release+System+with+ELF+Programs>

</div>

<div class="warning">

<div class="title">

Warning

</div>

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Updating+a+Release+System+with+ELF+Programs>

</div>

You can enhance the functionality of your released embedded system by
adding ELF programs, which can be loaded from a file system. These
programs can be stored on an SD card or downloaded into on-board SPI
FLASH, allowing for easy updates or extensions to the system's firmware.

There are two ways you can accomplish this:

## Partially linked

This describes building the partially linked, relocatable ELF program
that depends on a symbol table provided by the base firmware in FLASH.

Reference: - See \[<span class="title-ref">Partially Linked ELF
Program\](\`Partially Linked ELF Program.md)s
\<partially\_linked\_elf\></span>

## Fully linked

This describes building a fully linked, relocatable ELF program that
does not depend on any symbol table information.

Reference: - See \[<span class="title-ref">Fully Linked ELF
Program\](\`Fully Linked ELF Program.md)s \<fully\_linked\_elf\></span>
