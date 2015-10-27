
BOOTSEG     equ     0x7c0

[org 0x7c00]

times 510 - ($ - $$) db 0
    db 0x55
    db 0xaa
