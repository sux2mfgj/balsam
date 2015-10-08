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
    movw $0x0000, %ax
	movb $0x80, %dl
	int	$0x13

	cld
# below function don't return.
    call main
    jmp hlt_loop

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
