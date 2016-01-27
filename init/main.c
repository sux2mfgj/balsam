#include <stdint.h>
#include <stdbool.h>

#include <asm-i386/pgtable.h>

#include <balsam/init.h>
#include <balsam/kernel.h>

void start_kernel(void)
{
    //TODO
    //- memblock_init (mm/memblock.c)
    //- page_address_init
    //- setup_arch
    //...
   
    printk("in start_kernel");

    setup_arch();

    printk("loop");
    while(true){
    }

}
