[org 0x7c00]


    xor ax, ax,
    mov ds, ax

    mov si, msg
ch_loop:
    lodsb
    or al, al
    jz hang
    mov ah, 0x0e
    int 0x10
    jmp ch_loop

hang:
    jmp hang

msg db 'hello world', 13, 10 ,10

times 510 - ($ - $$) db 0
    db 0x55
    db 0xaa
