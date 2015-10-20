
BOOTSEG     equ     0x7c0

[org 0x7c00]

    cli
    xor ax, ax,
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov sp, 0x7c00
    sti

load_bootsector:

    mov ax, 0x820
    mov es, ax
    mov ch, 0
    mov dh, 0
    mov cl, 2

    mov ah, 0x02
    mov al, 1
    mov bx, 0
    mov dl, 0x00
    int 0x13

    jc error




    jmp hang

error:
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

msg db 'error occured', 0

times 510 - ($ - $$) db 0
    db 0x55
    db 0xaa
