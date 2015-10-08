    .section ".setup_text", "ax"
real_mode_entry:
    cli
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw $0x0, %sp
    sti

    movw $msg, %si
    jmp msg_loop
    
msg_loop:
    lodsb
    andb %al, %al
    jz reboot
    movb $0xe, %ah
#movw $7, %bx 
    int $0x10
    jmp msg_loop

reboot:
	xor	%ax, %ax
	int	$0x16
	int	$0x19
	ljmpw $0xf000, $0xfff0	

    .section ".setup_data", "a"
msg:
    .ascii "in test\r\n" 
    .byte 0


