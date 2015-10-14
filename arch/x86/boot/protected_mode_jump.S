#include <asm/processor-flags.h>
#include <asm/segment.h>

    .section ".realtext", "ax"
    .code16

    .global protected_mode_jump
protected_mode_jump: # void protected_mode_jump(void);

    movw $__BOOT_CS, %cx
    movw $__BOOT_DS, %di

    movl %cr0, %eax
    orb $X86_CR0_PE, %al
    movl %eax, %cr0

    jmp flush

flush:
    ret

