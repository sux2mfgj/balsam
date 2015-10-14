#include <asm/processor-flags.h>
#include <asm/segment.h>

    .text
    .code16

    .global protected_mode_jump
protected_mode_jump: # void protected_mode_jump(void);

    movw $__BOOT_CS, %cx
    movw $__BOOT_DS, %di

    movl %cr0, %eax
    orb $X86_CR0_PE, %al
    movl %eax, %cr0

#	.byte	0x66, 0xea		# ljmpl opcode
#	.long	in_pm32			# offset
#	.word	__BOOT_CS		# segment
    
    jmp flush

flush:
    ret

