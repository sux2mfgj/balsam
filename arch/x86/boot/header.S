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
    
    /*
setup_video:
    movb $0x13, %al
    movb $0x00, %ah
    int $0x10
    */

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


    lgdt gdtr

# go to protected mode
    movl %cr0, %eax
    orb $X86_CR0_PE, %al
    movl %eax, %cr0

    jmp flush
flush:


    mov $__BOOT_CS, %eax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    mov %eax, %ss

copy_kernel:
    cld
    movl $REAL_MODE_IMAGE_BASE, %esi
    movl $PROTECTED_MODE_IMAGE_BASE, %edi
    movl $KERNEL_SIZE, %ecx
    rep movsd

    ljmpl $16, $PROTECTED_MODE_IMAGE_BASE

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

gdt:
    .word 0x0000, 0x0000, 0x0000, 0x0000
    .word 0xffff, 0x0000, 0x9b00, 0x00cf
    .word 0xffff, 0x0000, 0x9300, 0x00cf

gdtr:
    .word gdtr - gdt - 1
    .long gdt
