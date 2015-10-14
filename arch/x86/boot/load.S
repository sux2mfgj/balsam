TEMP_KERNEL_HEAD    = 0x0820
CYLINDERS           = 10
    
    .section ".realtext", "ax"
    .code16
    .global temp_load_kernel

temp_load_kernel:
    movw $TEMP_KERNEL_HEAD, %ax
    movw %ax,%es        
    movb $0, %ch # cylinder 0
    movb $0, %dh # head 0
    movb $4, %cl # sector 4

readloop:
    mov $0, %si

retry:
    movb $0x02, %ah # read 
    movb $1, %al # 1 sector
    movw $0, %bx  # ES:BX is the buffer  
    movb $0, %dl # drive a
    int $0x13

    jnc next

    add $1, %si
    cmp $5, %si
    jae error 

    mov $0x00, %ah
    mov $0x00, %dl
    int $0x13

next:

    movb $0x02, %ah
    addw $0x0020, %ax
    movw %ax, %es
    addb $1, %cl
    cmpb $18, %cl
    jbe readloop
    mov $1, %cl
    add $1, %dh
    cmp $2, %dh
    jb readloop
    
    mov $0, %dh
    add $1, %ch
    cmp $CYLINDERS, %ch
    jb readloop

    ret
    

error:
    hlt
    jmp error
