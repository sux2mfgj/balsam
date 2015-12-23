ENTRY(start_kernel)
OUTPUT_ARCH(i386)
OUTPUT_FORMAT(elf32-i386)

#define LOAD_OFFSET 0xc0000000
#define LOAD_PHYSICAL_ADDR 0x00100000
#define PAGE_SIZE 4096

SECTIONS
{
    . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;

    _kernel_start = .;

    .text : AT(ADDR(.text) - LOAD_OFFSET){ 
        *(.text);
    }

    . = ALIGN(PAGE_SIZE);
    .data : AT(ADDR(.data) - LOAD_OFFSET){ 
        *(.data.pg_dir);
        *(.data);
    }

    . = ALIGN(PAGE_SIZE);
    .bss : AT(ADDR(.bss) - LOAD_OFFSET){
        *(.bss.pg_pmd);
        *(.bss);
    }

    .brk : AT(ADDR(.brk) - LOAD_OFFSET){
        __brk_base = .;
        . += 64 * 1024;
        __brk_limit = .;
    }

    _kernel_end = .;
}
