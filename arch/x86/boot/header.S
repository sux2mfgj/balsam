

BOOTSEG = 0x07C0 #boot sector addr

    .code16
    .section ".bstext", "ax"
    .global bootsect_start

bootsect_start:
	ljmp	$BOOTSEG, $start2

start2:
	movw	%cs, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %ss
	xorw	%sp, %sp
	sti
	cld

	movw	$not_support_msg, %si

msg_loop:
	lodsb
	andb	%al, %al
	jz	reboot
	movb	$0xe, %ah
	movw	$7, %bx
	int	$0x10
	jmp	msg_loop

reboot:
	xorw	%ax, %ax
	int	$0x16
	int	$0x19

	ljmp	$0xf000,$0xfff0

	.section ".bsdata", "a"
not_support_msg:
	.ascii	"kernel is not supported\n"
	.byte	0

# The Real-Mode Kernel Header
    .section ".setup_sects", "a"
setup_sect_size:
    .byte 1

    .section ".boot_flag", "a"
boot_flag:	
    .byte 0x54
    .byte 0xaa
    
# 512 byte
# loader jump below
    .text
    .global _start

_start:
    # reset all disk controller
    movw	$0x0000, %ax
	movb	$0x80, %dl
	int	$0x13

# %ds = %es
    movw	%ds, %ax
	movw	%ax, %es
	cld

    movw $error, %si
    jmp msg_loop
	
exit:
    hlt
    jmp exit

    .data
error:
    .ascii "kernel panic!\r\n"
    .byte 0
