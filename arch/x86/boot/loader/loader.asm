
BOOTSEG                 equ     0x7c0
SEGMENT_KERNEL_HEAD     equ     0x7e0
SEGMENT_KERNEL_SETUP    equ     0x800

[org 0x7c00]

    cli
    xor ax, ax,
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov sp, 0x7c00
    sti

load_bootsector:

    mov ax, SEGMENT_KERNEL_HEAD
    mov es, ax
    mov ch, 0   ; cylinder 0
    mov dh, 0   ; head 0
    mov cl, 2   ; sector 2

    mov ah, 0x02    ; read
    mov al, 1       ; a sector
    mov bx, 0       ; es:bx is buffer head addr
    mov dl, 0x00    ; drive A
    int 0x13

    jc error

load_kernel_setup:
    mov ax, SEGMENT_KERNEL_SETUP
    mov es, ax
    mov ch, 0   ; cylinder 0
    mov dh, 0   ; head 0
    mov cl, 3   ; sector 3

    mov ah, 0x02    ; read
    mov al, 1       ; a sector
    mov bx, 0       ; es:bx is buffer head addr
    mov dl, 0x00    ; drive A
    int 0x13

    jc error

    jmp SEGMENT_KERNEL_SETUP:0x0

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
