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
    movw $0x8000, %sp
    sti

    # reset all disk controller
    movw	$0x0000, %ax
	movb	$0x80, %dl
	int	$0x13

#	cld

    movw $error, %si
    jmp msg_loop

msg_loop:
	lodsb
	andb	%al, %al
#	jz	reboot
    jz hlt
	movb	$0xe, %ah
#movw	$7, %bx
	int	$0x10
	jmp	msg_loop


hlt:
    hlt
    jmp hlt

    .section ".realdata", "a"
error:
    .ascii "kernel panic!\r\n"
    .byte 0
