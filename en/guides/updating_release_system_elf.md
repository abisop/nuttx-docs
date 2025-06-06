Updating a Release System with ELF Programs
===========================================

Warning

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Updating+a+Release+System+with+ELF+Programs>

Warning

Migrated from:
<https://cwiki.apache.org/confluence/display/NUTTX/Updating+a+Release+System+with+ELF+Programs>

You can enhance the functionality of your released embedded system by
adding ELF programs, which can be loaded from a file system. These
programs can be stored on an SD card or downloaded into on-board SPI
FLASH, allowing for easy updates or extensions to the system\'s
firmware.

There are two ways you can accomplish this:

Partially linked
----------------

This describes building the partially linked, relocatable ELF program
that depends on a symbol table provided by the base firmware in FLASH.

Reference: - See \[[Partially Linked ELF Program\](\`Partially Linked
ELF Program.md)s \<partially\_linked\_elf\>]{.title-ref}

Fully linked
------------

This describes building a fully linked, relocatable ELF program that
does not depend on any symbol table information.

Reference: - See \[[Fully Linked ELF Program\](\`Fully Linked ELF
Program.md)s \<fully\_linked\_elf\>]{.title-ref}
