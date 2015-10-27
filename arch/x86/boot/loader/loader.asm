
BOOTSEG                 equ     0x7c0
SEGMENT_KERNEL_HEAD     equ     0x7e0
SEGMENT_KERNEL_SETUP    equ     0x800
SEGMENT_KERNEL_TEMP     equ     0x820

CYLS                    equ     10

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

load_kernel_main:
    mov ax, SEGMENT_KERNEL_TEMP
    mov es, ax

    mov ch, 0   ; cylinder 0
    mov dh, 0   ; head 0
    mov cl, 4   ; sector 4

.read_loop
    mov si, 0

.retry:
    mov ah, 0x02    ; read
    mov al, 1       ; a sector
    mov bx, 0       ; es:bx is buffer head addr
    mov dl, 0x00    ; drive A
    int 0x13

    jnc .next
    add si, 1
    cmp si, 5
    jae error
    mov ah, 0x00
    mov dl, 0x00
    int 0x13
    jmp .retry

.next:
    mov ax, es
    add ax, 0x0020
    mov es, ax
    add cl, 1
    cmp cl, 18
    jbe .read_loop
    mov cl, 1
    add dh, 1
    cmp dh, 2
    jb .read_loop
    mov dh, 0
    add ch, 1
    cmp ch, CYLS
    jb .read_loop

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
