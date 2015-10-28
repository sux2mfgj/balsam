.section .text

#define PAGE_OFFSET     0xc0000000

#define KPMDS   1 // number of kernel page directoris
#define PAGE_SIZE   4096

#define PGD_IDENT_ATTR  0x001 //PRESENT

#define pa(X) ((X) - PAGE_OFFSET)

.global start_kernel
.global startup
startup:

    xorl %ebx, %ebx

    //TODO setup paging 

    call setup_idt

    jmp start_kernel

setup_idt:
    ret

.section ".bss.pg_pmd", "aw"
    .align PAGE_SIZE
swapper_pg_pmd:
    .fill 1024*KPMDS, 4, 0

.section ".data.pg_dir", "aw"
    .align PAGE_SIZE
swapper_pg_dir:
    .long 0, 0
    .long 0, 0
    .long swapper_pg_pmd + PGD_IDENT_ATTR, 0

