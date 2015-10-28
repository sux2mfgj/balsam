.section .text
.global start_kernel
.global startup
startup:

    xorl %ebx, %ebx

    //TODO setup paging 

    call setup_idt

    jmp start_kernel

setup_idt:
    ret
