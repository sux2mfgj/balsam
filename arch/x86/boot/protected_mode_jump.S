#include <asm/processor-flags.h>
#include <asm/segment.h>
//#include <asm/string.h>

REAL_MODE_IMAGE_BASE        =   0x00008200
PROTECTED_MODE_IMAGE_BASE   =   0x00100000
KERNEL_SIZE                 =   0x1000

    .section ".realtext", "ax"
    .code16

    .global protected_mode_jump
protected_mode_jump: # void protected_mode_jump(void);

#movw $__BOOT_CS, %cx
#    movw $__BOOT_DS, %di
    jmp error

    

    movl %cr0, %eax
    orb $X86_CR0_PE, %al
    movl %eax, %cr0

    jmp flush

flush:
#    ljmp $2*8, $copy_kernel
copy_kernel:
    
    movl $__BOOT_CS, %eax
    movl %eax, %cs
    movl %eax, %ds
    movl %eax, %es
    movl %eax, %fs
    movl %eax, %gs

    cld
    movl $REAL_MODE_IMAGE_BASE, %esi
    movl $PROTECTED_MODE_IMAGE_BASE, %edi
    movl $KERNEL_SIZE, %ecx
    rep movsd

    jmp error

    ljmpl $2*8, $PROTECTED_MODE_IMAGE_BASE
#    ljmpl $2*8, $0x8200

    
loop:
    hlt
    jmp loop
#    ret

error:
    movw $error_msg, %si
    movb $0x0, %dl
msg_loop:
	lodsb
	andb	%al, %al
#	jz	reboot
    jz loop 
	movb	$0xe, %ah
# movw	$7, %bx
	int	$0x10
	jmp	msg_loop


error_msg:
    .ascii "kernel panic"
    .byte 0


