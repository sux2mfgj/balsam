#include <asm/processor-flags.h>

# 512 byte
# loader jump below
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

# setup gdt
#    lgdt gdtr_data

#    movl %cr0, %eax
#    orb $X86_CR0_PE, %al
#    movl %eax, %cr0 // error occred
#    jmp flush
#
#flush:
#    movw $0, %ax
#    movw %ax, %cs
#    movw %ax, %ds
#    movw %ax, %es
#    movw %ax, %fs
#    movw %ax, %gs
#    movw %ax, %ss


#    jmp finish
#    jmp error




# below function don't return.
    call main
    jmp finish

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

    .section ".realdata", "a"
error_msg:
    .ascii "kernel panic"
    .byte 0


