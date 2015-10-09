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

setup_video:
    movb $0x13, %al
    movb $0x00, %ah
    int $0x10

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

    jmp hlt_loop

a20wait:
    inb $0x64, %al 
    testb $2, %al
    jnz a20wait
    ret

# below function don't return.
#     call main

    movw $error, %si
    movb $0x0, %dl
#    jmp msg_loop

msg_loop:
	lodsb
	andb	%al, %al
#	jz	reboot
    jz hlt_loop
	movb	$0xe, %ah
# movw	$7, %bx
	int	$0x10
	jmp	msg_loop

.global hlt_loop
hlt_loop:
    hlt
    jmp hlt_loop

    .section ".realdata", "a"
error:
    .ascii "kernel panic"
    .byte 0
