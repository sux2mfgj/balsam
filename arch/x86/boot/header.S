#include <asm/processor-flags.h>
#include <asm/segment.h>

REAL_MODE_IMAGE_BASE        =   0x00008200
PROTECTED_MODE_IMAGE_BASE   =   0x00100000
KERNEL_SIZE                 =   0x1000


# 512 byte
# loader jump below
    .code16
    .section ".realtext", "ax"
    .global _start
_start:
    cli
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es

    movw $0x0000, %ax
    movw %ax, %ss
    movw $0x7c00, %sp
#    movw $0, %sp
    sti

    # reset all disk controller
reset_disk_controller:
    movw $0x0000, %ax
	movb $0x80, %dl
	int	$0x13

	cld

    call temp_load_kernel
    
#setup_video:
#    movb $0x13, %al
#    movb $0x00, %ah
#    int $0x10

enable_a20:
    cli

    call a20wait
    movb $0xd1, %al
    outb %al, $0x64

    call a20wait
    movb $0xdf, %al
    outb %al, $0x60

    call a20wait
    movb $0xff, %al
    outb %al, $0x64
    
    call a20wait

    jmp mask_all_interrupt

a20wait:
    inb $0x64, %al 
    testb $2, %al
    jnz a20wait
    ret

mask_all_interrupt:
# mask all interrupts on the secondary PIC
    movb 0xff, %al 
    outb %al, $0xa1

# mask all interrupts on the primary PIC
    movb 0xff, %al 
    outb %al, $0x21


    lgdt (gdtr)

# go to protected mode
    movl %cr0, %eax
    andl $0x7fffffff, %eax  # disable paging
    orb $X86_CR0_PE, %al    # go to protected mode
    movl %eax, %cr0

    hlt
    jmp flush
flush:

    .code32
    movl $1*8, %eax
    movl %eax, %ds
    movl %eax, %es
    movl %eax, %fs
    movl %eax, %gs
    movl %eax, %ss
    hlt


copy_kernel:
    cld
    movl $REAL_MODE_IMAGE_BASE, %esi
    movl $PROTECTED_MODE_IMAGE_BASE, %edi
    movl $KERNEL_SIZE, %ecx
    rep movsd

    ljmpl $2*8, $PROTECTED_MODE_IMAGE_BASE

# below function don't return.
#    call main

#    jmp msg_loop
#     movw $error, %si
#     movb $0x0, %dl

error:
    movw $error_msg, %si
    movb $0x0, %dl
msg_loop:
	lodsb
	andb	%al, %al
#	jz	reboot
    jz finish
	movb	$0xe, %ah
# movw	$7, %bx
	int	$0x10
	jmp	msg_loop

finish:
    hlt
    jmp finish

    .global hlt
io_hlt: #void io_hlt(void);
    hlt
    ret

    .section ".realdata", "a"
error_msg:
    .ascii "kernel panic"
    .byte 0


    .align 8
gdt:
    .skip 8, 0x00

    # Data Segment
    .word 0xffff, 0x0000, 0x9200, 0x00cf # read and writeable
    # Code Segment
    .word 0xffff, 0x0000, 0x9a00, 0x0047 # executable

    .word 0x0000

gdtr:
    .word 8*3-1
    .int gdt

#.code32
#    .p2align 4
#gdt:
#    // Null
#    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
#    // Code Segment
#    .byte 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
#    // Data Segment
#    .byte 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
#    
#    .byte 0
#
#gdtdesc:
#    .word 23
#gdtaddr:
#    .word gdt
