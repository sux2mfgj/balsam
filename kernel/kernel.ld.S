ENTRY(startup)
OUTPUT_ARCH(i386)
OUTPUT_FORMAT(elf32-i386)

#define LOAD_OFFSET 0xc0000000
#define LOAD_PHYSICAL_ADDR 0x00100000

SECTIONS
{
    . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
    _kernel_start = .;

    .text : AT(ADDR(.text) - LOAD_OFFSET){ 
        *(.text);
    }
    

    .data : AT(ADDR(.data) - LOAD_OFFSET){ 
        *(.data);
        *(.data.pg_dir);
    }

    .bss : AT(ADDR(.bss) - LOAD_OFFSET){
        *(.bss);
        *(.bss.pg_pmd);
    }

    _kernel_end = .;
}
