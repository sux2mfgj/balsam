ENTRY(startup)
OUTPUT_FORMAT(elf32-i386)

SECTIONS
{
    . = 0x00100000;
    _kernel_start = .;

    .text :{ 
        *(.text);
    }
    

    .data :{ 
        *(.data);
    }

    _kernel_end = .;
}
