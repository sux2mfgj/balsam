#define __ASSEMBLY__ 

#include <asm-i386/page.h>
#include <balsam/sched.h>
#include <asm/segment.h>
#include <asm/linkage.h>

.text

.global start_kernel
.global init_pg_tables_end
.global init_thread_union
        
#define INIT_MAP_BEYOND_END (128 * 1024)

ENTRY(startup_32)
    cld

    lgdt boot_gdt_descr - __PAGE_OFFSET
    movl $(__BOOT_DS), %eax
    movl %eax, %ds
    movl %eax, %es
    movl %eax, %fs
    movl %eax, %gs

page_pde_offset = (__PAGE_OFFSET >> 20);

    movl $(pg0 - __PAGE_OFFSET), %edi
    movl $(swapper_pg_dir - __PAGE_OFFSET), %edx
    movl $0x007, %eax // 0x007 = PRESENT + RW + USER
10:
    leal 0x007(%edi), %ecx
    movl %ecx, (%edx)
    movl %ecx, page_pde_offset(%edx)
    addl $4, %edx
    movl $1024, %ecx

11:
    stosl
    addl $0x1000, %eax
    loop 11b

    leal (INIT_MAP_BEYOND_END + 0x007)(%edi), %ebp
    cmpl %ebp, %eax
    jb 10b
    movl %edi, (init_pg_tables_end - __PAGE_OFFSET)

    // enable paging
    movl $swapper_pg_dir - __PAGE_OFFSET, %eax
    movl %eax, %cr3
    movl %cr0, %eax
    orl $0x80000000, %eax
    movl %eax, %cr0
    ljmp $__BOOT_CS, $1f

1:

    // setup stack pointer
    lss stack_start, %esp

    // initialize eflags
    pushl $0
    popfl


    call start_kernel

.section ".bss.page_aligned", "w"
ENTRY(swapper_pg_dir)
    .fill 1024, 4, 0

.data
//TODO
ENTRY(stack_start)
    .long init_thread_union + THREAD_SIZE // 8192
    .long __BOOT_DS



.align 1024
.global boot_gdt_descr
boot_gdt_descr:
    .word __BOOT_DS + 7
    .long boot_gdt - __PAGE_OFFSET


.global boot_gdt
boot_gdt:
    .fill GDT_ENTRY_BOOT_CS, 8, 0
    .quad 0x00cf9a000000ffff    /* kernel 4GB code at 0x00000000 */
    .quad 0x00cf92000000ffff    /* kernel 4GB data at 0x00000000 */


