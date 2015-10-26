
BOOTSEG                 equ     0x7c0
SEGMENT_KERNEL_HEAD     equ     0x7e0
SEGMENT_KERNEL_SETUP    equ     0x800

[org 0x8000]

bits 16

_start:
    cli
    mov ax, ds
    mov es, ax
    cld

    mov ss, ax
    mov sp, 0x7c00

    sti

enable_a20:

    call a20wait
    mov al, 0xd1
    out 0x64, al

    call a20wait
    mov al, 0xdf
    out 0x60, al

    call a20wait
    mov al, 0xff
    out 0x64, al

    call a20wait

mask_all_interrupt:
    
;mask all interrupt on the secondary PIC
    mov al, 0xff
    out 0xa1, al

;mask all interrupt on the main PIC
    mov al, 0xff
    out 0x21, al

setup_gdt:
    lgdt [gdtr]

;     jmp error

protected_mode_jump:
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp (code_desc - gdt):protected_code

fin:
    hlt    
    jmp fin

a20wait:
    in al, 0x64
    test al, 0x2
    jnz a20wait
    ret

; error:
;     mov si, msg
; text_loop:
;     lodsb
;     or al, al
;     jz fin
;     mov ah, 0x0e
;     int 0x10
;     jmp text_loop 

; msg db 'error occured', 0


gdt:
; null 
    dd 0
    dd 0

code_desc:
; code
    dw 0xffff   ; limit low
    dw 0        ; base low
    db 0        ; base middle
    db 10011010b; access 
    db 11001111b; granularity
    db 0        ; base high

data_desc:
; data
    dw 0xffff   ; limit low
    dw 0
    db 0
    db 10010010b;
    db 11001111b;
    db 0

gdtr:
    dw gdtr - gdt - 1
    dd gdt

bits 32
protected_code:
    hlt
