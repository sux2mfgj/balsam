#.file "loader.S"
    .code16

BOOTSEG = 0x7c0

    .section ".bstext", "ax"

ljmp    $BOOTSEG, $start
start:
    cli
    xorw %ax, %ax
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw $0x7c00, %sp
    sti

load_bootsector:
    movw $0x800, %ax
    movw %ax,%es        
    movb $0, %ch # cylinder 0
    movb $0, %dh # head 0
    movb $1, %cl # sector 2

    movb $0x02, %ah # read 
    movb $1, %al # 1 sector
    movw $0, %bx  # ES:BX is the buffer  
    movb $0, %dl # drive a
    int $0x13
    jc error

check_bootflg:
    movw %es:510, %ax
    cmpw $0xaa55, %ax
    je load_kernel_setup
    jmp error

load_kernel_setup:
    movw $0x820, %ax
    movw %ax,%es        
    movb $0, %ch # cylinder 0
    movb $0, %dh # head 0
    movb $2, %cl # sector 2

    movb $0x02, %ah # read 
    movb $1, %al # 1 sector
    movw $0, %bx  # ES:BX is the buffer  
    movb $0, %dl # drive a
    int $0x13
    jc error

check_version:
    movw $0x800, %ax
    movw %ax, %es
    movw %es:0x206, %ax
    cmpw $0x20a, %ax
    je reboot
    jmp error

error:
    movw $msg, %si
msg_loop:
    lodsb
    andb %al, %al
    jz reboot
    movb $0xe, %ah
    movw $7, %bx 
    int $0x10
    jmp msg_loop

reboot:
	xor	%ax, %ax
	int	$0x16
	int	$0x19
	ljmpw $0xf000, $0xfff0	

    .section ".bsdata", "a"
msg:
    .ascii "error occured\r\n" 
    .byte 0

msg_ok:
    .ascii "ok\r\n" 
    .byte 0

    .section ".bootflag", "ax"
bootflag:
    .byte 0x55
    .byte 0xaa


