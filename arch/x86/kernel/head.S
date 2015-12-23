.section .text

//#include <asm/sections.h>

#define PAGE_OFFSET     0xc0000000

#define KPMDS   1 // number of kernel page directoris
#define PAGE_SIZE   4096

#define PGD_IDENT_ATTR  0x001 // PRESENT
#define PTE_IDENT_ATTR  0x003 // PRESENT + RW

#define pa(X) ((X) - PAGE_OFFSET)

.global start_kernel
.global startup
startup:

    //TODO clean up BSS section

    xorl %ebx, %ebx
    //TODO setup paging 
    movl $pa(swapper_pg_table), %edi
    movl $pa(swapper_pg_dir), %edx

    // setup page table
    movl $0x00000003, %eax
    movl %eax, (%edi)
    addl $1, %edi
    addl $0x10000, %eax
    movl %eax, (%edi)

    // setup page directory
    movl $pa(swapper_pg_dir), %edi
    movl $pa(swapper_pg_table), %edx
//     shll %edx, %eax

//    orl %eax, $0x00000003

    call main

setup_idt:
    ret

.section ".bss.pg_dir", "aw"
    .align PAGE_SIZE
swapper_pg_dir:
    .fill 1024, 4, 0

swapper_pg_table:
    .fill 2, 4, 0

.section ".data.pg_table", "aw"
    .align PAGE_SIZE
