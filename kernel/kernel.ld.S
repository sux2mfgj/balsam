ENTRY(startup_32)
OUTPUT_ARCH(i386)
OUTPUT_FORMAT(elf32-i386)

#define __ASSEMBLY__
#include <asm-i386/thread_info.h>

#define LOAD_OFFSET 0xc0000000
#define LOAD_PHYSICAL_ADDR 0x00100000
#define PAGE_SIZE 4096

SECTIONS
{
    . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;

    _kernel_start = .;

    _test = .;
    .text : {
        *(.text)
    }
    _etext = .;

    . = ALIGN(16);

    . = ALIGN(THREAD_SIZE);
    .data.init_task : { *(.data.init_task)}

/*    .text : AT(ADDR(.text) - LOAD_OFFSET){ 
         *(.text);
     }*/

    .data : {
        *(.data)
    }
/*     . = ALIGN(PAGE_SIZE);
     .data : AT(ADDR(.data) - LOAD_OFFSET){ 
         *(.data);
     }*/


    . = ALIGN(4096);
    __bss_start = .;      /* BSS */
    .bss : {
          *(.bss.page_aligned);
          *(.bss);
                
    }
    . = ALIGN(4);
    __bss_stop = .;

    . = ALIGN(4096);
    pg0 = .;

/*    .brk : AT(ADDR(.brk) - LOAD_OFFSET){
        __brk_base = .;
        . += 64 * 1024;
        __brk_limit = .;
    }
    */

    _kernel_end = .;
}
